package dcsc.mvc.controller.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dcsc.mvc.domain.board.ClassQna;
import dcsc.mvc.domain.board.ClassQnaReplyDTO;
import dcsc.mvc.domain.board.ClassReply;
import dcsc.mvc.domain.classes.Classes;
import dcsc.mvc.domain.user.Student;
import dcsc.mvc.domain.user.Teacher;
import dcsc.mvc.service.board.ClassQnaService;
import lombok.RequiredArgsConstructor;




@Controller
@RequestMapping("/")
@RequiredArgsConstructor
public class QnaController {
	private final ClassQnaService classQnaService;
	
	private final static int PAGE_COUNT = 10;
	private final static int BLOCK_COUNT = 5;
	
	/**
	 * Q&A 상세조회(메인) - 포워드
	 * */
	@RequestMapping("board/qna/selectByQnaId")
	@ResponseBody
	public ClassQnaReplyDTO selectByQnaId(Long qnaId, Model model) {
		ClassQna classQna = classQnaService.selectByQnaId(qnaId);
		
		ClassQnaReplyDTO qna = new ClassQnaReplyDTO(qnaId, classQna.getStudent().getStudentId(),
				null, classQna.getQnaInsertDate(), classQna.getQnaTitle(), classQna.getQnaComplete(),
				classQna.getQnaContent(), classQna.getBlindState(), classQna.getSecretState(), 
				null, null, null, null);
		
		if(classQna.getClassReply() != null) {
			ClassReply reply = classQna.getClassReply();
			System.out.println(reply.getReplyId());
			qna.setReplyId(reply.getReplyId());
			qna.setTeacherNickname(reply.getTeacher().getTeacherNickname());
			qna.setReplyContent(reply.getReplyContent());
			qna.setReplyInsertDate(reply.getReplyInsertDate());
		}
		System.out.println(qna.getReplyContent());
		return qna;
	}
	
	/**
	 * Q&A 상세조회(메인) -모달 - 아작스(학생 마이페이지)
	 * */
	@RequestMapping("main/board/qna/qnaRead")
	@ResponseBody
	public ClassQnaReplyDTO qnaRead(Long qnaId) {
		ClassQna classQna = classQnaService.selectByQnaId(qnaId);
		ClassReply classReply = classQnaService.selectByReplyQnaId(qnaId);
		
		ClassQnaReplyDTO qnaReplyDTO = new ClassQnaReplyDTO();
		
		if(classReply!=null) {
			qnaReplyDTO = new ClassQnaReplyDTO(classQna.getQnaId(), classQna.getStudent().getStudentId(), classQna.getClasses().getClassName(),
											classQna.getQnaInsertDate(), classQna.getQnaTitle(), classQna.getQnaComplete(),
											classQna.getQnaContent(), classQna.getBlindState(), classQna.getSecretState(), classReply.getReplyId(), classReply.getTeacher().getTeacherNickname(), 
											classReply.getReplyInsertDate(), classReply.getReplyContent());
			
		}else if(classReply==null) {
			qnaReplyDTO = new ClassQnaReplyDTO(classQna.getQnaId(), classQna.getStudent().getStudentId(), classQna.getClasses().getClassName(),
					classQna.getQnaInsertDate(), classQna.getQnaTitle(), classQna.getQnaComplete(),
					classQna.getQnaContent(), classQna.getBlindState(), classQna.getSecretState(), null, null, 
					null, null);
		}
		
		
		return qnaReplyDTO;
	}
	
	/**
	 * Q&A 상세조회 - 관리자
	 * */
	@RequestMapping("admin/board/qna/qnaRead/{qnaId}")
	public String qnaReadAdmin(@PathVariable Long qnaId, Model model ) {
		ClassQna classQna = classQnaService.selectByQnaId(qnaId);
		ClassReply classReply = classQnaService.selectByReplyQnaId(qnaId);
		model.addAttribute("qna", classQna);
		model.addAttribute("qnaReply", classReply);
		
		return "admin/board/qna/qnaRead";
	}
	
	/**
	 * 선생님 - Q&A 상세조회
	 * */
	@RequestMapping("teacher/board/qna/qnaRead/{qnaId}")
	public String qnaReadth(@PathVariable Long qnaId , Model model) {
		ClassQna classQna = classQnaService.selectByQnaId(qnaId);
		ClassReply classReply = classQnaService.selectByReplyQnaId(qnaId);
		
		model.addAttribute("qna", classQna);
		model.addAttribute("qnaReply", classReply);
		

		return "teacher/board/qna/qnaRead";
		
	}
	
	/**
	 * Q&A 등록 폼
	 * */
	@RequestMapping("main/board/qna/qnaWrite")
	public void qnaWrite() {
	}
	
	/**
	 * Q&A 등록  - 학생 마이페이지
	 * */
	@RequestMapping("main/board/qna/qnaInsert")
	public String qnaInsert(ClassQna classQna, Classes classes, Student student) {
		
		String blindState = "F";
		String qnaComplete = "F";
		
		if(classQna.getSecretState()==null) {
			classQna.setSecretState("T");
		}
		
		classQna.setClasses(classes);
		classQna.setStudent(student);
		classQna.setBlindState(blindState);
		classQna.setQnaComplete(qnaComplete);
		classQnaService.insertQuestion(classQna);
		System.out.println("classQna = "+classQna );
		
		return "redirect:/main/mypage/qnaList";
	}
	
