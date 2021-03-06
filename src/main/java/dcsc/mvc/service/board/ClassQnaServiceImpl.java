package dcsc.mvc.service.board;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import dcsc.mvc.domain.board.ClassQna;
import dcsc.mvc.domain.board.ClassReply;
import dcsc.mvc.domain.classes.Classes;
import dcsc.mvc.domain.user.Student;
import dcsc.mvc.repository.board.ClassQnaReposiroty;
import dcsc.mvc.repository.board.ClassReplyReposiroty;
import dcsc.mvc.repository.classes.ClassesRepository;
import dcsc.mvc.repository.user.StudentRepository;
import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class ClassQnaServiceImpl implements ClassQnaService {
	
	private final ClassQnaReposiroty classQnaRep;
	private final ClassReplyReposiroty classReplyRep;
	
	
	/**
	 * 전체검색(관리자)
	 * */
	@Override
	public List<ClassQna> selectAllQna() {
		List<ClassQna> list = classQnaRep.findAll();
		System.out.println(list);
		return list;
	}
	
	/**
	 * 전체검색(관리자) - 페이징처리
	 * */
	@Override
	public Page<ClassQna> selectAllQna(Pageable Pageable) {
		
		return classQnaRep.findAll(Pageable);
	}

	/**
	 * Q&A 등록하기
	 * */
	@Override
	public void insertQuestion(ClassQna classQna) {
		classQnaRep.save(classQna);
	}

	/**
	 * Q&A 수정하기
	 * */
	@Override
	public void updateQuestion(ClassQna classQna) {
		ClassQna dbQna = classQnaRep.findById(classQna.getQnaId()).orElse(null);
		
		if(dbQna==null) {
			throw new RuntimeException("Q&A 문의글 번호 오류로 수정되지 않았습니다.");
		}
		
		dbQna.setQnaTitle(classQna.getQnaTitle());
		dbQna.setQnaContent(classQna.getQnaContent());
		
		if(classQna.getSecretState() != null) {
			dbQna.setSecretState(classQna.getSecretState());
		} else {
			dbQna.setSecretState("F");
		}

	}

	/**
	 * Q&A 삭제하기
	 * */
	@Override
	public void deleteQuestion(Long qnaId) {
		ClassQna dbQna = classQnaRep.findById(qnaId).orElse(null);
		
		if(dbQna==null) {
			throw new RuntimeException("글번호 오류로 삭제되지 않았습니다.");
		}
		
		classQnaRep.deleteById(qnaId);
	}

	/**
	 * 클래스ID로 Q&A 전체조회
	 * */
	@Override
	public List<ClassQna> selectByClassId(Long classId) {
		List<ClassQna> list = classQnaRep.findByClassesClassIdEquals(classId);
		return list;
	}

	/**
	 * 클래스ID로 Q&A 전체조회 - 페이징
	 * */
	@Override
	public Page<ClassQna> selectByClassId(Long classId, Pageable pageable) {
		
		return classQnaRep.findByClassesClassIdEquals(classId, pageable);
	}
	
	/**
	 * 강사ID 로 Q&A 전체조회
	 * */
	@Override
	public List<ClassQna> selectByTeacherId(String teacherId) {
		/*Student student = studentRepository.findById(teacherId).orElse(null);
		List<ClassQna> list = student.getQnaList();
		return list;*/
		
		List<ClassQna> list = classQnaRep.findByClassesTeacherTeacherIdEquals(teacherId);
		return list;
	}
	
	/**
	 * 강사ID 로 Q&A 전체조회 - 페이징
	 * */
	@Override
	public Page<ClassQna> selectByTeacherId(String teacherId, Pageable pageable) {
		
		return classQnaRep.findByClassesTeacherTeacherIdEquals(teacherId, pageable);
	}

	/**
	 * qna 상세보기
	 * */
	@Override
	public ClassQna selectByQnaId(Long qnaId) {
		ClassQna classQna = classQnaRep.findById(qnaId).orElse(null);
		if(classQna==null) {
			new RuntimeException("Q&A 상세보기에 오류가 발생했습니다.");
		}
		return classQna;
	}

	/**
	 * 블라인드처리
	 * */
	@Override
	public void updateBlind(Long qnaId ,String blindState) {
		ClassQna dbQna = classQnaRep.findById(qnaId).orElse(null);
		//ClassQna dbQna = classQnaRep.updateBlind(blindState , qnaId);
		if(dbQna==null) {
			throw new RuntimeException("블라인드 처리를 하는 도중 오류가 발생했습니다.");
		}

		dbQna.setBlindState(blindState);
	}

	/**
	 * Q&A 댓글 등록
	 * */
	@Override
	public void insertReply(ClassReply classReply) {
		classReplyRep.save(classReply);
		ClassQna dbQna = classQnaRep.findById(classReply.getClassQna().getQnaId()).orElse(null);
		dbQna.setQnaComplete("T");
		

	}

	/**
	 * Q&A 댓글 수정
	 * */
	@Override
	public void updateReply(ClassReply classReply) {
		ClassReply dbReply = classReplyRep.findById(classReply.getReplyId()).orElse(classReply);
		if(dbReply==null) {
			throw new RuntimeException("Q&A 답변글 번호 오류로 수정되지 않았습니다.");
		}
		dbReply.setReplyContent(classReply.getReplyContent());
		
	}

	/**
	 * Q&A 댓글 삭제
	 * */
	@Override
	public void deleteReply(Long replyId) {
		ClassReply dbReply = classReplyRep.findById(replyId).orElse(null);
		
		if(dbReply==null) {
			throw new RuntimeException("글번호 오류로 삭제되지 않았습니다.");
		}
		
		classReplyRep.deleteById(replyId);
		
		Long qnaId = dbReply.getClassQna().getQnaId();
		
		ClassQna dbQna = classQnaRep.findById(qnaId).orElse(null);
		System.out.println("dbQna.getQnaId()="+dbQna.getQnaId());
		dbQna.setQnaComplete("F");
		
	}

	/**
	 * qnaId로 답글 조회
	 * */
	@Override
	public ClassReply selectByReplyQnaId(Long qnaId) {
		ClassReply classReply = classReplyRep.findByClassQnaQnaIdEquals(qnaId);
		return classReply;
	}

	/**
	 * 클래스 Q&A 댓글 상세조회(댓글 id 로 조회)
	 * */
	@Override
	public ClassReply selectByReplyId(Long replyId) {
		ClassReply classReply = classReplyRep.findById(replyId).orElse(null);
		
		if(classReply==null) {
			new RuntimeException("댓글 상세보기에 오류가 발생했습니다.");
		}
		return classReply;
	}


	/**
	 * 학생ID로 클래스 Q&A 검색
	 * */
	@Override
	public List<ClassQna> selectByStudentId(String studentId) {
		List<ClassQna> list = classQnaRep.findByStudentStudentIdEquals(studentId);
		return list;
	}

	/**
	 * 학생ID로 클래스 Q&A 검색 - 페이징처리
	 * */
	@Override
	public Page<ClassQna> selectByStudentId(String studentId, Pageable pageable) {
		
		return classQnaRep.findByStudentStudentIdEquals(studentId, pageable);
	}

	

	

	

	
	

}
