package com.dorothy.member.board.qna.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dorothy.common.vo.PageDTO;
import com.dorothy.member.board.qna.service.BoardService;
import com.dorothy.member.board.qna.vo.BoardVO;
import com.dorothy.member.login.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/qna/*")
@AllArgsConstructor
public class BoardController {
	private BoardService boardService;
	
	/*************************************
	 * 글목록 구현하기(페이징 처리 제외 목록 조회)
	 * 요청 URL : http://localhost:8080/board/boardList
	 *************************************
	@RequestMapping(value="/boardList", method = RequestMethod.GET)
//	@GetMapping("/boardList")
	public String boardList(@ModelAttribute("data") BoardVO bvo, Model model) {
		log.info("boardList 호출 성공");
		// 전체 레코드 조회
		List<BoardVO> boardList = boardService.boardList(bvo);
		model.addAttribute("boardList", boardList);
		
		return "board/boardList"; // /WEB-INF/views/board/boardList.jsp
	} */

	/*************************************
	 * 글목록 구현하기(페이징 처리 목록 조회)
	 * 요청 URL : http://localhost:8080/board/qna/boardList
	 *************************************/
	@RequestMapping(value="/boardList", method = RequestMethod.GET)
//	@GetMapping("/boardList")
	public String boardList(@ModelAttribute("data") BoardVO bvo, Model model) {
		log.info("boardList 호출 성공");
		// 전체 레코드 조회
		List<BoardVO> boardList = boardService.boardList(bvo);
		model.addAttribute("boardList", boardList);
		
		// 전체 레코드수 구현
		int total = boardService.boardListCnt(bvo);
		// 페이징 처리
		model.addAttribute("pageMaker", new PageDTO(bvo, total)); // new PageDTO(CommonVO 또는 CommonVO 하위 클래스의 인스턴스(BoardVO), 총 레코드수)
		
		return "member/board/qna/boardList"; // member/board/qna/boardList.jsp
	}
	
	@RequestMapping(value="/myList", method = RequestMethod.GET)
//	@GetMapping("/boardList")
	public String myList(@ModelAttribute("data") BoardVO bvo, HttpServletRequest req, Model model) {
		log.info("boardList 호출 성공");
		
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("member");
		
		// 전체 레코드 조회
		List<BoardVO> boardList = boardService.myList(mvo);
		model.addAttribute("boardList", boardList);
		
		// 전체 레코드수 구현
		int total = boardService.boardListCnt(bvo);
		// 페이징 처리
		model.addAttribute("pageMaker", new PageDTO(bvo, total)); // new PageDTO(CommonVO 또는 CommonVO 하위 클래스의 인스턴스(BoardVO), 총 레코드수)
		
		return "member/board/qna/boardList"; // member/board/qna/boardList.jsp
	}
	
	/*************************************
	 * 글쓰기 폼 출력하기
	 *************************************/
	@RequestMapping(value="/writeForm")
	public String writeForm(@ModelAttribute("data") BoardVO bvo) {
		log.info("writeForm 호출 성공");
		
		return "member/board/qna/writeForm"; // /WEB-INF/views/board/writeForm.jsp
	}
	
	/*************************************
	 * 글쓰기 구현하기
	 *************************************/
	@RequestMapping(value="/boardInsert", method=RequestMethod.POST)
//	@PostMapping("/boardInsert")
	public String boardInsert(BoardVO bvo, Model model) throws Exception{
		log.info("boardInsert 호출 성공");
		
		int result = 0;
		String url = "";
//		bvo.setM_id("abc123");
		bvo.setQ_status("답변대기");
		
		
		result = boardService.boardInsert(bvo);
		if(result == 1) {
			url = "/board/qna/boardList";
		}else {
			url = "/board/qna/writeForm";
		}
		
		return "redirect:"+url;
	}
	
	/*************************************
	 * 글 상세보기 구현
	 *************************************/
	@RequestMapping(value="/boardDetail", method=RequestMethod.GET)
