<!-- memberUpdate.jsp -->
<%@page import="user.MovieMemberBeans" %>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="user.MovieMemberMgr"></jsp:useBean>
<%
	
	HttpSession mysession = request.getSession();
	String userId2 = (String) session.getAttribute("userId");
	
/* 	String usernm = (String) session.getAttribute("userNm"); */
	/* String userId = mgr.getUserId(usernm); */
	MovieMemberBeans bean2 = mgr.getMember(userId2);
	
%>

<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>mypage</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="css/mypage.css" />
    </head>
<title>Member Update</title>
<h1 style= "margin-left: 20px;">회원정보수정</h1>
</head>
<body>
<div class="container">
<div class="row" style="height: 20px;"></div>

<div class="row">
<form name="memupdate" method="post" action="/movieProject/memberUpdate"
 onsubmit="return validatePassword()&&validateNickname()&&passwordequals();">
	<div>
	<label>아이디</label>
	<input name="userid" id="userid" class="input_id" size="15" 
	value="<%=bean2.getUserid()%>" disabled>
	</div>
<br>
	<div>	
		<label>닉네임</label>
		<input name="usernn" id="usernn" class="input_nn" size="15" 
		value="<%=bean2.getUsernn()%>" required>	
		<font id = "checkNname" size="2"></font>
	</div>
<br>
<div>	
	<label>비밀번호</label>
	<input type="password" id="userpwd" name="userpwd" class="pw" size="15" 
	value="<%=bean2.getUserpwd()%>" required>	
</div>
<br>
<div>	
	<label>비밀번호 확인</label>
	<input type="password" id="userpwdCheck" name="pwdCheck" class="pw" size="15" required>	
	<font id="checkPw" size="2"></font>
</div>
<br>
<div>	
	<label for="year">년도:</label>
	<input name="usernn" id="usernn" class="input_nn" size="15" 
		value="<%=bean2.getBirth()%>" disabled>	
	
		
</div>

<br>
<div>	
	<label>성별</label>
	
	<%if(bean2.isGender()==false){%>	
	<input value="여" disabled> 	
	<% }else{%>
	<input value="남" disabled> 	
	<% }%>
</div>
<br>
<div>	
	<button type="submit">수정 완료</button>
	
</div>
<br>


</form>
</div>
</div>
<script>
var $j = jQuery.noConflict();
$j('.input_nn').keyup(function(){
	let usernn = $j('.input_nn').val(); //input_nn에 입력되는 값
	
	$j.ajax({
		url :"/movieProject/nnCheck",
		type : "post",
		data : {usernn:usernn},
		dataType : 'json',
		success : function(result){
			if(result==0){
				$j("#checkNname").html('사용할 수 없는 닉네임입니다.');
				$j("#checkNname").attr('color','red');
			}else if(result==1){
				$j("#checkNname").html('사용할 수 있는 닉네임입니다.');
				$j("#checkNname").attr('color','green');
			}else if(result==3){
				$j("#checkNname").html('기존의 닉네임과 같습니다.');
				$j("#checkNname").attr('color','red');
			}else if(result==2){
				$j("#checkNname").html('닉네임을 입력해주세요.');
				$j("#checkNname").attr('color','black');
			}
		},
		error :  function () {
			alert("서버요청실패");
			
		}
	})
	
})
	$j('.pw').keyup(function (){
		let userpwd = $j("#userpwd").val();
		let userpwdCheck = $j("#userpwdCheck").val();
		
		if(userpwd != "" || userpwdCheck !=""){
			if(userpwd == userpwdCheck){
				$j("#checkPw").html('일치');
				$j("#checkPw").attr('color','green');
			}else {
				$j("#checkPw").html('불일치');
				$j("#checkPw").attr('color','red');
			}
		} 
		
	})


// 비밀번호 유효성 검사
	function validatePassword() {
	  const password = document.getElementById("userpwd").value;
	  const passwordRegex = /^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+){6,}$/;
	  if (!passwordRegex.test(password)) {
	    alert("비밀번호는 알파벳과 숫자를 혼합한 6자 이상의 문자열이어야 합니다.");
	    return false;
	  }
	  return true;
	  
}



// 닉네임에는 특수문자 입력 불가
	function validateNickname() {
	  const nicknameInput = document.getElementById("usernn");
	  const nickname = nicknameInput.value.trim();
	  const specialChars = /[~!@#$%^&*()+=[\]{}\\|;:'",.<>/?]/;
	  if (specialChars.test(nickname)) {
	    alert("닉네임에 특수문자는 입력할 수 없습니다.");
	    nicknameInput.focus();
	    return false;
	  }
  		return true;

}
	// 비밀번호, 비밀번호확인 불일치면 가입 안됨.
	function passwordequals() {
		const userpwd = document.getElementById("userpwd").value;
		const userpwdCheck =document.getElementById("userpwdCheck").value;
		if(userpwd != userpwdCheck){
			alert("비밀번호를 확인해주세요.");
			return false;
		}
		return true;
		
	}

</script>
</body>
</html>