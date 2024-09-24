<!-- memberJoin.jsp -->
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="user.MovieMemberMgr"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>joinpage</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        
    <link rel="stylesheet" href="css/loginpage.css" />
</head>
<body>
<form name = "join" method="post" action = "/movieProject/memberJoin" onsubmit="return validateId()&&validatePassword()&&validateNickname()&&passwordequals();">
    <div class="container" >
        <div class="row"> <!--메인로고-->
            <div class="col-12" >
                <img id="main_logo" src="img/logo1.png"  alt="img"
                    style="  width: 236px;
                    height: 92px;" onclick="javascript:location.href='mainpage1.jsp'" >  
            </div>
        </div>
        <div class="row" style="height: 50px;">
            <!--여백-->
        </div>
    </div>
    <div class="container text-center ">
        <div >
            <span class="logintext">회원가입</span>
        </div>
        <div style="height: 50px;"></div>
    </div>  
    <div class="container">
        <div class="row justify-content-center">
            <div class ="col-3">
                
            </div>
            <div class="col-6">
                <div style="display: inline-block;  margin-right: 75px;">
                    <span>아이디</span>
                </div>
                <input  type="text" class="inputId" id="userid" name="userid" style="display: inline-block;" required>
            </div>
            <div class ="col-3" style="padding: 0px; margin: 0px;">
              <p style="padding-top: 15px; margin-left: -20px;">
                <font id = "checkId" size="3"></font></p>
            </div>
        </div>

        <div style="height: 20px;"></div>

        <div class="row justify-content-center">
            <div class ="col-3">
                
            </div>
            <div class="col-6">
                <div style="display: inline-block;  margin-right: 75px;">
                    <span>닉네임</span>
                </div>
                <input  type="text" class="inputId" id="usernn" name="usernn" style="display: inline-block;" required>
            </div>
            <div class ="col-3" style="padding: 0px; margin: 0px;">
                <p style="padding-top: 40px; margin: 0px;">
                <font id = "checkNname" size="3"></font></p>
            </div>
        </div>

        <div style="height: 20px;"></div>

        <div class="row justify-content-center">
            <div class ="col-3">
                
            </div>
            <div class="col-6">
                <div style="display: inline-block;  margin-right: 60px;">
                    <span>비밀번호</span>
                </div>
                <input  type="password" class="inputId" id="userpwd" name="userpwd" style="display: inline-block;"required>
            </div>
            <div class ="col-3" style="padding: 0px; margin: 0px;">
                
            </div>
        </div>

        <div style="height: 20px;"></div>

        <div class="row justify-content-center">
            <div class ="col-3">
                
            </div>
            <div class="col-6">
                <div style="display: inline-block;  margin-right: 26px;">
                    <span>비밀번호확인</span>
                </div>
                <input  type="password" class="inputId" id="userpwdCheck" name="userpwdCheck" style="display: inline-block;" required>
            </div>
            <div class ="col-3" style="padding: 0px; margin: 0px;">
                <p style="padding-top: 40px; margin: 0px;">
                <font id="checkPw" size="3"></font>
                </p>
            </div>
        </div>

        <div style="height: 20px;"></div>

        <div class="row justify-content-center"  style="height: 64px;">
            <div class ="col-3">
                
            </div>
            <div class="col-6">
                <div style="display: inline-block;  margin-right: 26px;">
                    <span>연도</span>
                </div>
                <select id="birth" name="birth" required style="margin-left: 250px;"></select>
                <script>
	  				var currentYear = new Date().getFullYear();
					var startYear = 1900;
					var select = document.getElementById("birth");
					for(var i = currentYear; i >= startYear; i--) {
					var option = document.createElement("option");
					option.value = i;
					option.text = i;
					select.add(option);
					  }
					</script>
            </div>
            <div class ="col-3" style="padding: 0px; margin: 0px;">
                
            </div>
        </div>

        <div style="height: 20px;"></div>

        <div class="row justify-content-center"  style="height: 64px;">
            <div class ="col-3">
                
            </div>
            <div class="col-6">
                <div style="display: inline-block;  margin-right: 26px;">
                    <span>성별</span>
                </div>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
                <label>남</label> &nbsp;<input type="radio" name="gender" value="1" size="15" required >

	            <label>여</label> &nbsp;<input type="radio" name="gender" value="0" size="15" required>	
            </div>
            <div class ="col-3" style="padding: 0px; margin: 0px;">
                
            </div>
        </div>

        <div style="height: 20px;"></div>

        <div class="row justify-content-center">
            <div class ="col-3" >
                
            </div>
            <div class="col-6"  ><!--회원가입-->
                <button type="submit" class="loginbtn" style="margin-left: 130px;">
                    <span class="loginbtntext">회원가입</span>
                </button>
                
            </div>
            <div class ="col-3"  ></div>
              
        </div>     
    </div>
    </form>
    

</body>

<script>
	var $j = jQuery.noConflict();
	$j('#userid').keyup(function(){ //keyup 은 키보드에서 손을 떼어냈을때 이벤트 발생
		let userid = $j('#userid').val(); //input_id에 입력되는 값
		
		$j.ajax({
			url :"/movieProject/idCheck",
			type : "post",
			data : {userid:userid},
			dataType : 'json',
			success : function(result){
				if(result==0){
					$j("#checkId").html('사용할 수 없는 아이디입니다.');
					$j("#checkId").attr('color','red');
				}else if(result==1){
					$j("#checkId").html('사용할 수 있는 아이디입니다.');
					$j("#checkId").attr('color','green');
				}else{
					$j("#checkId").html('아이디를 입력해주세요.');
					$j("#checkId").attr('color','black');
				}
			},
			error :  function () {
				alert("서버요청실패");
				
			}
		})
	})
	
	$j('#usernn').keyup(function(){
		let usernn = $j('#usernn').val(); //input_nn에 입력되는 값
		
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
				}else{
					$j("#checkNname").html('닉네임을 입력해주세요.');
					$j("#checkNname").attr('color','black');
				}
			},
			error :  function () {
				alert("서버요청실패");
				
			}
		})
	})
	
	$j('.inputId').keyup(function (){
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
	
	// 아이디 유효성 검사
	function validateId() {
	  const userid = document.getElementById("userid").value;
	  const idRegex = /^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+){6,}$/;
	  if (!idRegex.test(userid)) {
	    alert("아이디는 알파벳과 숫자를 혼합한 6자 이상의 문자열이어야 합니다.");
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
</html>