package dcsc.mvc.service.board;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import dcsc.mvc.domain.board.Notice;

/**
 * 관리자
 * */
public interface NoticeService {
	/**
	 * 공지사항 등록 기능(관리자)
	 * @param Notice( 제목, 내용, 이미지)
	 * */
	void insertNotice(Notice notice);
	
	/**
	 * 공지사항 수정 기능(관리자)
	 * @param Notice( 제목, 내용, 이미지)
	 * */
	Notice updateNotice(Notice notice);
	
	/**
	 * 공지사항 삭제 기능
	 * 글번호(시퀀스)를 받고 공지사항을 삭제한다.(관리자)
	 * @param Long NoticeNo
	 * */
	void deleteNotice(Long noticeNo);
	
	/**
	 * 공지사항 게시판 상세보기 기능(강사&회원)
	 *  게시판에 제목을 클릭하면 상세보기로 들어오게 한다.
	 *  @param Long noticeNo
	 *  @return Notice
	 * */
	Notice selectByNotuceNo(Long noticeNo, boolean state);
	
	/**
	 * 공지사항 게시판 조회 기능(강사&회원)
	 * @return List<Notice>
	 * */
	List<Notice> selectAllNotice();
	
	/**
	 * 공지사항 게시판 조회 - 페이징 처리
	 * */
	Page<Notice> selectAllNotice(Pageable pageable) ;
	
	/**
	 * 공지사항 게시판 검색 기능(제목/내용)(강사&회원)
	 * @param String keyword
	 * @return List<Notice>
	 * */
	Page<Notice> selectByKeyword(String keyword, Pageable pageable);
	

	
}
