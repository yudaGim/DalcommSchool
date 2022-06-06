package dcsc.mvc.service.classes;

import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.querydsl.jpa.impl.JPAQueryFactory;

import dcsc.mvc.domain.classes.Book;
import dcsc.mvc.domain.classes.BookState;
import dcsc.mvc.domain.classes.ClassSchedule;
import dcsc.mvc.domain.coupon.Coupon;
import dcsc.mvc.domain.coupon.IssueCoupon;
import dcsc.mvc.domain.user.Teacher;
import dcsc.mvc.repository.classes.BookRepository;
import dcsc.mvc.repository.classes.ClassScheduleRepository;
import dcsc.mvc.repository.coupon.CouponRepository;
import dcsc.mvc.repository.coupon.IssueCouponRepository;
import dcsc.mvc.repository.user.TeacherRepository;
import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class BookServiceImpl implements BookService {
	private final BookRepository bookRepository;
	private final ClassScheduleRepository classScheduleRepository;
	private final IssueCouponRepository issueCouponRepository;
	private final TeacherRepository teacherRepository;

	/**
	 * 클래스 예약 등록
	 * @param Book(학생ID, 클래스ID, 일정ID, 쿠폰번호, 인원 수, 수강자 이름, 전화번호)
	 * */
	@Override
	public void insert(Book book) {
		bookRepository.save(book);
		
		ClassSchedule schedule = classScheduleRepository.findById(book.getClassSchedule().getScheduleId()).orElse(null);
		schedule.setLeftSeat(schedule.getLeftSeat() - book.getBookSeat());
		
		if(book.getIssueCoupon() != null && book.getIssueCoupon().getIssueNo() > 0L) {
			IssueCoupon issueCoupon = issueCouponRepository.findById(book.getIssueCoupon().getIssueNo()).orElse(null);
			issueCoupon.setIssueUsable("T");
		}
	}

	/**
	 * 클래스 예약 일정 변경
	 * @param Long bookId, Long scheduleId
	 * */
	@Override
	public void updateSchedule(Long bookId, Long scheduleId) {
		Book book = bookRepository.findById(bookId).orElse(null);
		
		if(book == null) throw new RuntimeException("예약 내역이 존재하지 않습니다.");
		
		ClassSchedule schedule = classScheduleRepository.findById(scheduleId).orElse(null);
		
		if(schedule == null) throw new RuntimeException("변경하려는 일정이 존재하지 않습니다");
		
		if(book.getBookSeat() > schedule.getLeftSeat()) throw new RuntimeException("해당 일정의 수강 가능 인원이 부족합니다");
		if(schedule.getScheduleDate().before(new Date())) throw new RuntimeException("선택한 일정의 수강일이 지나 변경할 수 없습니다");
		
		// 변경 이전 일정 인원 변경
		ClassSchedule scheduleBefore = classScheduleRepository.findById(book.getClassSchedule().getScheduleId()).orElse(null);
		scheduleBefore.setLeftSeat(scheduleBefore.getLeftSeat() + book.getBookSeat());
		
		// 변경 이후 일정 인원 변경
		schedule.setLeftSeat(schedule.getLeftSeat() - book.getBookSeat());

		book.setClassSchedule(schedule);
	}

	/**
	 * 클래스 예약 상태 체험 완료로 변경
	 * @param Long bookId
	 * */
	@Override
	public void updateFinish(Long bookId) {
		Book book = bookRepository.findById(bookId).orElse(null);
		
		if(book == null) throw new RuntimeException("예약 내역이 존재하지 않습니다.");
		
		book.setBookState(new BookState(2L, null));
		
		int profit = book.getTotalPrice();
		
		Teacher teacher = teacherRepository.findById(book.getClasses().getTeacher().getTeacherId()).orElse(null);
		
		teacher.setTotalProfit(teacher.getTotalProfit() + profit);
		teacher.setAdjustable(teacher.getAdjustable() + profit);
	}

	/**
	 * 클래스 예약 취소
	 * @param String bookId
	 * */
	@Override
	public void deleteBook(Long bookId) {
		Book book = bookRepository.findById(bookId).orElse(null);
		
		if(book == null) throw new RuntimeException("예약 내역이 존재하지 않습니다.");
		
		ClassSchedule schedule = classScheduleRepository.findById(book.getClassSchedule().getScheduleId()).orElse(null);
		schedule.setLeftSeat(schedule.getLeftSeat() + book.getBookSeat());

		book.setBookState(new BookState(3L, null));
	}
	
	/**
	 * 예약ID로 예약 조회
	 * @param Long bookId
	 * @return Book
	 * */
	@Override
	public Book selectByStudentId(Long bookId) {
		Book book = bookRepository.findById(bookId).orElse(null);
		
		if(book == null) throw new RuntimeException("예약 내역이 존재하지 않습니다.");
		
		return book;
	}
	
	/**
	 * 학생ID로 예약 조회
	 * @param String studentId
	 * @return List<Book>
	 * */
	@Override
	public List<Book> selectByStudentId(String studentId) {
		List<Book> list = bookRepository.findByStudentStudentIdEquals(studentId);
		return list;
	}
	
	/**
	 * 강사ID로 예약 조회
	 * @param String teacherId
	 * @return List<Book>
	 * */
	@Override
	public List<Book> selectByTeacherId(String teacherId) {
		List<Book> list = bookRepository.findByClassesTeacherTeacherIdEquals(teacherId);
		return list;
	}
	
	/**
	 * 클래스ID로 예약 조회
	 * @param Long classId
	 * @return List<Book>
	 * */
	@Override
	public List<Book> selectByClassId(Long classId) {
		List<Book> list = bookRepository.findByClassesClassIdEquals(classId);
		return list;
	}
	
	/**
	 * 일정ID로 예약 조회
	 * @param Long scheduleId
	 * @return List<Book>
	 * */
	@Override
	public List<Book> selectByScheduleId(Long scheduleId) {
		List<Book> list = bookRepository.findByClassScheduleScheduleIdEquals(scheduleId);
		return list;
	}

}
