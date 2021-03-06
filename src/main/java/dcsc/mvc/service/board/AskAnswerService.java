package dcsc.mvc.service.board;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import dcsc.mvc.domain.board.Answer;
import dcsc.mvc.domain.board.Ask;
import dcsc.mvc.domain.board.Faq;

/**
 * 1대1문의
 * */
public interface AskAnswerService {
	
	/**
	 * 1대1 문의 등록하기(강사&회원)
	 * @param Ask(글번호, (강사&회원)ID, 제목, 카테고리,문의내용, 이미지)
	 * */
	void insertAsk(Ask ask);
	
	/**
	 * 1대1 문의 수정하기(강사&회원)
	 *  상세보기 페이지로 이동한다.
	 *  @param Ask(글번호, (강사&회원)ID, 제목, 카테고리, 문의내용, 이미지)
	 * */
	Ask updateAsk(Ask ask);
	
	/**
	 * 1대1 문의 삭제하기(강사&회원) 
	 * @param Long askNo 
	 * */
	void deleteAsk(Long askNo);
	 
	/**
	 * 1대1 문의 답변하는 기능(관리자)
	 * @param Answer(답변글번호, 글번호, 답변내용, 등록일자)
	 * */
	Answer insertAnswer(Answer answer);
	
	/**
	 * 1대1문의 전체 리스트 조회하는 기능(관리자)
	 * @return List<Ask>
	 * */
	List<Ask> selectAll();
	
	/**
	 * 1대1문의 전체리스트 조회기능 페이징처리(관리자)
	 * */
	Page<Ask> selectAll(Pageable pageable);
	
	/**
	 * 내가 쓴 1대1 문의 리스트 조회기능 페이징 처리
	 * */
	
	Page<Ask> selectById(String id, Pageable pageable);
	
	/**
	 * 내가 쓴 1대1 문의 리스트 조회기능(강사&회원)
	 * @return List<Ask>
	 * */
	//List<Ask> selectById(String id);
	
	/**
	 * 1대1 문의 상세보기(강사&회원)
	 * @param Long askNo
	 * @return Ask
	 * */
	Ask selectByAskNo(Long askNo);
	
	
	/**
	 * 1대1 문의 미답변 리스트(관리자)
	 * */
	public Page<Ask> askUnanswerList(Pageable pageable);
	
	/**
	 * 1대1문의 검색하기(관리자)
	 * */
	Page<Ask> selectBykeyword(String keyword, Pageable pageable);

	/**
	  * 1대1 문의 카테고리 별 리스트 조회(관리자)
	  * */
	Page<Ask> askCategory(Long askCategoryId, Pageable pageable);

}
