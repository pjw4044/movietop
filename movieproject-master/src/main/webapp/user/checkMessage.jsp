<%@page import="user.MovieMemberMgr"%>
<%@page import="movie.MessageMgr"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="movie.MessageBean"%>
	
<%@page import="java.util.Vector"%>
<%@page import="universal.UtilMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr5" class="movie.MessageMgr"/>
<%
int totalRecord = 0;//총게시물수
int numPerPage = 10;//페이지당 레코드 개수 (5,10,20,30)
int pagePerBlock = 15;
int totalPage = 0;//총 페이지 개수
int totalBlock = 0;//총 블럭 개수
int nowPage = 1;//현재 페이지
int nowBlock = 1;//현재 블럭
	MovieMemberMgr memMgr5 = new MovieMemberMgr();
	HttpSession mysession5 = request.getSession();
	//유저 아이디
	String userId5 = (String)mysession5.getAttribute("userId");
	//유저 닉네임
	String userNm5 = memMgr5.getUserNm(userId5);
//요청된 numPerPage 처리
if(request.getParameter("numPerPage")!=null){
	numPerPage = UtilMgr.parseInt(request, "numPerPage");
}

//검색에 필요한 변수
String keyField = "", keyWord = "";
if(request.getParameter("keyWord")!=null){
	keyField = request.getParameter("keyField");
	keyWord = request.getParameter("keyWord");
}

//검색 후에 다시 reset 요청
if(request.getParameter("reload")!=null&&
		request.getParameter("reload").equals("true")){
	keyField = ""; keyWord = "";
}

totalRecord = mgr5.getTotalCount(userId5);
//out.print(totalRecord);

if(request.getParameter("nowPage")!=null){
	nowPage = UtilMgr.parseInt(request, "nowPage");
}
//sql문에 들어가는 statr, cnt 선언
int start = (nowPage*numPerPage)-numPerPage;
int cnt = numPerPage;

//전체페이지 개수
totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
//전체블럭 개수
totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
//현재블럭 개수
nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
//out.println("totalPage : " + totalPage +"<br>");
//out.println("totalBlock : " + totalBlock +"<br>");
//out.println("nowBlock : " + nowBlock +"<br>");
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

</head>
<script type="text/javascript">

	function pageing(page) {
		document.readFrm.nowPage.value=page;  
		document.readFrm.submit();
	}
	function block(block) {
		document.readFrm.nowPage.value=
		<%=pagePerBlock%>*(block-1)+1;   
		document.readFrm.submit();
	}
	function numPerFn(numPerPage) {
		document.readFrm.action="list.jsp";
		document.readFrm.numPerPage.value=numPerPage;
		document.readFrm.submit();
	}
	function read(ref) {
		document.readFrm.num.value=ref;
		document.readFrm.action="messageRead.jsp";
		document.readFrm.submit();
	}
</script>
<div><!-- 쪽지 페이지 전체 -->
<div class = "message message1">

<table>
	<tr> 
		<td align="center" colspan="2">
		<%
				Vector<MessageBean> vlist = 
				mgr5.getBoardList(userId5, start, cnt);
				int listSize = vlist.size();
				if(vlist.isEmpty()){
					out.println("등록된 쪽지가 없습니다.");
				}else{
		%>
			<table cellspacing="0">
				 <tr>
   	 				<td colspan="4"	><%=userNm5 %>님의 쪽지함</td>
  				</tr>
				<tr align="center" bgcolor="#D0D0D0">
					<td width="100">번 호</td>
					<td width="100">보낸사람</td>
					<td width="150">제 목</td>
					<td width="150">날 짜</td>
				</tr>	
				<%
					for(int i=0;i<numPerPage/*10*/;i++){
						if(i==listSize) break;
						MessageBean bean = vlist.get(i);
						int num = bean.getIdx();
						String title = bean.getTitle();
						int ref = bean.getRef();
						String name = bean.getSender();
						String regdate = bean.getRegDate();

				%>
				<tr align="center">
					<td><input type="checkbox" name="deletebox[]" value="<%=totalRecord-start-i%>" >&nbsp;&nbsp;<%=totalRecord-start-i%></td>
					<td><%=name%></td>
					<td align="left">
					<a href="messageRead.jsp?ref=<%=totalRecord-start-i%>">
					<%=title%></a>
					</td>
					<td><%=regdate%></td>
				</tr>
				<%}//--for	%>
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
			<a href="javascript:sendMessage(2)">[쪽지쓰기]</a>
			<a href="javascript:deleteMessage()">[삭제하기]</a>
		</td>	
	</tr>
</table>
</div>
<script >
const sendMessage = (num) => {
	const tabList = document.querySelectorAll(".message");
	tabList.forEach((el) => (el.style.display = "none"));
    const nowTab = document.querySelector(".message" + num);
    nowTab.style.display = "block";
}
function deleteMessage() {
	 var checkboxes = document.getElementsByName("deletebox[]");
	  var message_idx = [];
	  for (var i = checkboxes.length-1; i >=0 ; i--) {
		    if (checkboxes[i].checked) {
		        var message_id = checkboxes[i].value;
		        message_idx.push(message_id);
		        
		      }
	  }
	  $.ajax({
		    url: "/movieProject/messageDeleteServlet",
		    type: "POST",
		    data: JSON.stringify({message_idx: message_idx}),
		    contentType: "application/json",
		    success: function(data) {
		    	location.reload();
		    	
		    },
		    error: function() {
		      // 요청이 실패했을 때 실행할 코드
		    }
		  });
}
</script>
<form name="readFrm">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<input type="hidden" name="num">
</form>
<div class = "message message2" style="display: none;">


		<div style="text-align: center;"><h2>쪽지쓰기</h2></div>
<form name="postFrm" method="post" action="/movieProject/messageServlet" 
enctype="multipart/form-data">
<table width="600" cellpadding="3" align="center">
	<tr>
		<td align=center>
		<table align="center">
			<tr>
				<td width="20%">보내는 사람</td>
				<td width="90%">
				<input name="sendName" size="10" maxlength="8" value="<%=userNm5%>" disabled></td>
			</tr>
			<tr>
				<td width="20%">받는 사람</td>
				<td width="90%">
				<input name="takeName" size="10" maxlength="8" ></td>
			</tr>
			<tr>
				<td>제 목</td>
				<td>
				<input name="subject" size="50" maxlength="30" ></td>
			</tr>
			<tr>
				<td>내 용</td>
				<td><textarea name="content" rows="10" cols="50">내용테스트</textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					 <input type="submit" value="등록">
					 <input type="button" value="리스트" onClick="javascript:sendMessage(1)">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
	</form>	
</div><!-- 쪽지 쓰기 div -->


</div><!-- 쪽지 페이지 전체 div -->
</html>