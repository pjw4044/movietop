<%@page import="user.MovieMemberMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="en">
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
 <%
	String userId = (String)session.getAttribute("userId");
	MovieMemberMgr memMgr = new MovieMemberMgr();
	String userNm = memMgr.getUserNm(userId);
%>
  
<body>
    <body>
        <div class ="container">
            <div class="row"> <!--메인로고-->
                <div class="col-12" style="padding: 0px;">
                <a href="mainpage1.jsp">
                    <img id="main_logo" src="img/logo1.png"  alt="img"
                        style="  width: 236px;
                        height: 92px;"  >  
                </a>
                </div>
            </div>
            <div class="row" style="height: 70px;">


            </div>


            <div class="row"> 
                <div class="col-1" "><!--프로필 이미지-->
                    <img src="img/profile.png" style="width: 90px; height: 90px;">
                </div>
                <div class="col-2"> <!--사용자 닉네임-->
                  <div>
                    <span><%=userNm %></span>
                  </div>
                </div>
                <div class="col-9">
                	<button onclick="showPrompt()">회원탈퇴</button>
                </div>
            </div>
<script>
function showPrompt() {

	
  var text = prompt("비밀번호를 입력해주세요:", "");
  if (text != null && text !="") {
      $.ajax({
		    url: "/movieProject/outUserServlet",
		    type: "POST",
		    data: JSON.stringify({text: text}),
		    contentType: "application/json",
		    success: function(data) {
		    	if("y"===data){
		    		alert("회원탈퇴 완료");
		    		location.href = "/movieProject/moviepage/login.jsp"
		    		
		    	}else if("n"===data)
		    	{
		    		location.reload();		    		
		    	}
		    	
		    },
		    error: function() {
		      // 요청이 실패했을 때 실행할 코드
		    }
		  });
  }else if(text ===""){
	  alert("비밀번호 입력하세요");
  }
}
</script>
            <div class="row" style="height: 20px;">
              <!--여백 -->
            </div>
       
            <div class="row"><!--마이페이지 탭-->
              <div class="col-2" style=" height: 700px;">
                <div class="ui inverted vertical menu" style="width: 200px; margin-top: 18px;">
                
                <div class="item" onclick="change(1)">
                	 <span style="height: 50px; font-size: 30px;">개인정보 수정</span>
       	 	            	   
                </div>
                <div class="item" onclick="change(2)">
                	<span style="height: 50px; font-size: 30px;">내가 쓴 글 </span>
                	
                </div>
                <div class="item" onclick="change(3)">
                	<span style="height: 50px; font-size: 30px;">좋아요 ♥</span>
                  
                </div>
                <div class="item" onclick="change(4)">
                	<span style="height: 50px; font-size: 30px;">쪽지</span>
                  
                </div>
                
                </div>
              </div>
              <div class="col-1" style="">
                <!--여백-->
              </div>
              <div class="col-9" style="">
                <div class = "tab tab1 active">
                   <div class="board1">
                   		<!-- <span>개인정보수정</span> -->
                		<%@ include file="memberUpdate.jsp" %>
                   </div> 
                
                
                </div>
                <div class="tab tab2" style="display: none">
                    <div class="board1">
                    	<%@ include file="myWriting.jsp" %>
                    
                    </div>
                
                </div>
                <div class="tab tab3" style="display: none">
                    <div class="board1">
                    	<%@ include file="myHeart.jsp" %>
                    </div>
                    
                </div>
                <div class="tab tab4" style="display: none">
                    <div class="board1">
                    
                    <%@ include file="checkMessage.jsp" %>
                    
                    </div>
                </div>

              </div>
                
            </div>

            <div class="row" style="height: 60px;">

            </div>
     
        </div>

</body>
<script>
    const change = (num) => {
      const tabList = document.querySelectorAll(".tab");
      tabList.forEach((el) => (el.style.display = "none"));
      const nowTab = document.querySelector(".tab" + num); 
      nowTab.style.display = "flex";
    };
  </script>
</html>