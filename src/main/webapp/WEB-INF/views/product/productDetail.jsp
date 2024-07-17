<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%-- now : 현재 시간의 시분초를 now 변수에 세팅 --%>
<c:set var="now" value="<%=new java.util.Date()%>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>productList.jsp</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value='/resources/css/board.css' />?v=${now}" />
</head>
<body>
	<c:if test="${not empty message}">
		<script>
			alert('${message}');
		</script>
	</c:if>
	<div class="container">
		<%-- 헤더부분 include 액션 태그 사용, c:url 사용금지, 경로 직접 지정해야함. --%>
		<jsp:include page="/resources/common/mainheader.jsp" />
		<main>
			<table border="1">
				<tr>
					<th>상품명</th>
					<td><c:out value="${productVo.name }" /></td>
				</tr>
				<tr>
					<th>가격</th>
					<td><c:out value="${productVo.price }" /></td>
				</tr>
				<tr>
					<th>카테고리</th>
					<td><c:out value="${productVo.categoryKey_ID }" /></td>
				</tr>
				<tr>
					<th>상품 내용</th>
					<td>${productVo.content }</td>
				</tr>
				<tr>
					<th>상품 이미지</th>
					<td><img src="<c:url value='/upload/${productVo.img1}'/>" alt="상품 이미지1"> <br> </td>
					<td><img src="<c:url value='/upload/${productVo.img2}'/>" alt="상품 이미지2"> <br> </td>
					<td><img src="<c:url value='/upload/${productVo.img3}'/>" alt="상품 이미지3"> <br> </td>
					<td><img src="<c:url value='/upload/${productVo.img4}'/>" alt="상품 이미지4"> <br> </td>
					<td><img src="<c:url value='/upload/${productVo.img5}'/>" alt="상품 이미지5"> <br> </td>
				</tr>
			</table>
			<br> 
			<a href="<c:url value='/product/list'/>">목록</a> 
			<!-- 업데이트랑 삭제는 일단 보류 -->
			<%-- <a href="<c:url value='/product/update'/>?proId=${productVo.proId}">수정</a>
			<form action="<c:url value='/product/delete'/>" method="post"> 
				<input type="hidden" name="proId" value="${productVo.proId}"> 
				<input type="submit" value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');">
			</form>
			--%>
		</main>
	</div>
</body>
</html>