	/**
	 * Q&A 수정폼 - 모달(학생 마이페이지)
	 * */
	@RequestMapping("qnaUpdateForm")
	@ResponseBody
	public ClassQna qnaUpdateFormModal(Long qnaId) {
		ClassQna classQna = classQnaService.selectByQnaId(qnaId);
		
		return classQna;
	}
	
	/**
	 * Q&A 수정하기 - 학생페이지
	 * */
	@RequestMapping("main/board/qna/qnaUpdate")
	public String qnaUpdateMypage(ClassQna classQna) {
		classQnaService.updateQuestion(classQna);
	
		return "redirect:/main/mypage/qnaList";
	}
	
	/**
	 * Q&A 삭제하기 - 학생페이지
	 * */
	@RequestMapping("main/board/qna/qnaDelete")
	public String qnaDeleteMypage(Long qnaId) {
		classQnaService.deleteQuestion(qnaId);
		
		return "redirect:/main/mypage/qnaList";
	}
	
	/**
	 * Q&A 등록 
	 * */
	@RequestMapping("board/qna/qnaInsert")
	@ResponseBody
	public void qnaInsert(ClassQna classQna, Classes classes) {
		System.out.println(classQna.getSecretState());
		classQna.setClasses(classes);
		classQna.setStudent(new Student("kim1234", null, null, null, null, null, null, null, null));
		classQnaService.insertQuestion(classQna);
	}
	
	/**
	 * Q&A 수정폼 - 모달
	 * */
	@RequestMapping("board/qna/qnaUpdateForm")
	@ResponseBody
	public ClassQna qnaUpdateForm(Long qnaId) {
		ClassQna classQna = classQnaService.selectByQnaId(qnaId);
		
		return classQna;
	}
	
	/**
	 * Q&A 수정폼 - 모달
	 * */
	@RequestMapping("board/qna/qnaUpdate")
	@ResponseBody
	public ClassQna qnaUpdate(ClassQna classQna, Classes classes) {
		classQna.setClasses(classes);
		classQnaService.updateQuestion(classQna);
		
		return classQna;
	}
	
	/**
	 * Q&A 삭제하기
	 * */
	@RequestMapping("board/qna/qnaDelete")
	@ResponseBody
	public void qnaDelete(Long qnaId) {
		classQnaService.deleteQuestion(qnaId);
	}
	
	/**
	 * 관리자 QnA전체조회 
	 * */
	/*@RequestMapping("admin/board/qna/qnaListBlind")
	public void qnaAll(Model model) {
		List<ClassQna> list = classQnaService.selectAllQna();
		model.addAttribute("list", list);
	}*/
	