//	@GetMapping("/boardDetail")
	public String boardDetail(@ModelAttribute("data") BoardVO bvo, Model model) {
		log.info("boardDetail 호출 성공");
		//log.info("bvo = " + bvo);
		
		BoardVO detail = boardService.boardDetail(bvo);
		model.addAttribute("detail", detail);
		
		return "member/board/qna/boardDetail";
	}
	
	/*************************************
	 * 비밀번호 확인
	 * @param b_num
	 * @param b_pwd
	 * @return int로 result를 0 또는 1을 리턴할 수도 있고,
	 * 		   String으로 result 값을 "성공 or 실패, 일치 or 불일치"를 리턴할 수도 있다.(현재 문자열 리턴)
	 * 참고 : @Responsebody는 전달된 뷰를 통해서 출력하는 것이 아니라 HTTP Response Body에 직접 출력하는 방식.
	 * 		 produces 속성은 지정한 미디어 타입과 관련된 응답을 생성하는데 사용한 실제 컨텐트 타입을 보장.
	 *************************************/
	@ResponseBody
	@RequestMapping(value = "/pwdConfirm", method = RequestMethod.POST, produces = "text/plain; charset=UTF-8")
	public String pwdConfirm(BoardVO bvo) {
		log.info("pwdConfirm 호출 성공");
		String value = "";
		
		// 아래 변수에는 입력 성공에 대한 상태값 저장(1 or 0)
		int result = boardService.pwdConfirm(bvo);
		if(result == 1) {
			value = "성공";
		}else {
			value = "실패";
		}
		log.info("result = " + result);
		
		return value; // value값 자체를 브라우저에 출력
	}
	
	/*************************************
	 * 글삭제 구현하기
	 * 참고 : RedirectAttributes 객체는 리다이렉트 시점(return "redirect:/경로")에
	 * 한번만 사용되는 데이터를 전송할 수 있는 addFlashAttribute()라는 기능을 지원한다.
	 * addFlashAttribute() 메서드는 브라우저까지 전송되기는 하지만, URI상에는 보이지 않는 숨겨진 데이터의 형태로 전달된다.
	 *************************************/
	@RequestMapping(value = "/boardDelete")
	public String boardDelete(@ModelAttribute BoardVO bvo, RedirectAttributes ras) throws Exception{
		log.info("boardDelete 호출 성공");
		
		// 아래 변수에는 입력 성공에 대한 상태값 담습니다.(1 or 0)
		int result = 0;
		String url = "";
		
		// result = boardService.boardDelete(bvo.getB_num());
		result = boardService.boardDelete(bvo);
		ras.addFlashAttribute("boardVO", bvo);
		
		if(result == 1) {
			url = "/board/qna/boardList";
		}else {
			//url = "/board/boardDetail?b_num="+bvo.getB_num();
			url = "/board/qna/boardDetail";
		}
		
		return "redirect:" + url;
	}
	
	/*************************************
	 * 글수정 폼 출력하기
	 * @param : b_num
	 * @return : BoardVO
	 *************************************/
	@RequestMapping(value="/updateForm")
	public String updateForm(@ModelAttribute("data") BoardVO bvo, Model model) {
		log.info("updateForm 호출 성공");
		log.info("q_num = " + bvo.getQ_num());
		
		BoardVO updateData = boardService.updateForm(bvo);
		
		model.addAttribute("updateData", updateData);
		return "member/board/qna/updateForm"; // /WEB-INF/views/board/updateForm.jsp
	}
	
	/*************************************
	 * 글수정 구현하기
	 * @param : BoardVO
	 * 참고 : RedirectAttributes 객체는 리다이렉트 시점(return "redirect:/경로")에
	 * 한번만 사용되는 데이터를 전송할 수 있는 addFlashAttribute()라는 기능을 지원한다.
	 * addFlashAttribute() 메서드는 브라우저까지 전송되기는 하지만, URI상에는 보이지 않는 숨겨진 데이터의 형태로 전달된다.
	 *************************************/
	@RequestMapping(value="/boardUpdate", method=RequestMethod.POST)
	public String boardUpdate(@ModelAttribute BoardVO bvo, RedirectAttributes ras) throws Exception {
		log.info("boardUpdate 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = boardService.boardUpdate(bvo);
		ras.addFlashAttribute("data", bvo);
		
		if(result == 1) {
			// 아래 url은 수정 후 상세 페이지로 이동
			// url = "/board/boardDetail?b_num="+bvo.getB_num();
			url = "/board/qna/boardDetail";
		}else {
			//url = "/board/updateForm?b_num="+bvo.getB_num();
			url = "/board/qna/updateForm";
		}
		
		return "redirect:"+url;
	}
	
	/*************************************
	 * 글삭제 전 댓글 개수 구현하기
	 * @param : int
	 *************************************/
	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value="/replyCnt") public String
	 * replyCnt(@RequestParam("q_num") int q_num) { log.info("replyCnt 호출 성공");
	 * 
	 * int result = 0; result = boardService.replyCnt(q_num);
	 * 
	 * // return result + ""; > 정수형이어서 오류 return String.valueOf(result); }
	 */
}
