<%@page import="user.MovieMemberBeans"%>
<%@page import="movie.MovieBean"%>
<%@page import="user.MovieMemberMgr"%>
<%@page import="movie.MessageBean"%>
<%@page import="movie.MessageMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
		HttpSession mysession = request.getSession();
		String	userId = (String)mysession.getAttribute("userId");		
		MessageMgr mgr = new MessageMgr();
		MovieMemberMgr mvmgr = new MovieMemberMgr();
		 int ref =0;
		 MovieMemberBeans memBean = mvmgr.getMember(userId);
		 String str = request.getParameter("ref");
			
			try{
				ref = Integer.valueOf(str); 	
			}catch(NumberFormatException ex){
			}
		 MessageBean bean = mgr.getMessage(userId, ref);
		String sender = bean.getSender();
		String recipient = bean.getRecipient();
		String title = bean.getTitle();
		String content = bean.getContent();
		String regDate = bean.getRegDate();
%>
	<div class = "readMessage">
		
<form name="postFrm" method="post" action="/myapp/movieProject/messageServlet" 
enctype="multipart/form-data">
<table width="600" cellpadding="3" align="center">
	<tr>
		<td align=center>
		<table align="center">
			<tr>
				<td width="10%">날짜</td>
				<td width="90%">
				<input name="sendName" size="10" maxlength="8" value="<%=regDate%>" disabled></td>
			</tr>
			<tr>
				<td width="15%">보내는 사람</td>
				<td width="90%">
				<input name="sendName" size="10" maxlength="8" value="<%=sender%>" disabled></td>
			</tr>
			
			<tr>
				<td>제 목</td>
				<td>
				<input name="subject" size="50" maxlength="30" value="<%=title%>" disabled></td>
			</tr>
			<tr>
				<td>내 용</td>
				<td><textarea name="content" rows="10" cols="50"  disabled><%=content%></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					 <input type="button" value="리스트" onClick="javascript:location.href='checkMessage.jsp'">
					 <input type="button" value="답장" onClick="javascript:location.href='sendMessage.jsp'">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
	</form>	
		</div>
	</div>