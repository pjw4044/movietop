<%@page import="java.io.File"%>
<%@ page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="board.AgoraBean" %>
<%@ page import="board.AgoraDiscussBean" %>
<%@ page import="universal.UtilMgr" %>
<%@ page import="user.MovieMemberBeans" %>

<jsp:useBean id="mgr" class="board.AgoraMgr"/>
<jsp:useBean id="mmgr" class="movie.MovieMgr"/>
<jsp:useBean id="memgr" class="user.MovieMemberMgr"/>

<%
	String loginedid=(String)session.getAttribute("userId");
	boolean isLogined=!(loginedid==null || loginedid.trim().equals(""));;
	String userNm=memgr.getUserNm(loginedid);
	//String loginedid="1q2w3e4r";
	MovieMemberBeans loginedBean=memgr.getMember(loginedid);
	boolean adminEd=false;
	if(loginedBean.isAdmin())
	{
		adminEd=true;
	}
	String nowPage = request.getParameter("nowPage");
	String numPerPage = request.getParameter("numPerPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	String flag = request.getParameter("flag");
	int num = UtilMgr.parseInt(request, "num");
	if(flag!=null){
		if(flag.equals("insert")){
			AgoraDiscussBean cbean = new AgoraDiscussBean();
			cbean.setAgoraIdx(num);
			cbean.setUserId(loginedid);
			cbean.setDetail(request.getParameter("comment"));
			mgr.insertAgoraDiscuss(cbean);
			flag=null;
		}else if(flag.equals("delete")){
			mgr.deleteAgoraDiscuss(UtilMgr.parseInt(request, "cnum"));
			flag=null;
		}
	}else{
		
	}
	AgoraBean bean=mgr.getAgora(num);
	Vector<AgoraDiscussBean> cvlist=mgr.getAgoraDiscuss(num);
	String title=bean.getAgoraTitle();
	//String posted=null;
	String posted=bean.getPostedDate().toString();
	String detail=bean.getAgoraDetail();
	MovieMemberBeans postedBean=memgr.getMember(bean.getUserId());
	String postedId=postedBean.getUserid();
	String postedNN=postedBean.getUsernn();
	String filename=bean.getFilename();
	int movieIdx=bean.getMovieIdx();
	String movieTitle="";
	if(movieIdx!=-1)
		movieTitle=mmgr.getMovie(movieIdx).get(0).getTitle();
	session.setAttribute("bean", bean);
	//String nn
%>

<!DOCTYPE html>
<html>
<head>
<title><%=title%> - 무비어때</title>
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
	function list() {
		document.listFrm.action = "agoraBoardPage.jsp";
		document.listFrm.submit();
	}
	function down(filename) {
		document.downFrm.filename.value=filename;
		document.downFrm.submit();
	}
	function delFn() {
		document.delFrm.submit();
	}
	function cInsert() {
		if(document.cFrm.comment.value==""){
			alert("의견을 입력하세요.");
			document.cFrm.comment.focus();
			return;
		}
		document.cFrm.submit();
	}
	function cDel(cnum) {
		document.cFrm.cnum.value=cnum;
		document.cFrm.flag.value="delete";
		document.cFrm.submit();
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
<br/><br/>
<table align="center" width="600" cellspacing="3">
 <tr>
  <td bgcolor="#DDDDDD" height="25" align="center">토론하기</td>
 </tr>
 <tr>
  <td colspan="2">
   <table cellpadding="3" cellspacing="0" width="100%"> 
    <tr> 
  <td align="center" bgcolor="#DDDDDD" width="10%"> 이 름 </td>
  <td bgcolor="#FFFFFF"><%=postedNN%></td>
  <td align="center" bgcolor="#DDDDDD" width="15%">등록날짜</td>
  <td bgcolor="#FFFFFF"><%=posted%></td>
 </tr>
 <tr> 
    <td align="center" bgcolor="#DDDDDD"> 제 목</td>
    <td bgcolor="#FFFFFF" colspan="3"><%=title%></td>
   </tr>

   <%
   String fileroute="C:/Jsp/eclipse-workspace/movieProject/src/main/webapp/board/boardfileupload/"+filename;
   File imgfile=new File(fileroute);
   if(imgfile.exists()){
   %>
   <tr>
   <td colspan="4"><br><br><img src="/movieProject/board/boardfileupload/<%=filename %>" border="300px" width="300px" height="300px"><br><br></td>
   </tr>
   <%} %>
   <tr> 
    <td colspan="4"><br/><pre><%=detail%></pre><br/></td>
   </tr>
   <%if(movieIdx!=-1){ %>
   <tr>
   <td colspan="4" align="right">
   	관련 영화 : <a href="/movieProject/movie/movieDetail.jsp?title=<%=movieTitle%>"><%=movieTitle %></a>
   </td>
   </tr>
   <%} %>
   <tr>
    <td colspan="4" align="right">
     작성자 / <%=bean.getUserId()%>
    </td>
   </tr>
   </table>
  </td>
 </tr>
 <tr>
 <tr>
  <td align="center" colspan="2">
  <%if(isLogined){ %>
   <form method="post" name="cFrm">
		<table>
			<tr align="center">
				<td>의견쓰기</td>
				<td>
				<input name="comment" size="50"> 
				<input type="button" value="등록" onclick="cInsert()"></td>
			</tr>
		</table>
	 <input type="hidden" name="flag" value="insert">	
	 <input type="hidden" name="num" value="<%=num%>">
	 <input type="hidden" name="cnum">
    <input type="hidden" name="nowPage" value="<%=nowPage%>">
    <input type="hidden" name="numPerPage" value="<%=numPerPage%>">
   <%if(!(keyWord==null||keyWord.equals(""))){ %>
    <input type="hidden" name="keyField" value="<%=keyField%>">
    <input type="hidden" name="keyWord" value="<%=keyWord%>">
	<%}%>
	</form><!-- 댓글 입력폼 End -->
	<%} %>
 <hr/>
 <!-- 댓글 List Start -->
<table>
<%
for(int i=0;i<cvlist.size();i++)
{
	AgoraDiscussBean cbean=cvlist.get(i);
	int cnum=cbean.getDiscussIdx();
	MovieMemberBeans cmbean=memgr.getMember(cbean.getUserId());
	String cname=cmbean.getUserid();
	String comment=cbean.getDetail();
	String cmem=cmbean.getUsernn();
	String cregdate=cbean.getPostedDate().toString();
	//String cmem=MovieMemberMgr.getUserNN(cbean.getUserId());
%>
	  	<tr>
			<td colspan="3" width="600"><b><%=cmem%></b></td>
	</tr>
	<tr>
		<td>댓글:<%=comment%></td>
		<td align="right"><%=cregdate%></td>
		<td align="center" valign="middle">
		<%if((isLogined && loginedid.equals(cname)) || adminEd) {%>
		<input type="button" value="삭제" onclick="cDel('<%=cnum%>')"><%} %>
		</td>
	</tr>
	<tr>
		<td colspan="3"><br></td>
	</tr>
	<%
}
%>
</table>
 <!-- 댓글 List End -->
 [ <a href="javascript:list()" >리스트</a> <%if((isLogined && loginedid.equals(postedId)) || adminEd) {%>| 
 <a href="javascript:delFn()">삭 제</a><%} %> ]<br/>
  </td>
 </tr>
</table>
<form method="post" name="downFrm" action="download.jsp">
	<input type="hidden" name="filename">
</form>

<form name="listFrm">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<%if(!(keyWord==null||keyWord.equals(""))){%>
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<%}%>
</form>

<form name="delFrm" action="agoraDelete" method="post">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<%if(!(keyWord==null||keyWord.equals(""))){%>
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<%}%>
</form>

<form name="likeFrm">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<%if(!(keyWord==null||keyWord.equals(""))){%>
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<%}%>
</form>
</body>
</html>