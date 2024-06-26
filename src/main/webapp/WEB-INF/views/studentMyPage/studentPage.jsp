<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="resources/css/common.css?after" type="text/css">
<style>
		.main {
		    font-size: 20px; 
		    #contents{
		    font-size: 15px;}
		}
		.main {
		    font-size: 20px; 
		}
</style>
</head>
<body>
<c:if test="${sessionScope.user_type eq '관리자'}">
      <header id="adminmain">
           <table id="mainmenu">
               <tr>
                   <th class="menu"><img src="resources/img/logo.png" id="logo"></th>
                   <th class="menu"></th>
                   <th class="menu"></th>
                   <th class="menu"></th>
               </tr>
           </table>
           <table id="mymenu">
              <tr>
                 <td><a href="adminLogout.do">로그아웃</a></td>
              </tr>
           </table>
       </header>
   </c:if>
   <c:if test="${sessionScope.user_type ne '관리자'}">
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
   </c:if>
    <div id="wrapper">
            <div id="sidemenu">
                <h3>마이페이지</h3>
                <hr/>
                <a href="studentPage.go">마이페이지</a>
                <a href="studentPageEdit.go">개인 정보 수정</a>
                <a href="favoriteList.go">즐겨찾기 강사</a>
                <a href="blockList.go">숨김 강사</a>
                <a href="studentQnAList.go">내가 작성한 Q&A</a>
                <a href="studentPointList.go">포인트 내역</a>
                <a href="studentReceivedList.go">내가 받은 리뷰</a>
                <a href="studentWrittenList.go">내가 작성한 리뷰</a>
                <a href="studentAttendedList.go">수강 이력</a>
            </div>
 			<div id="content">
            <table style="width: 100%;">
                <thead>
   			 		<hr style= "width: 100%; border: none; border-bottom: 1px solid black; margin-top: 5px;">
   			 		
					<tr>
					    <c:choose>
					        <c:when test="${empty userInfo.new_filename}">
					            <td colspan="1" id="imgRow" style="width: 15%; height: 20%; margin-right: 50px;">
					                등록된 사진이 없습니다.
					            </td>
					        </c:when>
					        <c:otherwise>
					            <td colspan="1" id="imgRow" style="width: 15%; height: 20%; margin-right: 50px;">
					                <img class="myPageImg" style="width: 200px; height: 200px;" src="/photo/${userInfo.new_filename}">
					            </td>
					        </c:otherwise>
					    </c:choose>
					
					    <td class="main" style="padding-right: 600px; width: 200px;">
					        <span style="width: 200px;">${userInfo.user_name} ${userInfo.user_type}</span>
					        <br><br>${userInfo.user_id}
					    </td>
					    <td style="width: 60%; min-width: 150px; text-align: left;">
					        <img src="resources/img/heart.png" style="margin-right: 30px; width: 20px; height: 20px;" id="heart">${sessionScope.manner_variance}
					    </td>
					</tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>
                    <tr>
                        <td class="main" colspan="2" style="width: 100%; text-align: left;"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;이메일 <span class="contents" style="margin-left: 100px; width: 200px; display: inline-block;">${userInfo.user_email}</span></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>
                    <tr>
                        <td class="main" colspan="2" style="width: 100%; text-align: left;"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;전화번호 <span class="contents" style="margin-left: 80px; width: 200px; display: inline-block;">${userInfo.user_phone}</span></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>
                    
                    <tr>
                        <td class="main" colspan="2" style="width: 100%; text-align: left;">
                            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;은행
                            <span class="contents" style="margin-left: 120px; width: 400px; display: inline-block;">${userInfo.user_bank}</span>
                        </td>                   
                    <tr>
                    
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>
                    
                    
                    <tr>
                        <td class="main" colspan="2" style="width: 100%; text-align: left;">
                            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;계좌번호 
                            <span class="contents" style="margin-left: 80px; width: 400px; display: inline-block;">${userInfo.user_accountnumber}</span>
                        </td>                   
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>
                    <tr>
                        <td class="main" colspan="2" style="width: 100%; text-align: left;">
                            <br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;잔여 포인트 
                            <span class="contents" style="margin-left: 60px; width: 200px; display: inline-block;">${sessionScope.point}</span>
                            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
							<button id="chargeButton" style="background-color: #BEE6FF; color: black; border: none; padding: 10px 20px; text-align: center; display: inline-block; font-size: 16px; margin: 4px 2px; cursor: pointer; border-radius: 4px;">충전</button>
							<button id="withdrawButton" style="background-color: #BEE6FF; color: black; border: none; padding: 10px 20px; text-align: center; display: inline-block; font-size: 16px; margin: 4px 2px; cursor: pointer; border-radius: 4px;">출금</button>
                        </td>
                  </tr>
                </tbody>
                
            </table>
            <table style="width: 100%;">
                <thead>
                	<tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>  
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>  
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>  
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>
                    <tr>
                        <td colspan="3">
                            <hr style="width: 100%; border: none; border-bottom: 1px solid black; margin-top: 5px;">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="text-align: left; font-weight: bold; font-size : 20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;수강신청서</td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>
              
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>
          
                </thead>
                <tbody>
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>
                    <tr>
                        <td class="main" colspan="2" style="width: 100%; text-align: left;"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ㆍ희망악기 <span class="contents" style="margin-left: 80px; width: 200px; display: inline-block;">${userInfo.applyform_inst}</span></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>
                    <tr>
                        <td class="main" colspan="2" style="width: 100%; text-align: left;"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ㆍ희망지역 <span class="contents" style="margin-left: 80px; width: 200px; display: inline-block;">${userInfo.applyform_location}</span></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>
                    <tr>
                        <td class="main" colspan="2" style="width: 100%; text-align: left;">
                            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ㆍ희망요일 
                        </td>
                    </tr>
                    <tr>
                        <td class="main" colspan="2" style="width: 100%; text-align: left;">
					      <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					        <c:forEach items="${userInfo.applyform_days}" var="days">
					            <div style="display: inline-block; background-color: #3498DB; color: white; padding: 2px 5px; margin-right: 5px;">
					                ${days}
					            </div>
					        </c:forEach>
                            <!-- 나머지 요일도 동일한 방식으로 추가 -->
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>
                    <tr>
                        <td class="main" colspan="2" style="width: 100%; text-align: left;"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ㆍ희망 강의스타일</td>

                    </tr>
                    <tr>
                        <td class="main" colspan="2" style="width: 100%; text-align: left;">
				                <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				        <c:forEach items="${userInfo.applyform_style}" var="style">
				            <div style="display: inline-block; background-color: #3498DB; color: white; padding: 2px 5px; margin-right: 5px;">
				                ${style}
				            </div>
				        </c:forEach>
                            <!-- 나머지 요일도 동일한 방식으로 추가 -->
                        </td>
                    </tr>
               
                    <tr>
                        <td colspan="2" style="height: 20px;"></td> <!-- 줄바꿈을 위한 빈 셀 추가 -->
                    </tr>
                    <tr>
                        <td class="main" colspan="2" style="width: 100%; text-align: left;">
						    <br>
						    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ㆍ개인악기 유무 
						    <span class="contents" style="margin-left: 50px; width: 200px; display: inline-block;">
						        <c:choose>
						            <c:when test="${userInfo.have_inst eq true}">
						                O
						            </c:when>
						            <c:otherwise>
						                X
						            </c:otherwise>
						        </c:choose>
						    </span>
						</td>						                        
                     </tr>
                </tbody>
            </table>
        </div>
        </div>
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
<script>

