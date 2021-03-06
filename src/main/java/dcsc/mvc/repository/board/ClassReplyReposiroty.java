package dcsc.mvc.repository.board;

import org.springframework.data.jpa.repository.JpaRepository;

import dcsc.mvc.domain.board.ClassReply;

public interface ClassReplyReposiroty extends JpaRepository<ClassReply, Long> {

	/**
	 * qnaId로 답글 조회
	 * */
	ClassReply findByClassQnaQnaIdEquals(Long qnaId);
}
