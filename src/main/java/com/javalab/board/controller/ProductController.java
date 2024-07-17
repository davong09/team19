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

import com.javalab.board.service.ProductService;
import com.javalab.board.vo.MemberVo;
import com.javalab.board.vo.ProductVo;

import lombok.extern.slf4j.Slf4j;

/**
 * Board 컨트롤러
 * - 클라이언트 요청을 받는 메소드(핸들러)를 갖고 있는 클래스
 * - 받은 요청을 서비스 레이어로 전달하는 역할.
 * - 서비스로 부터 전달받은 쿼리결과를 model에 담고 담은 값을 보여줄 jsp 페이지 이름 리턴
 */
@Controller
@RequestMapping("/product")	// 컨트롤러 차원의 Url 연결 문자열 설정
@Slf4j
public class ProductController {
	
	// Board 서비스 레이어 의존성 주입
	@Autowired
	private ProductService productService;
	
	/**
	 * 상품 내용 보기 메소드
	 */
    @GetMapping("/detail/{proId}")
    public String getProduct(@PathVariable("proId") int proId, Model model) {	
//		log.info("ProductController getProduct");
    	ProductVo productVo = productService.getProduct(proId);
    	model.addAttribute("productVo", productVo);
    	return "product/productDetail"; // jsp 이름
    }
	
	/**
	 * 상품 목록 보기 메소드
	 */
	@GetMapping("/list")
	public String listProduct(Model model) {
//		log.info("여기는 listProduct 메소드"); 
		List<ProductVo> productList = productService.listProduct();
		model.addAttribute("productList", productList);
		return "redirect:product/productList"; // jsp 이름
	}
	
	/**
	 * 상품 등록폼 제공(Get방식)
	 * 여기서 memberId가 관리자일때 등록폼으로 가게끔
	 */
	@GetMapping("/create")
	public String createProduct(HttpSession session, 
								RedirectAttributes redirectAttributes, 
								Model model) {
		// 세션에서 사용자 정보 조회
        MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
        if (memberVo == null) {
            return "redirect:/login";
        }	
        
		model.addAttribute("productVo", new ProductVo());
		return "product/productCreate";
	}
	
	/**
	 * 상품 등록폼 제공(Get방식)
	 * 여기서 memberId가 관리자일때 등록폼으로 가게끔 < gpt돌려봄
	 */
//	@GetMapping("/create")
//	public String createProduct(HttpSession session, 
//	                            RedirectAttributes redirectAttributes, 
//	                            Model model) {
//	    // 세션에서 사용자 정보 조회
//	    MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
//	    if (memberVo == null || !"java".equals(memberVo.getMemberId())) {
//	        return "redirect:/login";
//	    }
//	    
//	    model.addAttribute("boardVo", new BoardVo());
//	    return "board/boardCreate";
//	}
	
	/**
	 * 상품 등록 메소드(Post방식)
	 * @ModelAttribute : 사용자의 입력에 오류가 있을 경우 기존의 내용을 그대로
	 * 화면으로 다시 전달해준다.
	 */
	@PostMapping("/create")
	public String createProduct(@ModelAttribute("productVo") ProductVo productVo,
									HttpSession session) {
		// 세션에서 사용자 정보 조회
        MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
        if (memberVo == null) {
            return "redirect:/login";
        }		
        
		productService.createProduct(productVo);
		return "/product/productList";
	}

	// 상품 수정이랑 삭제는 일단 보류(.jsp가 없음)
//	/**
//	 * 상품 수정폼(화면-Get)
//	 */
//	@GetMapping("/update")
//	public String updateProduct(@RequestParam("proId") int proId, 
//								HttpSession session, Model model) {
//		// 세션에서 사용자 정보 조회
//        MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
//        if (memberVo == null) {
//            return "redirect:/login";
//        }		
//        
//        ProductVo productVo = productService.getProduct(proId);
//		model.addAttribute("productVo", productVo);	// 화면에 보여줄 게시물을 model에 저장
//		return "product/productUpdate";
//	}
//	
//	/**
//	 * 상품 수정 메소드(Post)
//	 */
//	@PostMapping("/update")
//	public String updateProduct(@ModelAttribute("productVo") ProductVo productVo,
//								HttpSession session) {
//		// 세션에서 사용자 정보 조회
//        MemberVo memberVo = (MemberVo) session.getAttribute("memberVo");
//        if (memberVo == null) {
//            return "redirect:/login";
//        }
//        
//        productService.updateProduct(productVo);
//		return "redirect:/product/list";	// 목록 요청(listBoard() 호출)
//	}
//	
//	/**
//	 * 상품 삭제 메소드
//	 */
//	@PostMapping("/delete")
//	public String deleteProduct(@RequestParam("proId") int proId) {
//		productService.deleteProduct(proId);
//		return "redirect:/product/list";	// 목록 요청(listBoard() 호출)
//	}
	
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
//					log.info("업로드 파일명 : " + file.getOriginalFilename());
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
