<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="board.BoardMgr"%>
<%@page import="user.MovieMemberMgr"%>
<%@page import="java.util.ArrayList"%>
<%@page import="movie.MovieBean"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="movie.RankMgr"%>
<%@page import="movie.MovieBean"%>
<%@page import="board.BoardBean" %>

<%@page import="org.json.simple.parser.ParseException"%>
<%@page import="org.json.simple.parser.JSONParser"%>

<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="universal.UtilMgr" %>

<jsp:useBean id="mgr" class="board.BoardMgr"/>
<jsp:useBean id="mmgr" class="movie.MovieMgr"/>
<jsp:useBean id="umgr" class="universal.UtilMgr"/>
<jsp:useBean id="mgmgr" class="movie.MovieGradeMgr"/>
<jsp:useBean id="memgr" class="user.MovieMemberMgr"/>
<%
String movietitle = request.getParameter("title");
String userid = "";
if(session != null){
	String loginedid=(String)session.getAttribute("userId");
	if (loginedid != null) {
        userid = loginedid;
    }
	else
		userid = "아니 세션 아이디가 없다고??";
}else
	userid = "아니 세션이 없다고??";

int totalRecord=0;
int numPerPage=5;
int pagePerBlock=15;
int totalPage=0;
int totalBlock=0;
int nowPage=1;
int nowBlock=1;
String category="0";
String keyField = "", keyWord = "";
MovieBean moviebean = mmgr.searchMovie(movietitle);
int movieidx = moviebean.getMovieidx();
String title = moviebean.getTitle();
String poster = moviebean.getPoster();
String content = moviebean.getContent();
String genre = moviebean.getGenre();
String opendt = moviebean.getOpendt();
String age = moviebean.getAge();
String actor = moviebean.getActor();
String director = moviebean.getDirector();
String playtime = moviebean.getPlaytime();
String trailer = moviebean.getTrailer();

String[] trailerArr = trailer.split(",");
if(request.getParameter("numPerPage")!=null){
	numPerPage = UtilMgr.parseInt(request, "numPerPage");
}
if(request.getParameter("keyWord")!=null){
	keyField = request.getParameter("keyField");
	keyWord = request.getParameter("keyWord");
}
totalRecord=mgr.getBoardCount(category, keyField, keyWord, movieidx);
if(request.getParameter("reload")!=null&&
		request.getParameter("reload").equals("true")){
	keyField = ""; keyWord = "";
}
if(request.getParameter("nowPage")!=null){
	nowPage = UtilMgr.parseInt(request, "nowPage");
}
int start = (nowPage*numPerPage)-numPerPage;
int cnt = numPerPage;

