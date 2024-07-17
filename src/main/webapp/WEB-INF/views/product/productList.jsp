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
		<main>
			<h3>상품 목록</h3>
			<form action="<c:url value='/productList'/>" method="get" class="search-form">
				<input type="text" name="keyword" placeholder="검색어 입력" /> <input
					type="submit" value="검색" />
			</form>

		 	<c:if test="${not empty productList}">
				<div class="content">
					<div class="product-content">
						<c:forEach var="product" items="${productList }" varStatus="idx">
							<div class="product-item">
							<%-- <a href="<c:url value='/product/detail/${product.img1 }'/>"> --%>
							<a href="<c:url value='/product/detail/${product.proId }'/>"> <img src="${contextPath}/resources/uploads/${product.img1 }" alt="상품" /></a>
							<a href="<c:url value='/product/detail/${product.proId }'/>"><c:out value="${product.name }"></c:out></a> <br>
							<a href="<c:url value='/product/detail/${product.proId }'/>"><c:out value="${product.price }"></c:out></a>
<%-- 							<a href="<c:url value='/product/detail/${product.proId }'/>"> <img src="${contextPath}/resources/uploads/${product.img1 }" alt="상품" /></a>
							<a href="<c:url value='/detail'/>"><c:out value="${product.name }"></c:out></a> <br>
							<a href="<c:url value='/detail'/>"><c:out value="${product.price }"></c:out></a> --%>
							</div>
						</c:forEach>
					</div>
				</div>
				<%-- <table border="1">
					<tr>
						<td align="center" colspan="8">${page_navigator}</td>
					</tr>
				</table> --%>
 			</c:if>
			<c:if test="${sessionScope.memberVo != 'null' && sessionScope.memberVo.memberId == 'java' }">
			<br> <a href="<c:url value='/product/create'/>">상품 작성</a>
			</c:if>
		</main>
	</div>
</body>
</html>
