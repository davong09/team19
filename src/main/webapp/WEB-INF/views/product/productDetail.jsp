<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="now" value="<%=new java.util.Date()%>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Details</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/productdetailstyle.css' />?v=${now}" />
</head>
<body>
    <c:if test="${not empty message}">
        <script>
            alert('${message}');
        </script>
    </c:if>
    <div class="container">
        <jsp:include page="/resources/common/mainheader.jsp" />
        <main>
            <div class="product-details">
                <table>
                    <tr>
                        <th>상품명</th>
                        <td><c:out value="${productVo.name}" /></td>
                    </tr>
                    <tr>
                        <th>가격</th>
                        <td><c:out value="${productVo.price}" /></td>
                    </tr>
                    <tr>
                        <th>상품 내용</th>
                        <td>${productVo.content}</td>
                    </tr>
                    <tr>
                        <th>상품 이미지</th>
                        <td>
                            <div class="product-images">
                                <img src="<c:url value='/upload/${productVo.img1}'/>" alt="상품 이미지1">
                                <img src="<c:url value='/upload/${productVo.img2}'/>" alt="상품 이미지2">
                                <img src="<c:url value='/upload/${productVo.img3}'/>" alt="상품 이미지3">
                                <img src="<c:url value='/upload/${productVo.img4}'/>" alt="상품 이미지4">
                                <img src="<c:url value='/upload/${productVo.img5}'/>" alt="상품 이미지5">
                            </div>
                        </td>
                    </tr>
                </table>
                <br>
                <a href="<c:url value='/product/list'/>" class="button">목록</a>
            </div>
        </main>
    </div>
</body>
</html>
