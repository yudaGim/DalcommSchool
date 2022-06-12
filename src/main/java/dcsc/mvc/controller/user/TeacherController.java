package dcsc.mvc.controller.user;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dcsc.mvc.config.security.PasswordEncoder;
import dcsc.mvc.domain.user.Sns;
import dcsc.mvc.domain.user.Student;
import dcsc.mvc.domain.user.Teacher;
import dcsc.mvc.domain.user.TeacherSns;
import dcsc.mvc.service.user.TeacherService;
import dcsc.mvc.util.ImageLink;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class TeacherController {
	
	public final TeacherService teacherService;
	
	public final BCryptPasswordEncoder getBCryptPasswordEncoder;
	
	/**
	 * 강사 회원가입 폼
	 * */
	@RequestMapping("/main/login/joinTeacher")
	public void joinTeacher() {}
	
	/**
	 * 강사 회원가입
	 * */
	@RequestMapping("/main/login/insert")
	public String insert(Teacher teacher) throws Exception{
		teacherService.insertTeacher(teacher);
		
		return "redirect:/";
	}
	
	/**
	 * 강사 정보 수정폼
	 * */
	@RequestMapping("/teacher/mypage/updateForm")
	public ModelAndView updateTeacherForm(HttpServletRequest request) {
//		teacherId = "Tpark1234";
		Teacher teacher = (Teacher)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		return new ModelAndView("teacher/mypage/updateForm","teacher", teacher);
	}
	
	/**
	 * 강사 정보 수정하기
	 * */
	@RequestMapping("/teacher/mypage/updateTeacher")
	public String updateTeacher(Teacher teacher,HttpServletRequest request) {
		
		System.out.println(teacher.getTeacherId());
		System.out.println(teacher.getTeacherNickname());
		System.out.println(teacher.getTeacherPhone());
		
		
		teacherService.updateTeacher(teacher);
		
		Teacher tea = (Teacher)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		tea.setTeacherPhone(teacher.getTeacherPhone());
		tea.setTeacherEmail(teacher.getTeacherEmail());
		
		return "redirect:/teacher/mypage/mypage";
	}
	
	/**
	 * 강사 프로필 수정
	 * */
	@RequestMapping("/teacher/mypage/updateTeacherProfile")
	public void updateTeacherProfile(Teacher teacher, String youtude, String instagram, String twitter, String facebook, MultipartFile file) throws Exception {

		List<TeacherSns> list = new ArrayList<TeacherSns>();
		if(youtude != null) list.add(new TeacherSns(null, teacher, new Sns(1L), youtude));
		if(instagram != null) list.add(new TeacherSns(null, teacher, new Sns(2L), instagram));
		if(twitter != null) list.add(new TeacherSns(null, teacher, new Sns(3L), twitter));
		if(facebook != null) list.add(new TeacherSns(null, teacher, new Sns(4L), facebook));
		
		teacher.setTeacherSns(list);
		
		if(file.getSize() > 0) {
			File img = new File(ImageLink.CLASS_IMG + file.getOriginalFilename());
			file.transferTo(img);
		   	
			teacher.setTeacherImg(file.getOriginalFilename());
		}
		
		teacherService.updateTeacherProfile(teacher);
	}
	
	/**
	 * 마이페이지
	 * */
	@PreAuthorize("isAuthenticated()")
	@RequestMapping("/teacher/mypage/mypage")
	public void mypage(HttpServletRequest request) {
		
	}

	
	/**
	 * 아이디 찾기 폼
	 * */
	@RequestMapping("/main/login/findIdForm")
	public void findIdForm() {}
	
	/**
	 * 비밀번호 찾기 폼
	 * */
	@RequestMapping("/main/login/findPwdForm")
	public void findPwdForm() {}
	
	/**
	 * 회원(강사,학생) 아이디 찾기
	 * */
	@RequestMapping("/main/login/findId")
	public ModelAndView findId(String userName, String userPhone) {
		
		String userId = teacherService.selectId(userName, userPhone);
		
		if(userId==null) return new ModelAndView("main/login/findError");
		
		return new ModelAndView("main/login/findIdOk", "userId", userId); //(가지고 갈 경로, "가서 쓰는 쓸 이름", 가져갈 데이터);
	}
	
	/**
	 * 회원(강사,학생) 비밀번호 찾기
	 * */
	@RequestMapping("/main/login/findPwd")
	public ModelAndView findPwd(String userId, String userName, String userPhone) {
		boolean result = teacherService.selectPwd(userId, userName, userPhone);
		
		if(!result) return new ModelAndView("main/login/findError");
		
		return new ModelAndView("/main/login/findPwdOk","userId",userId);
		
	}
	
	/**
	 * 비밀번호 바꾸기(session X. 비밀번호 찾기 다음 기능)
	 * */
	@RequestMapping("/main/login/findPwdOk")
	public String findPwdOk(String userId, String newUserPwd) {
		System.out.println("teacherController, findPwdOk 호출");
		
		String encodePassword = getBCryptPasswordEncoder.encode(newUserPwd);
		
		teacherService.updateUserPwd(userId, encodePassword);
		
		return "redirect:/";
	}
	
	/**
	 * 비밀번호 수정 폼(session O)
	 * */
	@RequestMapping("/main/mypage/modifyPwd")
	public void updatePwdForm() {}
	
	/**
	 * 비밀번호 수정(session O)
	 * */
	@RequestMapping("/main/login/updatePwd")
	public String updatePwd(String userPwd, String newUserPwd) {
		System.out.println("teacherController, updatePwd 호출");
		
		String encodePassword = getBCryptPasswordEncoder.encode(newUserPwd);
				
		//서비스 호출
		teacherService.updateLoginUserPwd(userPwd, encodePassword);
				
		return "redirect:/";
	}
	
	/**
	 * 아이디 중복 체크
	 * */
	@RequestMapping("/main/login/checkId")
	@ResponseBody
	public boolean checkId(String userId) {
		boolean result = teacherService.userIdCheck(userId);
		
		return result;
	}
	
	/**
	 * 핸드폰 번호 중복 체크
	 * */
	@RequestMapping("/main/login/checkPhone")
	@ResponseBody
	public boolean checkPhone(String userPhone) {
		boolean result = teacherService.userPhoneCheck(userPhone);
		

		return result;
	}
	
	/**
	 * 선생님 닉네임 중복 체크
	 * */
	@RequestMapping("/main/login/checkNick")
	@ResponseBody
	public boolean checkNick(String teacherNick) {
		boolean result = teacherService.teacherNickCheck(teacherNick);
		
		return result;
	}
	
	/**
	 * 강사 상세 보기(관리자)
	 * */
	@RequestMapping("/admin/user/{teacherId}")
	public Teacher readTeacherAdmin(String teacherId) {
		Teacher teacher = teacherService.selectById(teacherId);
		
		return teacher;
	}
	
	/**
	 * 강사 상세 보기
	 * */
	@RequestMapping("/main/teacher/teacherId")
	public ModelAndView readTeacherUser(HttpServletRequest request) {
//		teacherId="Tpark1234";
		Teacher teacher = (Teacher)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		return new ModelAndView("/teacher/mypage/teacherDetail", "teacher", teacher);
	}
	

	
	
}
