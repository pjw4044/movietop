<%@page import="user.MovieMemberMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="movie.MovieBean"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="movie.RankMgr"%>

<%@page import="org.json.simple.parser.ParseException"%>
<%@page import="org.json.simple.parser.JSONParser"%>

<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>

<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%
	String userId = (String)session.getAttribute("userId");
	MovieMemberMgr memMgr = new MovieMemberMgr();
	String userNm = memMgr.getUserNm(userId);
	System.out.println(memMgr.getMember(userId).isAdmin());
	RankMgr rmgr = new RankMgr();
	Calendar cal = Calendar.getInstance();
	 String poster[]=new String[5];
	 List<MovieBean> vlist;
	
	cal.add(Calendar.DATE, -1); // 오늘 날짜에서 -1을 뺀다.
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd"); // 날짜 포맷을 지정한다.
	String day = dateFormat.format(cal.getTime()); // 포맷에 맞게 문자열로 변환한다.
    
	String url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt="+day; // HTTP 요청할 URL
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>mainpage</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>

	<link rel="stylesheet" href="css/mainpage.css" />
</head>

<script>

//마우스 올렸을 때 rank포스터에 텍스트 출력
function showInfo(movieNm,rank){
	document.getElementById("imageEvent"+rank).style.display="block";

}
//마우스 올렸을 때 rank포스터에 텍스트 사라짐
function hideInfo(rank){
	  document.getElementById("imageEvent"+rank).style.display="none";

}
</script>
<body>
<% 
	URL obj = new URL(url);
    HttpURLConnection con = (HttpURLConnection) obj.openConnection();
    con.setRequestMethod("GET");

 // HTTP 응답 코드가 200인 경우에만 처리
    if (con.getResponseCode() == 200) {
        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuilder res = new StringBuilder();
        while ((inputLine = in.readLine()) != null) {
            res.append(inputLine);
        }
        in.close();
        JSONParser parser = new JSONParser();
        JSONObject json = (JSONObject) parser.parse(res.toString());
        JSONArray dailyBoxOfficeList = (JSONArray) ((JSONObject)json.get("boxOfficeResult")).get("dailyBoxOfficeList");
        
        // 필요한 데이터 추출
        %>


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
            <%if(userId == null){ %>
              <button type="button" class="btn" onclick="javascript:location.href='login.jsp'" >로그인</button>
              <button type="button" class="btn" onclick="javascript:location.href='memberJoin.jsp'">회원가입</button>
           <%}else {%>
              <button type="button" class="btn" onclick="javascript:location.href='myPage1.jsp'" ><%=userNm %></button>
              <button type="button" class="btn" onclick="javascript:location.href='/movieProject/logoutServlet'">로그아웃</button>
           <%} %> 
            </div>

        </div>
        <div class="row" style=" padding: 5px;">
        </div>
    
        <div class="row">
          <nav>
            <ul>
              <li><a href="/movieProject/user/mainpage1.jsp">홈</a></li>
              <li><a href="/movieProject/movie/rankingPage.jsp">랭킹</a></li>
              <li><a href="/movieProject/movie/movieList.jsp">영화</a></li>
              <li><a href="/movieProject/movie/recommendPage.jsp">추천</a></li>
              <li><a href="/movieProject/board/agoraBoardPage.jsp">토론</a></li>
              <li><a href="/movieProject/board/boardPage.jsp">게시판</a></li>
              <li><a href="/movieProject/board/qnaBoardPage.jsp">문의</a></li>
            </ul>
          </nav>
        </div>
        <div class="row">
          <div>
            <span class="ranktext">
              현재 상영 순위
            </span>
          </div>
        </div>
        <div class="row">
          <div class="back1"> <!-- 첫번째 보드 -->
			<ol class = "rank_ol" >
		        <%for (int i = 0; i < 5; i++) {
		            JSONObject movieData = (JSONObject) dailyBoxOfficeList.get(i);
		            String id = (String) movieData.get("movieCd");
		            String openDay = (String) movieData.get("openDt");
		            String movieNm = (String) movieData.get("movieNm");
		            int audiCnt = Integer.valueOf((String)movieData.get("audiCnt"));
		            int audiAcc = Integer.valueOf((String) movieData.get("audiAcc"));
		            String genres = rmgr.getGenres(movieNm);
		            String actor = rmgr.getActor(id);
		            poster[i] = rmgr.getImg(movieNm);
		  %>
		<li class = "rank_li" style ="font-weight : bold; list-style-position: inside; margin: 15px;" >
		<div >
			<div style="position: relative; display: flex; flex-direction: column;">	
				<!-- href를 게시판 jsp로 넘어가야함 -->
				<a href="/movieProject/movie/movieDetail.jsp?title=<%=movieNm%>">
				<img alt="No-Image" width = "200" height = "300" src="<%=poster[i]%>" 
				 onmouseover = "javascript:showInfo('<%=movieNm %>',<%=i %>)"  onmouseout = "javascript:hideInfo('<%=i%>')">					
					<div class= "divinfo" id="imageEvent<%=i%>"  style="display : none; position: absolute; top: 0; left: 0; width: 100%; " >
						
						<dl class ="info_list"><dt>개봉 : </dt><dd><%=openDay %></dd></dl> 
						<dl class ="info_list"><dt>장르 : </dt><dd><%=genres %></dd></dl>
						<dl class ="info_list"><dt>출연진 : </dt><dd><%=actor %></dd></dl>
					</div>
				</a>
			<span style="position: absolute; bottom: 0; left: 0; width: 200px; text-align: center; font-size: 15px; font-weight: bold; color: white; background-color: rgba(0, 0, 0, 0.5);">오늘 관객수 / <%= audiCnt%>명</span>
			
			</div>
			<div style="text-align : center;">
			<a class="moviename_a" href="board.jsp?name=<%=movieNm%>"><font style="font-weight: bold; "><%=movieNm %></font></a> 
			</div>
		</div>
		</li>
  <%
        }%>
 	</ol>
 	<% 
    }else {
        // HTTP 응답 코드가 200이 아닌 경우에는 에러 처리 등을 수행
    }
%>
			
			
			
			
          </div>
        </div>
        <div class="row"  >
          <div style="text-align: center;">
            <span class="Today">
              Today
            </span>
          </div>
        </div>
        <div class="row" style="height: 500px;">
          <div class="col-6" style="">
            <div class="board1">

            </div>

          </div>          
          <div class="col-6" style="">
            <div class="board1">

            </div>

          </div>          
        </div>  

        <div class="row" style="margin-top: 50px;">
          <div>
            <span class="action">
              액션
            </span>
          </div>

        </div>

        <div class="row" style="">
          <div class="board2">
            
          </div>



        </div>
        
        <div class="row" style="margin-top: 50px;">
          <div>
            <span class="action">
              코미디
            </span>
          </div>
        </div>
        <div class="row" style="">
          <div class="board2">
            
          </div>



        </div>
        <div class="row" style="margin-top: 50px;">
          <div>
            <span class="action">
              로맨스
            </span>
          </div>
        </div>
        <div class="row" style="">
          <div class="board2">
            
          </div>



        </div>

        <div class="row" style="height: 100px;"></div>


        </div>

    </div>


   
</body>

</html>