package com.javalab.board.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.javalab.board.service.BoardService;
import com.javalab.board.vo.BoardVo;
import com.javalab.board.vo.MemberVo;

import lombok.extern.slf4j.Slf4j;

/**
 * Board 컨트롤러
 * - 클라이언트 요청을 받는 메소드(핸들러)를 갖고 있는 클래스
 * - 받은 요청을 서비스 레이어로 전달하는 역할.
 * - 서비스로 부터 전달받은 쿼리결과를 model에 담고 담은 값을 보여줄 jsp 페이지 이름 리턴
 */
@Controller
@RequestMapping("/board")	// 컨트롤러 차원의 Url 연결 문자열 설정
@Slf4j
public class BoardController {
	
	// Board 서비스 레이어 의존성 주입
	@Autowired
	private BoardService boardService;
	
	/**
	 * 게시물 내용 보기 메소드
	 */
	//@GetMapping("/detail")
	//public String getBoard(@RequestParam("bno") int bno, Model model) {
    @GetMapping("/detail/{bno}")
    public String getBoard(@PathVariable("bno") int bno, Model model) {	
		log.info("BoardController getBoard");
		BoardVo boardVo = boardService.getBoard(bno);
		model.addAttribute("boardVo", boardVo);
		return "board/boardDetail"; // jsp 이름
	}
	
	/**
	 * 게시물 목록 보기 메소드
	 */
	@GetMapping("/list")
	public String listBoard(Model model) {
		log.info("여기는 listBoard 메소드"); 
		List<BoardVo> boardList = boardService.listBoard();
		model.addAttribute("boardList", boardList);
		return "board/boardList"; // jsp 이름
	}
	
	/**
	 * 게시물 등록폼 제공(Get방식)
	 */
	@GetMapping("/create")
	public String createBoard(HttpSession session, 
								RedirectAttributes redirectAttributes, 
								Model model) {
		// 세션에서 사용자 정보 조회
        MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
        if (memberVo == null) {
            return "redirect:/login";
        }	
        
		model.addAttribute("boardVo", new BoardVo());
		return "board/boardCreate";
	}
	
	/**
	 * 게시물 등록 메소드(Post방식)
	 * @ModelAttribute : 사용자의 입력에 오류가 있을 경우 기존의 내용을 그대로
	 * 화면으로 다시 전달해준다.
	 */
	@PostMapping("/create")
	public String createBoard(@ModelAttribute("boardVo") BoardVo boardVo, HttpSession session) {
		// 세션에서 사용자 정보 조회
        MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
        if (memberVo == null) {
            return "redirect:/login";
        }		
        // 세션에서 조회한 사용자를 작성로 설정
        boardVo.setMemberId(memberVo.getMemberId());
        
		boardService.createBoard(boardVo);
		return "redirect:/board/list";	// 목록 요청(listBoard() 호출)
	}

	/**
	 * 게시물 수정폼(화면-Get)
	 */
	@GetMapping("/update")
	public String updateBoard(@RequestParam("bno") int bno, 
								HttpSession session, Model model) {
		// 세션에서 사용자 정보 조회
        MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
        if (memberVo == null) {
            return "redirect:/login";
        }		
        
		BoardVo boardVo = boardService.getBoard(bno);
		model.addAttribute("boardVo", boardVo);	// 화면에 보여줄 게시물을 model에 저장
		return "board/boardUpdate";
	}
	
	/**
	 * 게시물 수정 메소드(Post)
	 */
	@PostMapping("/update")
	public String updateBoard(@ModelAttribute("boardVo") BoardVo boardVo,
								HttpSession session) {
		// 세션에서 사용자 정보 조회
        MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
        if (memberVo == null) {
            return "redirect:/login";
        }
        
        // 세션에서 조회한 사용자를 작성로 설정
        boardVo.setMemberId(memberVo.getMemberId());
        
		boardService.updateBoard(boardVo);
		return "redirect:/board/list";	// 목록 요청(listBoard() 호출)
	}
	
	/**
	 * 게시물 삭제 메소드
	 */
	@PostMapping("/delete")
	public String deleteBoard(@RequestParam("bno") int bno) {
		boardService.deleteBoard(bno);
		return "redirect:/board/list";	// 목록 요청(listBoard() 호출)
	}
	
    /**
     * 세션 확인 메서드
     */
	/*
	 * private boolean checkSession(HttpSession session, RedirectAttributes
	 * redirectAttributes) { if (session.getAttribute("memberVo") == null) {
	 * redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다."); return false; }
	 * return true; }
	 */	
	/**
	 * 업로드 폼(화면)을 띄워주는 메소드
	 * @return
	 */
	@GetMapping("/upload")
	public String exUpload() {
		return "/sample/exUpload";
	}
	
	@PostMapping("/upload")
	public String fileUpload(@RequestParam("files") ArrayList<MultipartFile> files) {
		String uploadDir = "c:\\filetest\\upload\\";
		for(MultipartFile file : files) {
			if(!file.isEmpty()) {
				try {
					log.info("업로드 파일명 : " + file.getOriginalFilename());
					File dest = new File(uploadDir + file.getOriginalFilename());
					// 파일 저장
					file.transferTo(dest);
				} catch (Exception e) {
					e.printStackTrace();
					return "uploadFailure";
				}
			}
		}
		return "/sample/uploadSuccess";
	}
}