<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="movie.MovieBean" %>
<%@ page import="movie.MovieMgr" %>

<jsp:useBean id="mgr" class="movie.MovieMgr"/>
<jsp:useBean id="mmgr" class="user.MovieMemberMgr"/>
<% %>
<%
	String loginedid=(String)session.getAttribute("userId");
	boolean isLogined=!(loginedid==null || loginedid.trim().equals(""));
	String userNm=mmgr.getUserNm(loginedid);
	Vector<MovieBean> cvlist=new Vector<MovieBean>();
	String keyWord="";
	if(request.getParameter("keyWord")!=null){
		keyWord = request.getParameter("keyWord");
		cvlist=mgr.searchMovieWhenInsert(keyWord);
	}
%>
<!DOCTYPE HTML>
<html>
<head>
	<title>영화 선택 - 무비어때</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>

	<link rel="stylesheet" href="css/boardpage.css" />
</head>
<script type="text/javascript">
	function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
	function mSel(mIdx) {
		document.searchFrm.movieIdx.value=mIdx;
		document.searchFrm.action = "insertReviewPage.jsp";
		document.searchFrm.submit();
	}
</script>
<body bgcolor="#FFFFFF">
    <div class="container"  >
        <div class="row">
            <div class="col-4" style="background-color: aqua; padding: 0px;">
                <img   class="img-fluid" id="main_logo" src="img/logo1.png" alt="img" >  
            
            </div>
            <div class="col-6" style=" padding: 0px;">
            <form  role="search" >
                    <input  class="form-control me-2" id="main_search" type="search" placeholder="Search" aria-label="Search">   

            </div>
            <div class="col-1" style=" padding: 0px;">
            
                <button  class="btn btn-outline-success" id="search_btn" type="submit" >검색</button>
            </div>
            </form>
            <div class="col-2" style=" padding: 0px;">
            <%if(loginedid == null){ %>
              <button type="button" class="btn" onclick="javascript:location.href='/movieProject/user/login.jsp'" >로그인</button>
              <button type="button" class="btn" onclick="javascript:location.href='/movieProject/user/memberJoin.jsp'">회원가입</button>
           <%}else {%>
              <button type="button" class="btn" onclick="javascript:location.href='/movieProject/user/myPage1.jsp'" ><%=userNm %></button>
              <button type="button" class="btn" onclick="javascript:location.href='/movieProject/logoutServlet'">로그아웃</button>
           <%} %> 
            </div>

        </div>
        <div class="row" style=" padding: 5px;">
        </div>
    
        <div class="row">
          <nav>
            <ul>
              <li><a class="navTop" href="/movieProject/user/mainpage1.jsp">홈</a></li>
              <li><a class="navTop" href="/movieProject/movie/rankingPage.jsp">랭킹</a></li>
              <li><a class="navTop" href="/movieProject/movie/movieList.jsp">영화</a></li>
              <li><a class="navTop" href="/movieProject/movie/recommendPage.jsp">추천</a></li>
              <li><a class="navTop" href="/movieProject/board/agoraBoardPage.jsp">토론</a></li>
              <li><a class="navTop" href="/movieProject/board/boardPage.jsp">게시판</a></li>
              <li><a class="navTop" href="/movieProject/board/qnaBoardPage.jsp">문의</a></li>
            </ul>
          </nav>
        </div>
<div align="center"><br/>
<h2>검색하고자 하는 영화의 제목을 입력하세요</h2>
<form  name="searchFrm">
	<table  width="600" cellpadding="4" cellspacing="0">
 		<tr>
  			<td align="center" valign="bottom">
   				<input size="16" name="keyWord">
   				<input type="button"  value="찾기" onClick="javascript:check()">
   				<input type="hidden" name="nowPage" value="1">
   				<input type="hidden" name="movieIdx">
  			</td>
 		</tr>
	</table>
</form>
<table>
<%
for(int i=0;i<cvlist.size();i++)
{
	MovieBean cbean=cvlist.get(i);
	
%>
	<tr>
		<td><%=i+1%> : </td>
		<td align="center" colspan="3" width="600"><%=cbean.getTitle()%></td>
		<td align="right" valign="middle">
		<input type="button" value="선택" onclick="mSel('<%=cbean.getMovieidx()%>')">
		</td>
	</tr>
	<tr>
		<td colspan="3"><br></td>
	</tr>
	<%
}
%>
<tr>
	<td align="right">
		<a href="insertAgoraPage.jsp">[영화 선택하지 않고 진행하기]</a>
		<a href="agoraBoardPage.jsp">[돌아가기]</a>
	</td>
</tr>
</table>
</div>
</body>
</html>