$(document).ready(function(){
    $("#chargeButton").click(function(){
        var loginId = "${sessionScope.loginId}";
        // loginId 값이 없을 경우에는 이동하지 않음
        if(loginId) {
            // chargePoint.go로 이동하는 URL 생성
            var url = "./chargePoint.go?loginId=" + loginId;
            // 생성한 URL로 이동
            window.location.href = url;
        }
    });
});

$(document).ready(function(){
    $("#withdrawButton").click(function(){
        var loginId = "${sessionScope.loginId}";
        // loginId 값이 없을 경우에는 이동하지 않음
        if(loginId) {
            // chargePoint.go로 이동하는 URL 생성
            var url = "./withdrawPoint.go?loginId=" + loginId;
            // 생성한 URL로 이동
            window.location.href = url;
        }
    });
});



$('.alarm').click(function alarmList() {
	   location.href = 'alarmList.go';
	});



$('#logo').click(function main(){
	if ('${sessionScope.user_type}' == '관리자') {
		location.href = 'adminMain.go';
	}else {
		location.href = '/';	
	}
});

$('#userName').click(function slide() {
	var display = $('#slide').css('display');
    if (display == 'none') {
        $('#slide').css('display', 'block');
    }
    if (display == 'block') {
        $('#slide').css('display', 'none');
    }
});


</script>
</html>