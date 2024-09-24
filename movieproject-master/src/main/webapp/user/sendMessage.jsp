<%@page import="user.MovieMemberMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
		MovieMemberMgr memMgr = new MovieMemberMgr();
		HttpSession mySession = request.getSession();
		String userId = (String)mySession.getAttribute("userId");
		String userNm = memMgr.getUserNm(userId);
		
%>
<html>
<head>
</head>
<body>
	<div>
		<div class="message_div">
		<div ><h2>쪽지쓰기</h2></div>
<form name="postFrm" method="post" action="/movieProject/messageServlet" 
enctype="multipart/form-data">
<table width="600" cellpadding="3" align="center">
	<tr>
		<td align=center>
		<table align="center">
			<tr>
				<td width="10%">보내는 사람</td>
				<td width="90%">
				<input name="sendName" size="10" maxlength="8" value="<%=userNm%>" disabled></td>
			</tr>
			<tr>
				<td width="10%">받는 사람</td>
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
					 <input type="button" value="리스트" "onclick="javascript:location.href='mainpage1.jsp'">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
	</form>	
		</div>
	</div>
	
</body>
</html>