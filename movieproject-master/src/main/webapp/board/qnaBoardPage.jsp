<%@page import="user.MovieMemberBeans"%>
<%@page import="board.QnaAnswerBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="board.QnaBoardBean" %>
<%@ page import="universal.UtilMgr" %>

<jsp:useBean id="mgr" class="board.QnaMgr"/>
<jsp:useBean id="umgr" class="universal.UtilMgr"/>
<jsp:useBean id="mmgr" class="user.MovieMemberMgr"/>
<%
	String loginedid=(String)session.getAttribute("userId");
	boolean isLogined=!(loginedid==null || loginedid.trim().equals(""));
	String userNm=mmgr.getUserNm(loginedid);
	MovieMemberBeans loginedBean=mmgr.getMember(loginedid);
	boolean adminEd=false;
	if(loginedBean.isAdmin())
	{
		adminEd=true;
	}
	int totalRecord=0;
	int numPerPage=10;
	int pagePerBlock=15;
	int totalPage=0;
	int totalBlock=0;
	int nowPage=1;
	int nowBlock=1;
	int movieIdx=-1;
	String category="0";
	String keyField = "", keyWord = "";
	if(request.getParameter("numPerPage")!=null){
		numPerPage = UtilMgr.parseInt(request, "numPerPage");
	}
	if(request.getParameter("keyWord")!=null){
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	if(request.getParameter("reload")!=null&&
			request.getParameter("reload").equals("true")){
		keyField = ""; keyWord = "";
	}
	if(request.getParameter("nowPage")!=null){
		nowPage = UtilMgr.parseInt(request, "nowPage");
	}
	totalRecord=mgr.getQnaCount(keyField, keyWord);
	int start = (nowPage*numPerPage)-numPerPage;
	int cnt = numPerPage;
	
	totalPage=(int)Math.ceil((double)totalRecord/numPerPage);
	totalBlock=(int)Math.ceil((double)totalPage/pagePerBlock);
	nowBlock=(int)Math.ceil((double)nowPage/pagePerBlock);
%>
<!DOCTYPE HTML>
<html>
<head>
	<title>문의사항 - 무비어때</title>
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
		//if(document.searchFrm.keyWord.value==""){
		//	alert("검색어를 입력하세요.");
		//	document.searchFrm.keyWord.focus();
		//	return;
		//}
		document.searchFrm.submit();
	}
	function changeCategory(category)
	{
		document.readFrm.category.value=category;
		document.readFrm.submit();
	}
	function pageing(page) {
		document.readFrm.nowPage.value=page;  
		document.readFrm.submit();
	}
	function numPerFn(numPerPage) {
		document.readFrm.action="qnaBoardPage.jsp";
		document.readFrm.numPerPage.value=numPerPage;
		document.readFrm.submit();
	}
	function block(block) {
		document.readFrm.nowPage.value=
		<%=pagePerBlock%>*(block-1)+1;   
		document.readFrm.submit();
	}
	function read(num)
	{
		document.readFrm.num.value=num;
		document.readFrm.action="qnaPage.jsp";
		document.readFrm.submit();
	}
	function readAns(num)
	{
		document.readFrm.num.value=num;
		document.readFrm.action="qnaAnswerPage.jsp";
		document.readFrm.submit();
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
<h2>문의사항 - 무비어때</h2>
<table>
	<tr>
		<td width="600">
		총 게시글 수 : <%=totalRecord%> 개(<font color="red">
		<%=nowPage+"/"+totalPage%>쪽</font>)
		</td>
		<td align="right">
			<form name="npFrm" method="post">
				<select name="numPerPage" size="1" 
				onchange="javascript:numPerFn(this.form.numPerPage.value)">
    				<option value="5">5개 보기</option>
    				<option value="10" selected>10개 보기</option>
    				<option value="15">15개 보기</option>
    				<option value="30">30개 보기</option>
   				</select>
   				<script>document.npFrm.numPerPage.value=<%=numPerPage%></script>
   			</form>
		</td>
	</tr>
</table>
<table>
	<tr> 
		<td align="center" colspan="2">
		<%
				Vector<QnaBoardBean> vlist =mgr.getQnaBoardList(keyField, keyWord);
				int listSize = vlist.size();
				if(vlist.isEmpty()){
					out.println(" 등록된 게시물이 없습니다.");
				}else{
		%>
			<table cellspacing="0">
				<tr align="center" bgcolor="#D0D0D0">
					<td width="100">번 호</td>
					<td width="250">제 목</td>
					<td width="100">작성자</td>
					<td width="150">작성일</td>
				</tr>	
				<%
					for(int i=0;i<numPerPage/*10*/;i++){
						if(totalRecord-start-i<=0) break;
						//if(i==listSize) break;
						QnaBoardBean bean = vlist.get(totalRecord-start-i-1);
						if(bean.isSecret() && !(adminEd || (loginedid!=null && loginedid.equals(bean.getUserId()))))
						{
							%>
								<tr align="center">
								<td><%=totalRecord-start-i%></td>
								<td align="left">(비밀 문의사항입니다)
								</td>
								</tr>
							<%
						}
						else
						{
							int num = bean.getQnaIdx();
							String subject = bean.getTitle();
							String name=mmgr.getMember(bean.getUserId()).getUsernn();
							//String name = "dummy";
							String regdate = bean.getPostedDate().toString();
							//String filename = bean.getFilename();
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
					</td>
					<td><%=name%></td>
					<td><%=regdate%></td>
				</tr>
				<%if(mgr.hasAnswer(num)) {
					QnaAnswerBean ansb=mgr.getAnswer(num);
					String anst=ansb.getTitle();
					String ansn=ansb.getUserId();
					String ansd=ansb.getPostedDate().toString();
				%>
				<tr align="center">
				<td>ㄴ</td>
				<td align="left"><a href="javascript:readAns('<%=num%>')"><%=anst %></a></td>
				<td><%=ansn %></td>
				<td><%=ansd %></td>
				</tr>
				<%}}}//--for	%>
			</table>
		<%}//--if-else%>	
		</td>
	</tr>
	<tr>
		<td colspan="2"><br><br></td>
	</tr>
	<tr>
		<td>
		<!-- 페이징 및 블럭 Start -->
		<!-- 이전블럭 -->
		<%if(nowBlock>1){ %>
			<a href="javascript:block('<%=nowBlock-1%>')">prev...</a>
		<%}%>	
		<!-- 페이징 -->
		<%
				int pageStart = (nowBlock-1)*pagePerBlock+1;
				int pageEnd = (pageStart+pagePerBlock)<totalPage?
						pageStart+pagePerBlock:totalPage+1;
				for(;pageStart<pageEnd;pageStart++){
		%>
		<a href="javascript:pageing('<%=pageStart%>')">
		<%if(nowPage==pageStart){%><font color="blue"><%}%>
			[<%=pageStart%>]
		<%if(nowPage==pageStart){%></font><%}%>
		</a>
		<%}//--for%>
		<!-- 다음블럭 -->
		<%if(totalBlock>nowBlock){ %>
			<a href="javascript:block('<%=nowBlock+1%>')">...next</a>
		<%}%>
		<!-- 페이징 및 블럭 End -->
		</td>
		<td align="right">
		<%if(isLogined){ %>
			<a href="insertQnaPage.jsp">[문의하기]</a>
			<%} else { %>
			<a href="/movieProject/user/login.jsp">[문의하기]</a>
			<%} %>
			<a href="qnaBoardPage.jsp">[처음으로]</a>
		</td>
	</tr>
</table>

<hr width="750">
<form  name="searchFrm">
	<table  width="600" cellpadding="4" cellspacing="0">
 		<tr>
  			<td align="center" valign="bottom">
   				<select name="keyField" size="1" >
    				<option value="TITLE"> 제 목</option>
    				<option value="DETAIL"> 내 용</option>
   				</select>
   				<input size="16" name="keyWord">
   				<input type="button"  value="찾기" onClick="javascript:check()">
   				<input type="hidden" name="nowPage" value="1">
  			</td>
 		</tr>
	</table>
</form>

<form name="listFrm" method="post">
	<input type="hidden" name="reload" value="true">
	<input type="hidden" name="nowPage" value="1">
</form>

<form name="readFrm">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<input type="hidden" name="num">
</form>
</div>
</body>
</html>