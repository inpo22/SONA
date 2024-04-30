<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="resources/css/common.css" type="text/css">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
#condition {
	margin-left: 15%;
	height: 20px;
}
#listTable {
	margin: 0 auto;
	border-collapse: collapse;
}
.thead {
	background-color: lightgray;
}
.first-col {
	width: 100px;
	border-top: solid 1px lightgray;
	border-bottom: solid 1px lightgray;
}
.second-col {
	width: 300px;
	border-top: solid 1px lightgray;
	border-bottom: solid 1px lightgray;
}
.third-col {
	width: 200px;
	border-top: solid 1px lightgray;
	border-bottom: solid 1px lightgray;
}
.fourth-col {
	width: 200px;
	border-top: solid 1px lightgray;
	border-bottom: solid 1px lightgray;
}
#listTable th {
	height: 30px;
}
</style>
</head>
<body>
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
    <div id="wrapper">
            <div id="adminside">
                <h3>회원관리</h3>
                <hr/>
                <a href="adminMain.go">관리자 페이지</a>
                <a href="adminUserList.go">회원 관리</a>
                <a href="adminLessonList.go">강의 관리</a>
                <a href="#">공지사항 관리</a>
                <a href="#">FAQ 관리</a>
                <a href="#">건의사항 관리</a>
                <a href="#">리뷰 관리</a>
                <a href="#">신고 관리</a>
                <a href="#">회원 정지 이력</a>
            </div>
            <div id="content">
            	<br/><br/><br/><br/>
                <select id="condition">
                	<option value="class_name">강의명</option>
                	<option value="user_name">강사명</option>
                </select>
                <input type="text" id="searchContent">
                <input type="button" id="search" value="검색">
                <br/><br/>
                <table id="listTable">
                	<thead>
                		<tr>
                			<th class="first-col thead">No</th>
                			<th class="second-col thead">강의명</th>
                			<th class="third-col thead">강사명</th>
                			<th class="fourth-col thead">개설일자</th>
                		</tr>
                	</thead>
                	<tbody id="listContent"></tbody>
                	<tr>
		      			<td colspan="4"><br/><br/>
		      				<div class="container">                           
		            			<nav aria-label="Page navigation" style="text-align:center">
		                			<ul class="pagination" id="pagination"></ul>
		            			</nav>               
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
$('#logo').click(function main(){
	location.href = 'adminMain.go';
});

var showPage = 1;

$(document).ready(function(){ // html 문서가 모두 읽히면 되면(준비되면) 다음 내용을 실행 해라
	listCall(showPage);
});

$('#search').click(function (){
	$('#pagination').twbsPagination('destroy');
	listCall(showPage);
});

function listCall(page){
    $.ajax({
       type:'post',
       url:'./adminLessonList.ajax',
       data:{
    	   'page':page
    	   ,'condition':$('#condition').val()
    	   ,'searchContent':$('#searchContent').val()
       },
       dataType:'json',
       success:function(data){
    	  console.log('시작');
          drawList(data.list);
          console.log(data);          
          // 플러그인 추가
          
          var startPage = 1;
          
          $('#pagination').twbsPagination({
        	  startPage:startPage,		// 시작페이지
        	  totalPages:data.totalPages, 	// 총 페이지 갯수
        	  visiblePages:5,	// 보여줄 페이지 수 [1][2][3][4][5]
        	  onPageClick:function(evt, pg){ // 페이지 클릭시 실행 함수
        		  console.log(evt);//이벤트 객체
        		  console.log(pg);//클릭한 페이지 번호
        		  showPage = pg;
        		  listCall(pg);
        	  }
          });                    
       },
       error:function(request, status, error){
    	   console.log("code: " + request.status)
           console.log("message: " + request.responseText)
           console.log("error: " + error);
       }
	});
}
function drawList(list){
	var content = '';
	
	for (var data of list) {
		content += '<tr>';
		content += '<th class="first-col">' + data.class_idx + '</th>';
		content += '<th class="second-col"><a href="lessonDetail.go?class_idx=' + data.class_idx + '">' + data.class_name + '</a></th>';
		content += '<th class="second-col"><a href="adminUserDetail.go?user_id=' + data.user_id + '">' + data.user_name + '</a></th>';
		
		var date = new Date(data.class_reg_date);
		var dateStr = date.toLocaleDateString("ko-KR");//en-US		
		
		content += '<th class="fourth-col">' + dateStr + '</th>';
		content += '</tr>'
	}
	
 	$('#listContent').html(content);
	
}
</script>
</html>