<%@page contentType="text/html; charset=UTF-8"%>
<html>
<head>

</head>
<script >
	

</script>
<body>
<%
		String pw=(String)request.getAttribute("pw");
		
%>

	<div class= "find_div">
		<div>
			<form name="postFrm" method="post" action="/movieProject/findPwServlet" 
enctype="multipart/form-data">
<table width="600" cellpadding="3" align="center">
	<tr>
		<td align=center>
		<table align="center">
			<tr>
				<td width="50%">아이디와 생년 정보 입력</td>
			</tr>
			<tr>
				<td width="10%">아이디</td>
				<td width="90%">
				<input name="sendId" size="10" maxlength="14" ></td>
			</tr>
			<tr>
				<td width="30%">생년입력(연도만 입력  ex:1999)</td>
				<td width="90%">
				<input name="sendBirth" size="10" maxlength="14" ></td>
			</tr>
			
			<tr>
				<td colspan="2">
					 <input type="submit" value="찾기">
					 <input type="button" value="로그인화면으로" onClick="javascript:location.href='moviepage/login.jsp'">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
	</form>	
		</div>
	
	</div>
	<div style="text-align: center;">
	<%
	if(pw == null){
			
		}else if("no".equals(pw)==false && "".equals(pw)==false){
			
	%>
	<h3 >비밀번호는 <%=pw %> 입니다.</h3>
		<% }else if("no".equals(pw)){%>
		<h3>입력하신 정보가 맞지않습니다</h3>
		<%} %>
	</div>

</body>


</html>