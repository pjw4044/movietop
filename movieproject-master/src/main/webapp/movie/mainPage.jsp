<%@page import="user.MovieMemberMgr"%>
<%@page import="java.util.ArrayList"%>
<%@page import="movie.MovieBean"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="movie.RankMgr"%>
<%@page contentType="text/html;charset=UTF-8"%>
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
	RankMgr rmgr = new RankMgr();
	Calendar cal = Calendar.getInstance();
	 String poster[]=new String[5];
	 List<MovieBean> vlist;
	
	cal.add(Calendar.DATE, -1); // 오늘 날짜에서 -1을 뺀다.
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd"); // 날짜 포맷을 지정한다.
	String day = dateFormat.format(cal.getTime()); // 포맷에 맞게 문자열로 변환한다.
    
	String url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt="+day; // HTTP 요청할 URL
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet"  href="css/mainPage.css">
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>

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
<div class="container">
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
        <!-- 로고 및 사용자 닉네임 표출 -->
       
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
            </div> </form>
            <div class="col-2" style=" padding: 0px;">
            <%if(userId == null){ %>
              <button type="button" class="btn" onclick="javascript:location.href='login.jsp'" >로그인</button>
              <button type="button" class="btn" onclick="javascript:location.href='memberJoin.jsp'">회원가입</button>
           <%}else {%>
              <button type="button" class="btn" onclick="javascript:location.href='myPage1.jsp'" ><%=userNm %></button>
              <button type="button" class="btn" onclick="javascript:location.href='/movieProject/logoutServlet'">로그아웃</button>
           <%} %> 
            </div>
        <!-- 상단 네비게이션 바 -->
        
    <div class="row"> 
          <nav>
            <ul class="nav_ul">
              <a class="a_text" href="mainPage.jsp"><li class="nav_li">홈</li></a>
              <a class="a_text" href="rankingPage.jsp"><li class="nav_li">랭킹</li></a>
              <a class="a_text" href="mainPage.jsp"><li class="nav_li">영화</li></a>
              <a class="a_text" href="recommendPage.jsp"><li class="nav_li">추천</li></a>
              <a class="a_text" href="mainPage.jsp"><li class="nav_li">게시판</li></a>
              <a class="a_text" href="mainPage.jsp"><li class="nav_li">문의</li></a>
            </ul>
          </nav>
        </div>
        
   <!-- 랭킹 상영중인 영화  -->
  <div class ="rank"   >
  	<div style="margin-top: 30px;"><h2 class="rank_text">현재 상영중인 영화 순위</h2></div>
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
				<a href="board.jsp?name=<%=movieNm%>">
				<img alt="No-Image" width = "200" height = "300" src="<%=poster[i]%>" 
				 onmouseover = "javascript:showInfo('<%=movieNm %>',<%=i %>)"  onmouseout = "javascript:hideInfo('<%=i%>')">					
					<div class= "divinfo" id="imageEvent<%=i%>"  style="display : none; position: absolute; top: 0; left: 0; width: 100%; " >
						
						<dl class ="info_list"><dt>개봉 : </dt><dd><%=openDay %></dd></dl> 
						<dl class ="info_list"><dt>장르 : </dt><dd><%=genres %></dd></dl>
						<dl class ="info_list"><dt>출연진 : </dt><dd><%=actor %></dd></dl>
					</div>
				</a>
			<span style="position: absolute; bottom: 0; left: 0; width: 100%; text-align: center; font-size: 15px; font-weight: bold; color: white; background-color: rgba(0, 0, 0, 0.5);">오늘 관객수 / <%= audiCnt%>명</span>
			
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
   <!--핫 게시글 및 영화  -->
<div class ="today_rank" style=" height: 300px;">
<h2 style="text-align: center; margin-top: 10px;">오늘의 순위</h2>
<div class="ranking" style="display: flex; height: 250px; justify-content: center;">
	<div class="hot_board border" >
		<h4 class="ranking_text">게시판 top 5</h4>
		<div>
			<ol>
				<!-- @@@@@@@텍스트와 넘겨주는 매개변수 바꿔야함 -->
				<% for(int i=0; i <5; i++){%>
				<a href="board.jsp?title=<%=i%>순위 게시글">
				<li class="hot_rankTxt"><%=i %>순위 게시글</li>			
				</a><%}%>
			</ol>
		</div>
	</div>
	<div class="hot_movie border">
		<h4 class="ranking_text">사이트 영화 top 5</h4>
		<div>
		<% 
			vlist = rmgr.siteMovieRank() ;
		%>
			<ol>
			<% for(int i=0; i <5; i++){
			MovieBean bean = new MovieBean();
			bean = vlist.get(i);
			%>
				<a  href="detailMovie.jsp?movieName=<%=bean.getTitle()%>" >
				<li class="hot_rankTxt"><%=bean.getTitle()%></li></a>
			<%}%>
			</ol>
		</div>
	</div>
</div>
</div>

<script >
$(document).ready(function() {
	  $('.actionOl').slick({
	    slidesToShow: 5,
	    slidesToScroll: 1,
	    prevArrow: $('.prev'),
	    nextArrow: $('.next')
	  });
	  $('.prev').click(function(){
	      $('.actionOl').slick('slickPrev');
	    });
	  $('.next').click(function(){
	      $('.actionOl').slick('slickNext');
	    });
	});
