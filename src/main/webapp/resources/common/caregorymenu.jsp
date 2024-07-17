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

.nav-menu {
	background-color: #ffffff;
	padding: 20px;
	display: flex;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.nav-menu .nav-category .cate {
	margin: 0 15px;
	text-align: left;
	text-decoration: none;
}

.nav-menu .nav-category .imgmenu {
	width: 20px; /* 원하는 너비로 설정 */
	height: auto; /* 높이는 자동으로 설정 */
	vertical-align: middle; /* 텍스트와 수직 정렬 */
	margin-right: 10px; /* 텍스트와의 간격 조절 */
}

.nav-menu .nav-categorymain {
	margin-left: 30px;
}

.nav-menu .nav-categorymain a {
	margin: 0 15px;
	text-align: center;
	text-decoration: none;
}
</style>

<header class="categorymenu">
	<div class="nav-menu">
		<div class="nav-category">
			<img src="/resources/image/menubar.png" class="imgmenu"> <a
				href="/product/list">카테고리</a>
		</div>
		<div class="nav-categorymain">
			<a href="<c:url value='/category2'/>">신상품</a> <a
				href="<c:url value='/category3'/>">베스트</a> <a
				href="<c:url value='/category4'/>">특가/혜택</a> <a
				href="<c:url value='/category5'/>">계절별음식</a>
		</div>
	</div>



</header>