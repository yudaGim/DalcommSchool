package dcsc.mvc.service.board;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.jpa.JPQLQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;

import dcsc.mvc.domain.board.Answer;
import dcsc.mvc.domain.board.Ask;
import dcsc.mvc.domain.board.Faq;
import dcsc.mvc.domain.board.QAsk;
import dcsc.mvc.domain.user.Teacher;
import dcsc.mvc.repository.board.AnswerRepository;
import dcsc.mvc.repository.board.AskRepository;
import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class AskAnswerServiceImpl implements AskAnswerService {

	private final AnswerRepository answerRep;
	private final AskRepository askRep;
	
	private final JPAQueryFactory factory;
	
	/**
	 * 1대1 문의 등록하기(학생&선생님) 
	 * */
	@Override
	public void insertAsk(Ask ask) {
		
		Ask dbAsk=askRep.save(ask);
		if(dbAsk==null)throw new RuntimeException();
		  
		System.out.println("============dbAsk : "+dbAsk); 
	}
	
	
	
	/**
	 * 1대1 문의 수정하기 (학생&선생님)
	 * */ 
	@Override  
	public Ask updateAsk(Ask ask) {
		Ask dbAsk=askRep.findById(ask.getAskNo()).orElse(null);

		if(dbAsk==null)throw new RuntimeException("글번호 오류로 수정할 수 없습니다.");
		
		
		//수정완료
		dbAsk.setAskTitle(ask.getAskTitle());//제목
		dbAsk.setAskContent(ask.getAskContent());//문의내용
		dbAsk.setAskImg(ask.getAskImg());//이미지
 
		return dbAsk;
	}
	/**
	 * 1대1문의 삭제하기 (학생&선생님)
	 * */
	@Override
	public void deleteAsk(Long askNo) {
		
		Ask dbAsk=askRep.findById(askNo).orElse(null);
		
		if(dbAsk==null)throw new RuntimeException("글 번호 오류로 삭제 할 수 없습니다");
		
		askRep.deleteById(askNo);
		
	}
	/**
	 * 1대1문의 답변하는 기능(관리자)
	 * */
	@Override
	public Answer insertAnswer(Answer answer) {
		
		Answer dbAnswer=answerRep.save(answer);
		if(dbAnswer==null)throw new RuntimeException();
		
		
		Ask dbAsk=askRep.findById(answer.getAsk().getAskNo()).orElse(null);
		dbAsk.setAskComplete("T");
		
		return dbAnswer;

	}

	/**
	 * 1대1문의 전체 리스트 조회하는 기능(관리자) 
	 * */
	@Override
	public List<Ask> selectAll() {
		
		return askRep.findAll();
	}
	
	/**
	 * 1대1문의 전체리스트 조회 페이징 처리(관리자)
	 * */
	@Override
	public Page<Ask> selectAll(Pageable pageable) {
		
		/*
		 * BooleanBuilder booleanBuilder = new BooleanBuilder();
		 * 
		 * QAsk ask = QAsk.ask;
		 * 
		 * JPQLQuery<Ask> jpqlQuery = factory.selectFrom(ask).where(booleanBuilder)
		 * .offset(pageable.getOffset()).limit(pageable.getPageSize())
		 * .orderBy(ask.askNo.desc());
		 * 
		 * Page<Ask>list = new PageImpl<Ask>(jpqlQuery.fetch(), pageable,
		 * jpqlQuery.fetchCount());
		 */	
		return askRep.findAll(pageable);
		//return list;
	}
	
	/**
	 * 내가 쓴 1대1 문의 리스트 조회하기 기능(학생&선생님)
	 * --------동적쿼리
	 * */
	/*
	 * @Override public List<Ask> selectById(String id) {
	 * 
	 * BooleanBuilder booleanBuilder = new BooleanBuilder();
	 * 
	 * QAsk ask = QAsk.ask; booleanBuilder.and(ask.teacher.teacherId.eq(id));
	 * booleanBuilder.or(ask.student.studentId.eq(id));
	 * 
	 * Iterable<Ask> iterable = askRep.findAll(booleanBuilder);
	 * 
	 * List<Ask> list = Lists.newArrayList(iterable);
	 * 
	 * 
	 * return list; }
	 */
	/**
	 * 내가 쓴 1대1 문의 리스트 조회하기 기능(학생&선생님)
	 * --------동적쿼리(페이징처리)
	 * */
	@Override  
	public Page<Ask> selectById(String id, Pageable pageable) {
		
		BooleanBuilder booleanBuilder = new BooleanBuilder();
		
		QAsk ask = QAsk.ask; 
		
		booleanBuilder.and(ask.teacher.teacherId.eq(id));
		booleanBuilder.or(ask.student.studentId.eq(id));
		
		/*
		 * Iterable<Ask> iterable = askRep.findAll(booleanBuilder);
		 * 
		 * List<Ask> list = Lists.newArrayList(iterable);
		 */
		JPQLQuery<Ask> jpqlQuery = factory.selectFrom(ask).where(booleanBuilder)
									.offset(pageable.getOffset()).limit(pageable.getPageSize())
									.orderBy(ask.askNo.desc());
	
		Page<Ask>list = new PageImpl<Ask>(jpqlQuery.fetch(), pageable, jpqlQuery.fetchCount());
		
		return list;
	} 
	
	
	/**
	 * 1대1 문의 상세보기  기능(학생&선생님)
	 * */
	@Override
	public Ask selectByAskNo(Long askNo) {
		Ask dbAsk=askRep.findById(askNo).orElse(null);
		
		if(dbAsk==null)new RuntimeException("상세보기에 오류가 발생함!");
		
		return dbAsk;
	}
	

	/**
	 * 1대1 문의 미답변 리스트(관리자)
	 * */
	@Override
	public Page<Ask> askUnanswerList(Pageable pageable){
	
		return askRep.findByAsk(pageable); 
	}
	
	/**
	  * 1대1문의 검색하기(관리자)
	  * */
	@Override
	public Page<Ask> selectBykeyword(String keyword,Pageable pageable){
		BooleanBuilder booleanBuilder = new BooleanBuilder();
		QAsk ask = QAsk.ask;
		booleanBuilder.and(ask.askContent.like("%"+keyword+"%"));
		booleanBuilder.or(ask.askTitle.like("%"+keyword+"%"));
		JPQLQuery<Ask> jpqlQuery = factory.selectFrom(ask).where(booleanBuilder)
				.offset(pageable.getOffset()).limit(pageable.getPageSize());

		Page<Ask> list = new PageImpl<Ask>(jpqlQuery.fetch(), pageable, jpqlQuery.fetch().size());
		
		
		return list;
	}
	
	/**
	  * 1대1 문의 카테고리 별 리스트 조회(관리자)
	  * */
	@Override
	public Page<Ask> askCategory(Long askCategoryId, Pageable pageable){
		
		BooleanBuilder booleanBuilder = new BooleanBuilder();
		QAsk ask = QAsk.ask;
		
//		booleanBuilder.and(ask.teacher.teacherId.eq(id));
//		booleanBuilder.or(ask.student.studentId.eq(id));
//		
		booleanBuilder.and(ask.askCategory.askCategoryId.eq(askCategoryId));
		
		JPQLQuery<Ask> query = factory.selectFrom(ask)
				.where(booleanBuilder)
				.orderBy(ask.askNo.desc())
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize());
		
		Page<Ask> list = new PageImpl<Ask>(query.fetch(), pageable, query.fetch().size());
		
		return list;
	}
}
