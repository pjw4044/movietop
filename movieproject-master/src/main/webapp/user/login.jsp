<!-- login.jsp -->
<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

<link rel="stylesheet" href="css/loginpage.css" />
</head>
<body>
<form method="post" action="/movieProject/loginServlet">
    
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
                <span class="logintext">로그인</span>
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
                <input  type="text" class="inputId" id="userid" name="userid" style="display: inline-block;">
            </div>
            <div class ="col-3"></div>
                

        </div>
        <div style="height: 20px;"></div>
        <div class="row justify-content-center">
            <div class ="col-3" >
                
            </div>
            <div class="col-6"  >
                <div style="display: inline-block;  margin-right: 60px;">
                    <span>비밀번호</span>
                </div>
                <input  type="password" class="inputId" id="userpwd" name="userpwd" style="display: inline-block;">
            </div>
            <div class ="col-3"></div>
                

        </div>
        <div style="height: 20px;"></div>
        <div class="row justify-content-center">
            <div class ="col-3" >
                
            </div>
            <div class="col-6" >
                <div class="row justify-content-center">
                    <div class="col-3"></div>
                    <div class="col-6">
                      <div class="d-flex justify-content-between">
                        <div><a href="findId.jsp"><p>아이디 찾기</p></a></div>
                        <div><a href="findPw.jsp"><p>비밀번호 찾기</p></a></div>
                        <div><p><a href="javascript:location.href='memberJoin.jsp'">회원가입</a></p></div> 
                      </div>
                    </div>
                    <div class="col-3"></div>
                </div>
            </div>
            <div class ="col-3"  ></div>

        </div>
        <div class="row justify-content-center">
            <div class ="col-3" >
                
            </div>
            <div class="col-6"  ><!--로그인버튼-->
                <button type="submit" class="loginbtn" style="margin-left: 130px;">
                    <span class="loginbtntext">로그인</span>
                </button>
                
            </div>
            <div class ="col-3"  ></div>
                

        </div>
        <div class="row justify-content-center">
            <div class ="col-3" >
                
            </div>
            <div class="col-6" style="margin-top: 15px;" ><!--로그인버튼-->
                <button class="loginbtn" style="margin-left: 130px;">
                    카카오 로그인
                </button>
                
            </div>
            <div class ="col-3" style="background-color: white" ></div>
                

        </div>






    </div>
    

    
        
</form>
   
</body>
</html>