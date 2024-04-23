<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"> </script> 
<link rel="stylesheet" href="resources/css/common.css?after" type="text/css">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>강의 결제</title>
    <style>
        /* 전체 영역 스타일 */
        .wrapper {
            max-width: 800px; /* 좀 더 넓은 크기로 조절 */
            margin: 0 auto;
            padding: 20px;
            background-color: #f9f9f9;
            border: 2px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        /* 각 영역 스타일 */
        .section {
            margin-bottom: 20px;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        /* 수평선 스타일 */
        .divider {
            border-top: 1px solid #ccc;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        /* 버튼 스타일 */
        .btn-group {
            text-align: center;
        }

        .btn {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        /* 프로필 영역 스타일 */
        .profile-info {
            display: flex;
            align-items: center;
        }

        .lecture-info {
              text-align: left;
        }
    </style>
</head>
<body>

<header id="usermain">
        <table id="mainmenu">
            <tr>
                <th class="menu"><img src="resources/img/logo.png" id="logo"></th>
                <th class="menu">
                   <c:if test="${sessionScope.loginId eq null}">
                      <c:if test="${sessionScope.user_type ne '강사'}">
                         <a href="login.go">추천 강의</a>                   
                      </c:if>
                   </c:if>
                   <c:if test="${sessionScope.loginId ne null}">
                      <c:if test="${sessionScope.user_type ne '강사'}">
                         <a href="recommendList.go">추천 강의</a>                   
                      </c:if>
                   </c:if>
                </th>
                <th class="menu"><a href="allList.go">전체 강의</a></th>
                <th class="menu"><a href="serviceCenter.go">고객센터</a></th>
            </tr>
        </table>
        <table id="mymenu">
            <c:if test="${sessionScope.loginId ne null}">
                <tr>
                    <c:if test="${sessionScope.alarm_count > 0}">
                        <th><img src="resources/img/alarm_on.png" class="miniimg alarm"></th>
                    </c:if>
                    <c:if test="${sessionScope.alarm_count == 0}">
                        <th><img src="resources/img/alarm.png" class="miniimg alarm"></th>
                    </c:if>
                    <th><img src="resources/img/basic_user.png" class="miniimg"></th>
                    <th><div id="userName">${sessionScope.user_name}</div></th>
                </tr>
            </c:if>
            <c:if test="${sessionScope.loginId eq null}">
                <tr>
                    <th><a href="login.go">로그인</a></th>
                </tr>
            </c:if>
        </table>
    </header>
    
    <form action="">
	    <div class="wrapper">
	        <!-- 프로필 영역 -->
	        <div class="section profile">
	            <div class="profile-info">
	                <img src="profile.jpg" alt="프로필 사진">
	                <div class="lecture-info">
	                	<input type="hidden" name="${USER_NAME}">
	                	<input type="hidden" name="${Class_price}">
	                    <span id="teacherId">${USER_NAME} 강사님 </span><br>
	                    <span>강의 제목: ${Class_name}</span><br>
	                    <span>강의 횟수: ${Class_times}</span><br>
	                    <span>강의 가격: ${Class_price}</span>
	                </div>
	            </div>
	        </div>
	        <!-- 각 영역을 구분하는 수평선 -->
	        <div class="divider"></div>
	
	        <!-- 보유 포인트 영역 -->
	        <div class="section">
	            <span>보유 포인트: ${havePoint}</span>
	        </div>
	        <!-- 수평선 -->
	        <div class="divider"></div>
	
	        <!-- 강의료 및 포인트 정보 영역 -->
	        <div class="section">
	            <span>총 강의료: ${Class_price}</span><br>
	            <span>현재 포인트: ${havePoint}</span><br>
	            <span>남은 포인트: ${remainPoint}</span>
	        </div>
	        <!-- 수평선 -->
	        <div class="divider"></div>
	
	        <!-- 최종 결제 금액 영역 -->
	        <div class="section">
	            <span>최종 결제 금액: ${Class_price}</span>
	        </div>
	        <!-- 수평선 -->
	        <div class="divider"></div>
	
	        <!-- 버튼 영역 -->
	        <div class="btn-group">
	            <button type="submit" class="btn">결제하기</button>
	            <button type="button" class="btn">취소하기</button>
	        </div>
	    </div>
    </form>
    
    <div id="footer">
        <li>상호명 : SONA</li>
        <li>대표자 : 김○○</li>
        <li>전화 : 02-123-4567</li>
        <li>팩스 : 02-123-4568</li>
        <li>사업자등록번호 : 000-00-00000</li>
        <li>본관 : (08505) 서울특별시 금천구 가산디지털2로 95</li>
    </div>
    <div id="slide">
        <table>
            <tr>
                <td colspan="2">${sessionScope.user_name} 회원님</td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td class="manner">♥ ${sessionScope.manner_variance}</td>
            </tr>
        </table>
        <br/>
        <div>보유 포인트 : <span>${sessionScope.point}</span></div>
        <br/>
        <div>
           <c:if test="${sessionScope.user_type eq '수강생'}">
              <a href="studentWrittenList.go">내가 쓴 리뷰</a>           
           </c:if>
           <c:if test="${sessionScope.user_type eq '강사'}">
              <a href="teacherWrittenList.go">내가 쓴 리뷰</a>           
           </c:if>
        </div>
        <br/>
        <div><a href="myPage.go">마이페이지</a></div>
        <br/><br/><br/>
        <div><a href="logout.do">로그아웃</a></div>
    </div>
</body>


<div id="footer">
    <%@ include file="../member/layout/footer.jsp" %>
</div>
</body>
<script>

$('.alarm').click(function alarmList() {
	   location.href = 'alarmList.go';
	});
</script>
</html>