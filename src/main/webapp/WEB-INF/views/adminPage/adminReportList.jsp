<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>SONA 신고 목록 - 관리자</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"> </script>
<link rel="stylesheet" href="resources/css/common.css?after" type="text/css">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<style> 
	#showlist {
		position : relative;
	    border-collapse: collapse;
	    width: 100%; /* 테이블 셀 경계를 병합하여 구분선이 하나만 나타나도록 설정 */
	}
	
	#showList th, #showList td {
	    border: 1px solid #dddddd; /* 셀 테두리 색상 설정 */
	    padding: 8px; /* 셀 내부 여백 설정 */
	    text-align: left; /* 텍스트를 왼쪽 정렬 */
	    border-right : none;
	    border-left : none;
	}
	
	#showList tr:nth-child(even) {
	    background-color: #f2f2f2; /* 짝수 행 배경색 설정 */

	}
	
	#showList th {
	    background-color: #dddddd; /* 헤더 배경색 설정 */
	    color: #333333; /* 헤더 텍스트 색상 설정 */
	}
	#divvv{
		display: flex;
		left: -400px;
		width: 100%;
	}
	.nidx{
		width: 8%;
	}
	.nid{
		width: 25%;
	}
	.nbhit{
		width: 16.6%;
	}
	.ndate{
		width: 20%;
	}
	.ntitle{
		width: 20%;	
	}
	.nchb{
		width: 10%;
	}
	#container{
		max-width: 600px;
	}
	#paaaa{
		position: relative;
		width: 80%;
		margin-left: 2%;
	}
	
	#wrapper1 {
    display: flex;
	}
	#adminside{
	height : 800px;
	}
	
	#searchType {
	    width: 300px;
	    height: 35px;
	    margin-left: 70px;
	}
	
	#searchText {
	    width: 700px;
	    height: 35px;
	    margin-left: 70px;
	}
	
	#search{
		height:29px;
		width: 100px;
		margin-left : 20px;
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
    
    <div id = "divvv">
    <div id="wrapper1">
            <div id="adminside">
                <h3>신고 관리</h3>
                <hr/>
                <a href="adminMain.go">관리자 페이지</a>
                <a href="adminUserList.go">회원 관리</a>
                <a href="adminLessonList.go">강의 관리</a>
                <a href="adminNoticeList.go">공지사항 관리</a>
                <a href="adminFaqList.go">FAQ 관리</a>
                <a href="adminSuggestionsList.go">건의사항 관리</a>
                <a href="adminReviewList.go">리뷰 관리</a>
                <a href="adminReportManagement.go">신고 관리</a>
                <a href="userSuspensionHistory.go">회원 정지 이력</a>

            </div>
        </div>
        
     	<div id = "paaaa">    	  
		<br><br><br>
	     	<!-- 검색기능  -->
	     	<select id="searchType">
			  <option value="1">신고 유형</option>
			  <option value="2">조치 진행상황</option>
			</select>
	     	<input type="text" id ="searchText">
	     	<button type="button" id="search">검색하기</button>
	     	<!-- 검색기능 끝 -->
	    	<br><br><br><br><br><br>
	     	
		   <table id ="showlist">
		   	<thead>
		      <tr class="listhead">
				<th class="nidx" style="text-align: center;">신고번호</th>
				<th class="ntitle" style="text-align: center;">신고 유형</th>
				<th class="nid" style="text-align: center;">신고 대상</th>
				<th class="ndate" style="text-align: center;">신고일자</th>
				<th class="nbhit" style="text-align: center;">조치 진행상황</th>	        
		      </tr>
		     </thead>
		     <tbody id="list" class="listhead"></tbody>
				<tr>
					<td colspan="7" id = "paging">
						<div class="container">                           
		               		<nav aria-label="page navigation" style="text-align:center">
		                 	 <ul class="pagination" id="pagination"></ul>
		               		</nav> 
		               		<hr>              
		            	</div>
					</td>
				</tr>
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