</script>

<!-- 장르별 영화 -->

<div class="movie" style="margin-top: 15px;">
<!-- 액션 영화 출력 -->
<div class ="movie_part">
<div class="movie_text text-bg-success p-2">
<p id="action-text" class="text_p">
	액션
</p>
<a href="moviePage.jsp?genre=액션"><p class="more_text">더보기...</p></a>
</div>
<div class="movie_part" overflow: hidden;>
	<div class="genre_movie">
		<ol class="actionOl" style="display: flex;">
		<%
		List<String> actPoster = new ArrayList<String>();
		List<String> actTitle = new ArrayList<String>();
			vlist =rmgr.getMovie("액션");
			for(int i=0; i<vlist.size(); i++){ 
		MovieBean actBean = vlist.get(i);
		actPoster.add(actBean.getPoster());
		actTitle.add(actBean.getTitle());
		%>
	<a href="board.jsp?title=<%=actTitle.get(i)%>">
		<li class="list_li">
		<div class="movielist_div " style="position: relative; display: flex; flex-direction: column;">
			<img alt="No-Image" width = "160" height = "200" src="<%=actPoster.get(i)%>" >	
			<span class="movie_name" ><%=actTitle.get(i) %></span>
		</div>
		</li>	</a>
		<%} %>
		</ol>
		</div>
		<button class="prev">Prev</button>
		<button class="next">Next</button> 
	</div>
	</div>
	<script >
$(document).ready(function() {
	  $('.secondOl').slick({
	    slidesToShow: 5,
	    slidesToScroll: 1,
	    prevArrow: $('.prevSecondBtn'),
	    nextArrow: $('.nextSecondBtn')
	  });
	  $('.prevSecondBtn').click(function(){
	      $('.secondOl').slick('slickPrev');
	    });
	  $('.nextSecondBtn').click(function(){
	      $('.secondOl').slick('slickNext');
	    });
	});
</script>
<!-- 코미디 영화 출력 -->
<div class ="movie_part">
<div class="movie_text text-bg-success p-2">
<p id="second-text" class="text_p">
	코미디
</p>
<!-- @@@영화 코미디 장르 리스트 사이트로 이동 -->
<a href="moviePage.jsp?genre=코미디"><p class="more_text">더보기...</p></a>
</div>
<div class="movie_part">
	<div class="com_movie">
		<ol class="secondOl"style="display: flex;">
		<%
		List<String> comPoster = new ArrayList<String>();
		List<String> comTitle = new ArrayList<String>();
			vlist =rmgr.getMovie("코미디");
			for(int i=0; i<vlist.size(); i++){ 
		MovieBean actBean = vlist.get(i);
		comPoster.add(actBean.getPoster());
		comTitle.add(actBean.getTitle());
		%>
		<a href="board.jsp?title=<%=comTitle.get(i)%>">
		<li class="list_li">
			<div class="movielist_div" style=" position: relative; display: flex; flex-direction: column;">
				<img alt="No-Image" width = "160" height = "200" src="<%=comPoster.get(i)%>" >	
				<span id="movie_name" ><%=comTitle.get(i) %></span>
			</div>
		</li></a>	
		<%} %>
		</ol>
		</div>
		<button class="prevSecondBtn">Prev</button>
		<button class="nextSecondBtn">Next</button> 
	</div>
	</div>
 	<script >
$(document).ready(function() {
	  $('.thirdOl').slick({
	    slidesToShow: 5,
	    slidesToScroll: 1,
	    prevArrow: $('.prevThirdBtn'),
	    nextArrow: $('.nextThirdBtn')
	  });
	  $('.prevThirdBtn').click(function(){
	      $('.thirdOl').slick('slickPrev');
	    });
	  $('.nextThirdBtn').click(function(){
	      $('.thirdOl').slick('slickNext');
	    });
	});
</script>
<!-- 로맨스 영화 출력 -->
<div class ="movie_part">
<div class="movie_text text-bg-success p-2">
<p id="third-text " class="text_p">
	로맨스
</p>
<!-- @@@영화 로맨스 장르 리스트 사이트로 이동 -->
<a href="moviePage.jsp?genre=로맨스"><p class="more_text">더보기...</p></a>
</div>
<div class="movie_part">
	<div class="com_movie">
		<ol class="thirdOl"style="display: flex;">
		<%
		List<String> romancePoster = new ArrayList<String>();
		List<String> romanceTitle = new ArrayList<String>();
			vlist =rmgr.getMovie("로맨스");
			for(int i=0; i<vlist.size(); i++){ 
		MovieBean actBean = vlist.get(i);
		romancePoster.add(actBean.getPoster());
		romanceTitle.add(actBean.getTitle());
		%>
		<a href="board.jsp?title=<%=romanceTitle.get(i)%>">
		<li class="list_li">
			<div class="movielist_div" style=" position: relative; display: flex; flex-direction: column;">
				<img alt="No-Image" width = "160" height = "200" src="<%=romancePoster.get(i)%>" >	
				<span id="movie_name" ><%=romanceTitle.get(i) %></span>
			</div>
		</li>	</a>
		<%} %>
		</ol>
		</div>
		<button class="prevThirdBtn">Prev</button>
		<button class="nextThirdBtn">Next</button> 
	</div>
</div>
</div>
</div>

</body>
</html>