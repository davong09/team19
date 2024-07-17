
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 컨텍스트패스(진입점폴더) 변수 설정 -->
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<style>
.mainheader {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px;
	background-color: #ffffff;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.mainheader nav {
	display: flex;
	align-items: center;
}

.mainheader .logo {
	max-height: 50px; /* 로고 이미지의 최대 높이 설정 */
}

.mainheader .user-info {
	display: flex;
	align-items: center;
}

.mainheader .user-info p {
	margin: 0 10px;
	font-weight: bold;
}

.mainheader .user-info a {
	margin: 0 10px;
	text-decoration: none;
	color: #007bff;
}

.mainheader .user-info a:hover {
	text-decoration: underline;
}

.mainheader .cart {
	max-height: 30px; /* 장바구니 이미지의 최대 높이 설정 */
	margin-left: 20px; /* 왼쪽 여백 추가 */
}
</style>

<header class="mainheader">
	<nav>
		<a href="/"><img src="/resources/image/logo.png" alt="로고" class="logo" /></a>

	</nav>
	<div class="user-info">
		<a href="<c:url value='/basket'/>"> <img src="/resources/image/cart.png" alt="장바구니" class="cart">
		</a>
		<c:if test="${not empty sessionScope.memberVo}">
			<p>${sessionScope.memberVo.name}님</p>
			<a href="<c:url value='/logout'/>">로그아웃</a>
		</c:if>
		<c:if test="${empty sessionScope.memberVo}">
			<a href="<c:url value='/login'/>">로그인</a>
		</c:if>
	</div>
</header>