totalPage=(int)Math.ceil((double)totalRecord/numPerPage);
totalBlock=(int)Math.ceil((double)totalPage/pagePerBlock);
nowBlock=(int)Math.ceil((double)nowPage/pagePerBlock);
String userId = (String)session.getAttribute("userId");
MovieMemberMgr memMgr = new MovieMemberMgr();
String userNm = memMgr.getUserNm(userId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movie Site</title>
 <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>mainpage</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>

    <link rel="stylesheet" type="text/css" href="css/movieDetail.css">
   

</head>
<body>
   <div>
	<div class="row">
            <div class="col-4" style=" padding: 0px;">
                <img   class="img-fluid" id="main_logo" src="img/logo1.png" alt="img" >  
            
            </div>
            <div class="col-6" style=" padding: 0px;">
            <form  role="search">
                    <input  class="form-control me-2" id="main_search" type="search" placeholder="Search" aria-label="Search">   
 
            </div>
            <div class="col-1" style=" padding: 0px;">
            
                <button  class="btn btn-outline-success" id="search_btn" type="submit" >검색</button>
            </div>
            </form>
            <div class="col-2" style=" padding: 0px;">
            <%if(userId == null){ %>
              <button type="button" class="btn" onclick="javascript:location.href='../user/login.jsp'" >로그인</button>
              <button type="button" class="btn" onclick="javascript:location.href='../user/memberJoin.jsp'">회원가입</button>
           <%}else {%>
              <button type="button" class="btn" onclick="javascript:location.href='../user/myPage1.jsp'" ><%=userNm %></button>
              <button type="button" class="btn" onclick="javascript:location.href='/movieProject/logoutServlet'">로그아웃</button>
           <%} %> 
            </div>

        </div>
        <div class="row" style=" padding: 5px;">
        </div>
    
        <div class="row">
          <nav>
            <ul>
              <li><a href="../user/mainpage1.jsp">홈</a></li>
              <li><a href="rankingPage.jsp">랭킹</a></li>
              <li><a href="movieList.jsp">영화</a></li>
              <li><a href="recommendPage.jsp">추천</a></li>
              <li><a href="../board/boardPage.jsp">게시판</a></li>
              <li><a href="../board/qnaBoardPage.jsp">문의</a></li>
            </ul>
          </nav>
        </div>
		
	<div class="card">
		<img
			src="https://image.tmdb.org/t/p/w500<%=poster %>"
			alt="<%=title %>" style="width: 30%">
		<div class="text-container">
			<div class="title">
				<h4>
					<b><%=movietitle %></b>
				</h4>
			</div>
			<div class="container">
				<table class = "table">
					<tr>
						<td>개봉</td>
						<td><%=opendt %></td>
					</tr>
					<tr>
						<td>장르</td>
						<td><%=genre %></td>
					</tr>
					<tr>
						<td>청소년 관람불가 여부</td>
						<td><%=age %></td>
					</tr>
					<tr>
						<td>런타임</td>
						<td><%=playtime %></td>
					</tr>
					<tr>
						<td>감독</td>
						<td><%=director %></td>
					</tr>
				</table>
				<button  id="g-button">
					<img id="g-image" src="img/Egood.png" alt="Button Image" width="30px" height="30px">
				</button>
				<button  id="b-button">
					<img id="b-image" src="img/Ebad.png" alt="bad"  width="30px" height="30px">
				</button>
				<button id="h-button">
					<img id="h-image" src="img/empty.png" alt="heart" width="30px" height="30px">
				</button>
			</div>
		</div>
		
	</div>
	<div class="tab-navigation row">
		<ul>
			<li><a href="#synopsis" class="tab-link" data-tab="tab1">개요</a></li>
			<li><a href="#cast" class="tab-link" data-tab="tab2">출연진</a></li>
			<li><a href="#preview" class="tab-link" data-tab="tab3">예고편</a></li>
			<li><a href="#reviews" class="tab-link" data-tab="tab4">리뷰</a></li>
		</ul>
	</div>

	<div id="tab-content" class="row" align="center">
		<div class="tab active" data-tab="tab1">
			<!-- synopsis content code -->
			<%=content %>
		</div>
		<div class="tab" data-tab="tab2">
			<%=actor %>
		</div>
		<div class="tab" data-tab="tab3" style="padding-top: 40px">
			<div class="video-container">
			<%
				if(trailerArr.length == 0){
			%>
				<q>등록된 트레일러 영상이 없습니다</q>
			<%
				} else {
				for(int i = 0; i<trailerArr.length; i++) {
			%>
			  <div class="youtube-player" data-id="<%=trailerArr[i] %>"></div>
			<% }} %>
			  <div class="slider-buttons">
			    <button class="prev-button">이전</button>
			    <button class="next-button">다음</button>
			  </div>
			</div>
		</div>
			
			<div class="tab" data-tab="tab4">
						<table>
	<tr> 
		<td align="center" colspan="2">
		<%
				Vector<BoardBean> vlist =mgr.getBoardList(category, keyField, keyWord, movieidx);
				int listSize = vlist.size();
				if(vlist.isEmpty()){
					out.println(totalRecord+" 등록된 게시물이 없습니다.");
				}else{
		%>
			<table cellspacing="0">
				<tr align="center" bgcolor="#D0D0D0">
					<td width="100">번 호</td>
					<td width="250">제 목</td>
					<td width="100">작성자</td>
					<td width="150">작성일</td>
					<td width="100">좋아요</td>
				</tr>	
				<%
					for(int i=0;i<numPerPage/*10*/;i++){
						if(i==listSize) break;
						BoardBean bean = vlist.get(i);
						int num = bean.getBoardIdx();
						String subject = bean.getTitle();
						String name=memgr.getMember(bean.getUserId()).getUsernn();
						//String name = "dummy";
						String regdate = bean.getPostedDate().toString();
						//int depth = bean.getDepth();
						//int count = bean.getCount();
						//String filename = bean.getFilename();
						int ccount=mgr.getCommentCount(num);
						int lcount=bean.getLiked();
				%>
				<tr align="center">
					<td><%=totalRecord-start-i%></td>
					<td align="left">
					<%//for(int j=0;j<depth;j++){out.println("&nbsp;&nbsp;");} %>
					<a href="javascript:read('<%=num%>')">
					<%=subject%></a>
					<!-- <%//if(filename!=null&&!filename.equals("")){ %>
						<img alt="첨부파일" src="img/icon.gif" align="middle">	
					<%//}%> -->
					<%if(ccount>0){ %>
					<font color="black">[<%=ccount %>]</font>
					<%} %>
					</td>
					<td><%=name%></td>
					<td><%=regdate%></td>
					<td><%=lcount%></td>
				</tr>
				<%}//--for	%>
			</table>
		<%}//--if-else%>	
			</table>
				
			</div>
			<input type="hidden" id="movietitle" value="<%=movietitle%>">
		</div>
		</div>
		<form name="readFrm">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<input type="hidden" name="category" value="<%=category %>">
			<input type="hidden" name="num">
		</form>

		<script>
		(function() {
			  var youtube = document.querySelectorAll(".youtube-player");
			  for (var i = 0; i < youtube.length; i++) {
			    var source = "https://img.youtube.com/vi/"+ youtube[i].dataset.id +"/sddefault.jpg";
			    var image = new Image();
			    image.src = source;
			    image.addEventListener( "load", function() {
			      youtube[ i ].appendChild( image );
			    }( i ) );
			    youtube[i].addEventListener( "click", function() {
			      var iframe = document.createElement( "iframe" );
			      iframe.setAttribute( "frameborder", "0" );
			      iframe.setAttribute( "allowfullscreen", "" );
			      iframe.setAttribute( "width", "1000" ); // width 속성 추가
			      iframe.setAttribute( "height", "800" ); // height 속성 추가
			      iframe.setAttribute( "src", "https://www.youtube.com/embed/"+ this.dataset.id +"?rel=0&showinfo=0&autoplay=1" );
			      this.innerHTML = "";
			      this.appendChild( iframe );
			    } );
			  };
			})();
  const tabLinks = document.querySelectorAll('.tab-navigation a');
  const tabContents = document.querySelectorAll('.tab');
  const userid = '<%=userid %>';

  function setActiveTab(event) {
	    // 현재 클릭한 버튼의 data-tab 속성 값을 가져옵니다.
	    const targetTab = event.target.getAttribute('data-tab');
	    
	    tabContents.forEach(tab => tab.classList.remove('active'));

	    // 각 탭의 내용을 숨깁니다.
	   for (let i = 0; i < tabContents.length; i++) {
      if (tabContents[i].getAttribute('data-tab') === targetTab) {
        tabContents[i].classList.add('active');
      }
    }
		
}
  
	function sendAjax(idx, bc, fl) {
		$.ajax({
			  type: "POST",
			  url: "/movieProject/MovieGradeServlet",
			  data: { movieidx: idx, btncheck: bc, flag: fl }
			}).done(function( msg ) {
			  alert( "Data Saved: " + msg );
			});
	}
	
	function likedAjax(idx, fl) {
		$.ajax({
			  type: "POST",
			  url: "/movieProject/MovieLikedServlet",
			  data: { movieidx: idx, flag: fl, userid: userid}
			}).done(function( msg ) {
			  alert( "Data Saved: " + msg );
			});
	}
	
		var movietitie = document.getElementById("movietitle").value;
	  // 버튼에 클릭 이벤트를 등록합니다.
	  for (let i = 0; i < tabLinks.length; i++) {
	    const tabLink = tabLinks[i];
	    tabLink.addEventListener('click', setActiveTab);
	  }
	  
	    const button1 = document.getElementById('h-button');
	    const image1 = document.getElementById('h-image');

	    button1.addEventListener('click', () => {
	    	if(userid == null){
	    		alert("로그인 후 이용해 주세요.");
	    	} else {
	    		if (image1.src.endsWith('empty.png')) {
		    		likedAjax(<%=movieidx %>, false, userid);
		    	    image1.src = 'img/full.png';
		    	  } else if (image1.src.endsWith('full.png')) {
		    		likedAjax(<%=movieidx %>, true, userid);
		    	    image1.src = 'img/empty.png';
		    	}
	    	}
	    });
	    
	    
	    
	    const button2 = document.getElementById('b-button');
	    const image2 = document.getElementById('b-image');

	    button2.addEventListener('click', () => {
	      if (image2.src.endsWith('Ebad.png')) {
	    	  sendAjax(<%=movieidx %>, false, false);
	        image2.src = 'img/Fbad.png';
	      } else if (image2.src.endsWith('Fbad.png')) {
	    	  sendAjax(<%=movieidx %>, true, false);
	        image2.src = 'img/Ebad.png';
	      }
	      if (image3.src.endsWith('Fgood.png') && image2.src.endsWith('Fbad.png')) {
	    	    alert("이미 좋아요를 누른 상태입니다.");
	    	    image2.src = 'img/Ebad.png';
	    	  }
	    });

	    const button3 = document.getElementById('g-button');
	    const image3 = document.getElementById('g-image');

	    button3.addEventListener('click', () => {
	      if (image3.src.endsWith('Egood.png')) {
	    	  sendAjax(<%=movieidx %>, false, true);
	      	image3.src = 'img/Fgood.png';
	      } else if (image3.src.endsWith('Fgood.png')) {
	    	  sendAjax(<%=movieidx %>, true, true);
	        image3.src = 'img/Egood.png';
	      }
	      
	      if (image3.src.endsWith('Fgood.png') && image2.src.endsWith('Fbad.png')) {
	    	    alert("이미 싫어요를 누른 상태입니다.");
	    	    image3.src = 'img/Egood.png';
	    	  }
	    });
		function read(num)
		{
			document.readFrm.num.value=num;
			document.readFrm.action="reviewPage.jsp";
			document.readFrm.submit();
		}
   
	    
</script>
</body>
</html>
