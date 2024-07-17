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
<style>


.content {
	padding: 20px;
}

.content .slideshow-container {
	width: 100%;
	max-width: 800px; /* 최대 너비 설정 */
	margin: auto;
	position: relative;
	overflow: hidden;
}

.content .mySlides {
	display: none;
}

.content .mySlides img {
	width: 100%;
	height: 400px; /* 고정된 높이 설정 */
	object-fit: cover; /* 이미지가 비율을 유지하며 잘 맞도록 조정 */
}

.product-content {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
}

.product-item {
	width: 23%; /* 4개의 아이템을 한 줄에 표시 */
	box-sizing: border-box;
	margin-bottom: 20px;
	text-align: center;
	border: 1px solid #e0e0e0;
	padding: 10px;
}

.product-item img {
	width: 100%;
	height: 100px;
}

.product-item .price {
	color: #ff5722;
	font-weight: bold;
	margin-top: 10px;
}

.footer {
	background-color: #f1f1f1;
	text-align: center;
	padding: 10px;
	position: fixed;
	bottom: 0;
	width: 100%;
}
</style>
</head>
<body>
	<div class="container">
		<%-- 헤더부분 include 액션 태그 사용, c:url 사용금지, 경로 직접 지정해야함. --%>
		<jsp:include page="/resources/common/mainheader.jsp" />
		<!-- 네비게이션 바 끝 -->

		<!-- 메인 콘텐츠 시작 -->
		<div class="content">
			<div class="product-content">
				<c:forEach var="product" items="${productList }" varStatus="idx">
					<div class="product-item">
						<img src="${contextPath}/resources/uploads/${product.img1 }" alt="${product.img1 }">
						<p><c:out value="${product.name }"/></p>
						<p class="price"><c:out value="${product.price }"/></p>
					</div>
				</c:forEach>
			</div>
		</div>
		<!-- 메인 콘텐츠 끝 -->

		<!-- 푸터 시작 -->
		<footer class="footer"> © 2024 Your Company. All Rights
			Reserved. </footer>
		<!-- 푸터 끝 -->
	</div>
</body>
</html>