</body>
<script>
	var showPage =1;
	var searchRemain = false;
	
	$(document).ready(function(){ // html 문서가 모두 읽히면 되면(준비되면) 다음 내용을 실행 해라
		listCall(showPage);
	});

	$('#search').click(function (){
		$('#pagination').twbsPagination('destroy');
		listCall(showPage);
	});

	
	
	
	
	function listCall(page){
			var searchType = $('select[id="searchType"]').val();
			var serachText = $('input[id="searchText"]').val();
			console.log(searchType);
			console.log(serachText);
	    $.ajax({
	       type:'get',
	       url:'reportManagementlist.ajax',
	       data:{
	    	    'page':page,
	    	    'searchType':searchType,
	    	    'searchText':serachText 
	    	},
	       dataType:'json',
	       success:function(data){
	          drawList(data.list);
	          
	          var startPage = 1;
	          
	       // 플러그인 추가
	       	$('#pagination').twbsPagination({
	    		startPage:data.currPage, // 시작 페이지
	    		totalPages:data.totalPages, // 총 페이지 갯수
	    		visiblePages:5,  // 보여줄 페이지 수[1][2][3][4][5]
	    		onPageClick:function(evt,pg){ // 페이지 클릭시 실행 함수
	    			console.log(evt); // 이벤트 객체
	    			console.log(pg); //클릭한 페이지 번호 의미
	        		showPage = pg;
	        		listCall(pg);
	    			
	    		}
	       	});
	       
	       },
	       error:function(error){
	          console.log(error)
	       }
	    });
	}

	function drawList(list){
		var content = '';
		for(item of list){
		    console.log(item);
		    content += '<tr>';
		    content += '<td class="ncbb" style="text-align: center;">' + item.report_idx +'</td>';
		    content += '<td class="nidx" style="text-align: center;">' + item.board_category + '</td>';
		    content += '<td class="ntitle" style="text-align: center;"><a href="reportDetailAdmin.go?report_idx=' + item.report_idx + '">' + item.report_content + '</a></td>';

		    // Convert the report_date to a localized date string
		    var date = new Date(item.report_date);
		    var dateStr = date.toLocaleDateString("ko-KR");
		    content += '<td class="ndate" style="text-align: center;">' + dateStr + '</td>';

		    content += '<td class="nbhit" style="text-align: center;">' + item.action_result +'</td>';

		    content += '</tr>';

	 	}
	 
	 	$('#list').html(content);
	}

	function del() {
		var delArr = [];
	    $("input[name='del']").each(function(index, item) {
	      	if ($(item).is(":checked")) {
			var val = $(this).val();
	        console.log(val);
	        delArr.push(val);
	      }
	   });
	     $.ajax({
	         type:'post' // method 방식
	         ,url:'./del.ajax' // 요청할 주소 // 파라미터 
	         ,data:{delList:delArr}
	         ,dataType:'json' // 기본 데이터 타입은 JSON 이다
	         ,success:function(data){
	         	if(data.cnt>0){
	           		alert('선택하신'+data.cnt+'개의 클이 삭제되었습니다.');
	            	$('#list').empty();
	            	listCall();
	            }
	        	console.log(data);
	         } 
	         ,error:function(error){ // 통신 실패한 경우
	         	console.log(error);
	         }
	     });
	}

	$('#all').on('click',function(){
		var $chk = $('input[name="del"]');
		// attr : 정적 속성 : 처음부터 그려져 있거나 JSP에서 그린 내용
		// prop : 동적 속성 : 자바스크렙트로 나중에 그려진 내용 ※ 초보자들 시점 문제가 큼 : 
		// -> 렛갈림 시행 할려는 내용이 그려지는것보다 먼저면 attr 사용하면 안됨  
		if($(this).is(":checked")){
			$chk.attr('checked',true);	
		}else{
			$chk.attr('checked',false);
		}
		
	});

	
	
	function redirectToReplyPage() {
	    window.location.href = './videoList.go';
	}

	$('#userName').click(function slide() {
		var display = $('#slide').css('display');
	    if (display == 'none') {
	        $('#slide').css('display', 'block');
	    }
	    if (display == 'block') {
	        $('#slide').css('display', 'none');
	    }
	});

	$('#logo').click(function main(){
		location.href = 'adminMain.go';
	});

	$('.alarm').click(function alarmList() {
		location.href = 'alarmList.go';
	});
</script>
</html>