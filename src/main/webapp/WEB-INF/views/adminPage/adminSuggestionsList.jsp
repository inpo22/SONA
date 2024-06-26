<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>SONA 건의사항 목록 - 관리자</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"> </script>
<link rel="stylesheet" href="resources/css/common.css?after" type="text/css">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<style> 
	#showlist {
		position : relative;
	    border-collapse: collapse;
	    width: 100%; /* 테이블 셀 경계를 병합하여 구분선이 하나만 나타나도록 설정 */
	    text-align: center;
	}
	
	#showList th, #showList td {
	    border: 1px solid #dddddd; /* 셀 테두리 색상 설정 */
	    padding: 15px; /* 셀 내부 여백 설정 */
	    text-align: left; /* 텍스트를 왼쪽 정렬 */
	    border-right: none;
	    border-left: none;
	    text-align: center;
	}
	
	#showList tr:nth-child(even) {


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
		width: 4%;
	}
	.nid{
		width: 10%;
	}
	.nbhit{
		width: 16.6%;
	}
	.ndate{
		width: 10%;
	}
	.ntitle{
		width: 23%;	
	}
	.nanswer{
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
	#faqWriteButton{
		position: relative;
		left: 880px;
	}
	#titleId{
		
	}
	#callDelList {
	}
	.isdel{
		width: 10%;
	}
</style>
</head>
<body>
	<!-- 헤더 -->
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
    <!-- 헤더 -->
	<div id="divvv">
		<div id="wrapper1">
			<div id="adminside">
                <h3>건의사항 관리</h3>
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

		<div id="paaaa">
			<h3>건의사항 페이지</h3>
			<!-- 구분기능  -->
			<div>
				<button value="1" onclick="setCategory(1)">전체</button>
				<button value="2" onclick="setCategory(2)">답변중</button>
				<button value="3" onclick="setCategory(3)">답변완료</button>
			</div>
			<select id="searchType">
				<option value="1">제목</option>
				<option value="2">작성자</option>
			</select> <input type="text" id="searchText">
			<!-- <button type="button" id="search">검색하기</button> -->
			<img src="resources/img/search.png" id="search" height="20px"
				width="20px" onclick="search()" class="searchIcon">
			<!-- <button type="button" id="callDelList" onclick="callDelList()">삭제게시글보기</button>	 -->
			<!-- 검색기능 끝 -->
			<table id="showlist">
				<thead>
					<tr class="listhead">						
						<th class="nidx">글번호</th>
						<th class="ntitle">제목</th>
						<th class="nid">작성자</th>
						<th class="ndate">날짜</th>
						<th class="nanswer">답변여부</th>
						<th class="isdel">삭제여부</th>


					</tr>
				</thead>
				<tbody id="list" class="listhead"></tbody>
				<tr>
					<td colspan="7" id="paging">
						<div class="container">
							<nav aria-label="page navigation" style="text-align: center">
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
	var category = 1;
	var showPage =1;
	var searchRemain = false;
	var delType = 0;
	
	$(document).ready(function(){ // html 문서가 모두 읽히면 되면(준비되면) 다음 내용을 실행 해라
		listCall(showPage);
	});

	$('#search').click(function (){
		$('#pagination').twbsPagination('destroy');
		showPage =1;
		listCall(showPage);
	});
	
	function search(){
		$('#pagination').twbsPagination('destroy');
		showPage =1;
		listCall(showPage);		
	};

	function setCategory(num){
		console.log(num);
		category = num;
		$('#pagination').twbsPagination('destroy');
		showPage =1;
		listCall(showPage);
	}
	
	
	
	function listCall(page){
			var searchType = $('select[id="searchType"]').val();
			var serachText = $('input[id="searchText"]').val();
			console.log(searchType);
			console.log(serachText);
	    $.ajax({
	       type:'get',
	       url:'adminSuggestionsList.ajax',
	       data:{
	    	    'page':page,
	    		'searchType':searchType,
	    		'serachText':serachText,
	    		'categoryNum' : category,
	    		'delType' : delType
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
		    
		    content += '<td class="nidx">' + item.sug_idx + '</td>';
		    content += '<td class="ntitle"><a id="titleId" href="suggestionsDetail.go?sug_idx=' + item.sug_idx + '">' + item.sug_title + '</a></td>'
		    /* content += '<td class="nid">' + item.user_id + '</td>'; */
		    content += '<td class="nid"><a id="titleId" href="userDetail.go?user_id=' + item.user_id + '">' + item.user_id + '</a></td>'
		    //java.sql.Date 는 javascript에서는 밀리세컨드로 변환하여 표시한다.
		    //방법 1. Back-end : DTO의 반환 날짜 타입을 문자열로 변경 (서버를 껐다 켜야하니 웬만하면 프론트에서 해야햄)
		    //content += '<td>' + item.reg_date + '</td>';
		    //방법 2. Front-end : js에서 직접 변환
		    var date = new Date(item.sug_reg_date);
		    var dateStr = date.toLocaleDateString("ko-KR"); //en-US
		    content += '<td class="ndate">' + dateStr + '</td>';
		    
		    if (item.sug_answerCount >0) {
		    content += '<td class="nanswer">' + 'Y' + '</td>';	
			}else{
		    content += '<td class="nanswer">' + 'N' + '</td>';				
			};
		    //content += '<td class="nid">' + item.sug_answerCount + '</td>';
		     if (item.sug_delete ==1) {
		    	content += '<td class="fa">'+'삭제O'+'</td>';
			}else{
				content += '<td class="fa">'+'삭제X'+'</td>';
			}

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
	
	function callDelList(){
		if(delType==0){
			delType = 1;
			document.getElementById("callDelList").innerText="정상게시글보기";
		}else{
			delType = 0;
			document.getElementById("callDelList").innerText="삭제게시글보기";
		}
		$('#pagination').twbsPagination('destroy');
		showPage =1;
		listCall(showPage);
	}
	
	
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