	/**
	 * 관리자 QnA전체조회 - 페이징처리
	 * */
	@RequestMapping("admin/board/qna/qnaListBlind")
	public void qnaAll(Model model, @RequestParam(defaultValue = "1") int nowPage) {

		//페이징처리하기
		Pageable page = PageRequest.of( (nowPage-1), PAGE_COUNT, Direction.DESC, "qnaId");
		Page<ClassQna> pageList = classQnaService.selectAllQna(page);
		
		//pageList.getContent() : 뷰단 상황 이해하기 //${requestScope.pageList.content}
		
		model.addAttribute("pageList", pageList);
		
		int temp = (nowPage-1)%BLOCK_COUNT; //나머지는 항상 0 1 2 임 why? 3이므로 3보다 작은 값
		int startPage = nowPage-temp;
		
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);
	}
	
	/**
	 * 선생님 QnA전체조회 -- 사이트내 전체 QnA 글 보기 필요?
	 * */
	@RequestMapping("teacher/board/qna/qnaList")
	public void qnaSelectAll(Model model) {
		List<ClassQna> list = classQnaService.selectAllQna();
		
		model.addAttribute("list", list);
	}
	
	/**
	 * 블라인드처리
	 * */
	@RequestMapping("admin/board/qna/qnaBlind")
	@ResponseBody
	public String qnaBlind(Long qnaId ,String blindState) {
		
		classQnaService.updateBlind(qnaId, blindState);
		
		return "redirect:/";
		//return "admin/board/qnaListBI_ad";
	}
	
	/**
	 * 클래스ID로 클래스 Q&A 검색 - 페이징
	 * */
	@RequestMapping("board/qna/selectByClassId")
	@ResponseBody
	public Map<String, Object> selectByClassId(Long classId, Model model, int page) {
		
		//페이징처리하기
		Pageable pageable = PageRequest.of((page-1), PAGE_COUNT, Direction.DESC, "qnaId");
		Page<ClassQna> pageList = classQnaService.selectByClassId(classId, pageable);
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<ClassQnaReplyDTO> list = new ArrayList<ClassQnaReplyDTO>();
		
		for(ClassQna c : pageList.getContent()) {
			ClassQnaReplyDTO qna = new ClassQnaReplyDTO(c.getQnaId(), c.getStudent().getStudentId(),
					null, c.getQnaInsertDate(), c.getQnaTitle(), c.getQnaComplete(), c.getQnaContent(),
					c.getBlindState(), c.getSecretState(), null, null, null, null);
			list.add(qna);
		}
		
		map.put("list", list);
		
		int temp = (page-1) % BLOCK_COUNT;
		int startPage = page - temp;

		map.put("totalPage", pageList.getTotalPages());
		map.put("blockCount", BLOCK_COUNT);
		map.put("startPage", startPage);
		map.put("page", page);
		
		return map;
	}
	
	/*
	 * 강사ID로 클래스 Q&A 검색 - 페이징
	 * */
	@RequestMapping("teacher/mypage/qnaListAll")
	public void selectByteacherId(String teacherId , Model model, @RequestParam(defaultValue = "1") int nowPage) {
		teacherId = "Tann1234";
		
		//페이징처리하기
		Pageable page = PageRequest.of( (nowPage-1), PAGE_COUNT, Direction.DESC, "qnaId");
		Page<ClassQna> pageList = classQnaService.selectByTeacherId(teacherId, page);
		
		//pageList.getContent() : 뷰단 상황 이해하기 //${requestScope.pageList.content}
		
		model.addAttribute("pageList", pageList);
		
		
		int temp = (nowPage-1)%BLOCK_COUNT; //나머지는 항상 0 1 2 임 why? 3이므로 3보다 작은 값
		int startPage = nowPage-temp;
		
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);
	}
	
	
	/**
	 * 선생님 Q&A 답변 폼
	 * */
	@RequestMapping("qnaReplyWriteForm")
	public String qnaReplyWriteFrom(Long qnaId, Model model) {
		model.addAttribute("qnaId", qnaId);
		
		return "teacher/board/qna/qnaReplyWrite";
	}
	
	/**
	 * 선생님 Q&A 답변하기
	 * */
	@RequestMapping("qnaReplyInsert")
	public String qnaReplyInsert(ClassReply classReply, Long qnaId, Teacher teacher) {
		classReply.setClassQna(new ClassQna(qnaId));
		classReply.setTeacher(teacher);
		classQnaService.insertReply(classReply);
		
		return "redirect:/teacher/mypage/qnaListAll";
	}
	
	/**
	 * 선생님 Q&A 답변 수정폼
	 * */
	/*@RequestMapping("qnaReplyUpdateForm/{replyId}")
	public ModelAndView qnaReplyUpdateForm(@PathVariable Long replyId){
		ClassReply classReply= classQnaService.selectByReplyId(replyId);
		
		return new ModelAndView("teacher/board/qna/qnaReplyUpdateForm", "qnaReply", classReply);
	}*/
	
	/**
	 * 선생님 Q&A 답변 수정폼 - 모달
	 * */
	@RequestMapping("qnaReplyUpdateForm")
	@ResponseBody
	public ClassReply qnaReplyUpdateFormModal(Long replyId){
		ClassReply classReply= classQnaService.selectByReplyId(replyId);
		
		return classReply;
	}
	
	/**
	 * 선생님 Q&A 답변 수정하기
	 * */
	@RequestMapping("qnaReplyUpdate")
	public String qnaReplyUpdate(ClassReply classReply) {
		classQnaService.updateReply(classReply);
		
		return "redirect:/teacher/mypage/qnaListAll";
	}

	/**
	 * 선생님 Q&A 답변 삭제하기 - 기존 포워드
	 * */
	/*@RequestMapping("qnaReplyDelete/{replyId}")
	public String qnaReplyDelete(@PathVariable Long replyId) {
		classQnaService.deleteReply(replyId);
		
		return "redirect:/teacher/mypage/qnaListAll";
	}*/
	
	/**
	 * 선생님 Q&A 답변 삭제하기
	 * */
	@RequestMapping("qnaReplyDelete")
	public String qnaReplyDeleteTeacherMypage(Long replyId) {
		classQnaService.deleteReply(replyId);
		
		return "redirect:/teacher/mypage/qnaListAll";
	}
	
	/**
	 * 학생ID로 클래스 Q&A 검색 -페이징처리
	 * */
	@RequestMapping("main/mypage/qnaList")
	public void selectByStudentId(String studentId, Model model, @RequestParam(defaultValue = "1") int nowPage) {
		studentId="lee1234";
		
		//페이징처리하기
		Pageable page = PageRequest.of( (nowPage-1), PAGE_COUNT, Direction.DESC, "qnaId");
		Page<ClassQna> pageList = classQnaService.selectByStudentId(studentId, page);
		
		//pageList.getContent() : 뷰단 상황 이해하기 //${requestScope.pageList.content}
		
		model.addAttribute("pageList", pageList);
		
		
		int temp = (nowPage-1)%BLOCK_COUNT; //나머지는 항상 0 1 2 임 why? 3이므로 3보다 작은 값
		int startPage = nowPage-temp;
		
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage", startPage);
		model.addAttribute("nowPage", nowPage);
		
	}
}
