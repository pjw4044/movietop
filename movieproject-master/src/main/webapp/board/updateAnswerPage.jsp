<%@page import="user.MovieMemberBeans"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="board.QnaAnswerBean" %>

<jsp:useBean id="mgr" class="board.QnaMgr"/>
<jsp:useBean id="umgr" class="universal.UtilMgr"/>
<jsp:useBean id="memgr" class="user.MovieMemberMgr"/>
<%
	String loginedid=(String)session.getAttribute("userId");
	boolean isLogined=!(loginedid==null || loginedid.trim().equals(""));
	String userNm=memgr.getUserNm(loginedid);
	//String loginedid="1q2w3e4r";
	MovieMemberBeans loginedBean=memgr.getMember(loginedid);
	String nowPage = request.getParameter("nowPage");
	String numPerPage = request.getParameter("numPerPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	int num = umgr.parseInt(request, "num");
	QnaAnswerBean bean=mgr.getAnswer(num);
	String title=bean.getTitle();
	//String posted=null;
	String posted=bean.getPostedDate().toString();
	String detail=bean.getDetail();
	MovieMemberBeans postedBean=memgr.getMember(bean.getUserId());
	String postedId=postedBean.getUserid();
	//String postedId="1q2w3e4r";
	String filename=bean.getFilename();
	//String nn
%>
<!DOCTYPE html>
<html>
<head>
<title>일반 게시판 글 수정 - 무비어때</title>
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
<div align="center">
<br/><br/>
<table width="600" cellpadding="3">
	<tr>
		<td bgcolor="84F399" height="25" align="center">글쓰기</td>
	</tr>
</table>
<br/>
<form name="postFrm" method="post" action="UpdateReview" 
enctype="multipart/form-data">
<table width="600" cellpadding="3" align="center">
	<tr>
		<td align=center>
		<table align="center">
			<tr>
				<td>제 목</td>
				<td>
				<input name="TITLE" size="50" maxlength="100" value="<%=title%>"></td>
			</tr>
			<tr>
				<td>분 류</td>
				<td align="right">
					<form name="catFrm" method="post">
						<select name="CATEGORY" size="1">
						<%if(category.equals("리뷰")) {%>
						<option value="리뷰" selected>리뷰</option>
						<%}else{ %>
						<option value="리뷰">리뷰</option>
						<%} if(category.equals("추천")) {%>
						<option value="추천" selected>추천</option>
						<%}else{ %>
						<option value="추천">추천</option>
						<%} if(category.equals("일반")) { %>
						<option value="일반" selected>일반</option>
						<%}else{ %>
						<option value="일반">일반</option>
						<%} %>
					</select>
					</form>
				</td>
			</tr>
			<tr>
				<td>내 용</td>
				<td><textarea name="DETAIL" rows="10" cols="50"><%=detail %></textarea></td>
			</tr>
			<tr>
			 <tr>
     			<td>파일찾기</td> 
     			<td><input type="file" name="filename" size="50" maxlength="50" value="<%=filename%>"></td>
    		</tr>
 			<tr>
 				<td>내용타입</td>
 				<td> HTML<input type=radio name="contentType" value="HTTP" >&nbsp;&nbsp;&nbsp;
  			 	TEXT<input type=radio name="contentType" value="TEXT" checked>
  			 	</td>
 			</tr>
			<tr>
				<td colspan="2"><hr/></td>
			</tr>
			<tr>
				<td colspan="2">
					 <input type="submit" value="등록">
					 <input type="reset" value="다시쓰기">
					 <input type="button" value="리스트" onClick="javascript:location.href='boardPage.jsp'">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
<input type="hidden" name="orignum" value="<%=num%>">
<input type="hidden" name="LIKED" value="<%=liked %>">
<input type="hidden" name="USERID" value="<%=loginedid%>">
</form>
</div>
</body>
</html>