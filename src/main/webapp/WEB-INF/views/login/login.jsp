<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 컨텍스트패스(진입점폴더) 변수 설정 -->
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
div { /* 각 div 요소에 5px의 여백을 추가 */
	margin: 5px;
}

.button-group { /* 버튼 그룹을 수평으로 배치하고 간격을 10px로 준다. */
	display: flex;
	gap: 10px;
}
</style>
</head>
<body>
	<div>
		<jsp:include page="/resources/common/mainheader.jsp" />
	</div>
	<h3>로그인</h3>
	<!-- 로그인 폼 시작 -->
	<form action="<c:url value='/login'/>" method="post">
		<div>
			<label for="id">아이디:</label> <input type="text" id="memberId"
				name="memberId" value="${memberVo.memberId}" required>
		</div>
		<div>
			<label for="password">비밀번호:</label> <input type="password"
				id="password" name="password" value="${memberVo.password}" required>
		</div>
		<div class="button-group">
			<input type="submit" value="로그인"> <input type="reset"
				value="다시쓰기">
			<!-- 회원가입 버튼. 링크로 이동 -->
			<a href="<c:url value='/member/create'/>">
				<button type="button">회원가입</button>
			</a>
		</div>
	</form>
	<%-- 오류 메시지 출력 --%>
	<c:if test="${not empty error }">
		<span style="color: red;">${error }</span>
	</c:if>
</body>
</html>