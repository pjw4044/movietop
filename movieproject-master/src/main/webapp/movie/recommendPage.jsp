<%@page import="user.MovieMemberBeans"%>
<%@page import="java.util.ArrayList"%>
<%@page import="movie.MovieBean"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="rMgr" class="movie.RankMgr"/>
<jsp:useBean id="mgr" class="movie.RecommendMgr"/>
<jsp:useBean id="memMgr" class="user.MovieMemberMgr"/>

<%
		HttpSession mysession = request.getSession();
		mysession.setAttribute("userId", "sujeong123");
	 	List<MovieBean> movieList = new ArrayList<MovieBean>();
		String userId = (String)session.getAttribute("userId");
		String userNm = memMgr.getUserNm(userId);
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet"  href="css/recommendPage.css">
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>

</head>
<body>
<div   style="background-color: black; height: 200px;"></div>
<div class = "recommend_div">
	<div class = "recommend_btn"><!-- 버튼 구역 -->
	<div class="day_btn">
  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" onclick="change(1)">
    날짜별
  </button>
  <ul class="dropdown-menu">
    <li><a class="dropdown-item" href="javascript:dayRank(1)">일별</a></li>
    <li><a class="dropdown-item" href="javascript:dayRank(2)">주별</a></li>
    <li><a class="dropdown-item" href="javascript:dayRank(3)">월별</a></li>
  </ul>
</div><!-- 날짜별 종료 -->
	<div class="my_btn">
  <button class="btn " type="button"  aria-expanded="false" onclick="change(2)">
    나를 위한 추천
  </button>

</div><!-- 추천-->
	<div class="gender_btn">
  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" onclick="change(3)">
    성별
  </button>
  <ul class="dropdown-menu">
    <li><a class="dropdown-item" href="javascript:genderRank (1)">남성</a></li>
    <li><a class="dropdown-item" href="javascript:genderRank (2)">여성</a></li>
  </ul>
</div><!-- 성별 -->
	<div class="age_btn">
  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" onclick="change(4)">
    나이별
  </button>
  <ul class="dropdown-menu">
    <li><a class="dropdown-item" href="javascript:ageRank (1)">10대</a></li>
    <li><a class="dropdown-item" href="javascript:ageRank (2)">20대</a></li>
    <li><a class="dropdown-item" href="javascript:ageRank (3)">30대</a></li>
  </ul>
</div><!-- 나이버튼 구역 -->
	</div><!-- 버튼 구역 종료 -->
	<script>
	 const change = (num) => {
	      const tabList = document.querySelectorAll(".tab");
	      tabList.forEach((el) => (el.style.display = "none"));
	      const nowTab = document.querySelector(".tab" + num);
	      nowTab.style.display = "block";
	    };
	const dayRank = (num) => {
		const tabList = document.querySelectorAll(".day");
		tabList.forEach((el) => (el.style.display = "none"));
		const nowTab = document.querySelector(".day" + num);
		nowTab.style.display = "block";
		};
	const genderRank = (num) => {
		const tabList = document.querySelectorAll(".gender");
		tabList.forEach((el) => (el.style.display = "none"));
		const nowTab = document.querySelector(".gender" + num);
		nowTab.style.display = "block";
		};
		const ageRank = (num) => {
			const tabList = document.querySelectorAll(".age");
			tabList.forEach((el) => (el.style.display = "none"));
			const nowTab = document.querySelector(".age" + num);
			nowTab.style.display = "block";
			};
	</script>
	<!-- 추천 구역 -->
	<div class="recommend_movie" >
		<!-- 일간 랭킹 -->
		<div class="tab tab1 days_div" >
			<div class ="day day1 "><h3>일간 랭킹</h3> 
				<div class ="days_movie">
				<ol class="today row">
				<% movieList = mgr.daysRank();
				for(int i =0; i<movieList.size(); i++){
					MovieBean bean = new MovieBean();
					bean = movieList.get(i);
				%>
				<li class="col">
				<div><img src="<%=bean.getPoster()%>" width = "150" height = "250"></div>
				<div><h2><%=bean.getTitle() %></h2></div>
				</li>
				<%} %></ol>
				</div>
			</div>
			<div class ="day day2 month" style="display: none;"><h3>주간 랭킹</h3>
			<div class="week_movie">
			<ol class="week row">
			<% movieList = mgr.weekRank();
				for(int i =0; i<movieList.size(); i++){
					MovieBean bean = new MovieBean();
					bean = movieList.get(i);
				%>
				<li class="col">
				<div><img src="<%=bean.getPoster() %>" width = "150" height = "250"></div>
				<div><h2><%=bean.getTitle() %></h2></div>
				</li>
				<%} %></ol>
			</div>
			</div>
			<div class ="day day3 year" style="display: none;"><h3>월간 랭킹</h3>
				<div class="month_movie">
					<ol class="month_ol row">
					<% movieList = mgr.monthRank();
						for(int i =0; i<movieList.size(); i++){
						MovieBean bean = new MovieBean();
						bean = movieList.get(i);
					%>
						<li class="col">
							<div><img src="<%=bean.getPoster() %>" width = "150" height = "250"></div>
							<div><h2><%=bean.getTitle() %></h2></div>
						</li>
					<%} %></ol>
				</div>
			</div>
		</div>
		<!-- 내게 추천 -->
		<% 
			MovieMemberBeans memberBean = new MovieMemberBeans();
			memberBean = memMgr.getMember(userId);
			
		%>
		<div class = "tab tab2 my_div" style="display: none; ">
			<div class="my_recommend"><h3><%=userNm%>님에게 추천하는 영화</h3></div>
			<div class="myGender_movie">
					<ol class="myGender_ol row">
					<%
						if(memberBean.isGender()){
						movieList = mgr.menRank();
					%>
					<h3>남성 회원님들이 좋아하는 영화</h3>
						<%}else{
						movieList = mgr.womenRank();	
						%>
					<h3>여성 회원님들이 좋아하는 영화</h3>	
						<% }
						for(int i =0; i<movieList.size(); i++){
						MovieBean bean = new MovieBean();
						bean = movieList.get(i);
						%>
						<li class="col">
							<div><img src="<%=bean.getPoster() %>" width = "150" height = "250"></div>
							<div><h2><%=bean.getTitle() %></h2></div>
						</li>
					<%} %></ol>
			</div>	
			<div class="myage_movie">
					<ol class="myage_ol row">
					<%
						if(2004<=memberBean.getBirth()&&memberBean.getBirth()<=2013){
						movieList = mgr.teenRank();
					%>
					<h3>10대 회원님들이 좋아하는 영화</h3>
						<%}else if(1994<=memberBean.getBirth()&&memberBean.getBirth()<=2003){
						movieList = mgr.twentyRank();	
						%>
					<h3>20대 회원님들이 좋아하는 영화</h3>	
						<% }else if(1984<=memberBean.getBirth()&&memberBean.getBirth()<=1993){
							movieList = mgr.thirtyRank();%>
						<h3>30대 회원님들이 좋아하는 영화</h3>
						<%}else 
							movieList = mgr.twentyRank();
						for(int i =0; i<movieList.size(); i++){
						MovieBean bean = new MovieBean();
						bean = movieList.get(i);
						%>
						<li class="col">
							<div><img src="<%=bean.getPoster() %>" width = "150" height = "250"></div>
							<div><h2><%=bean.getTitle() %></h2></div>
						</li>
					<%} %></ol>
			</div>	
		</div>
		<!-- 성별 -->
		<div class = "tab tab3 gender_div" style="display: none ; ">
			<div class = "gender gender1"><h3>남성들이 좋아하는 영화</h3>
				<div class="men_movie">
					<ol class="men_ol row">
					<% 
						movieList = mgr.menRank();
						for(int i =0; i<movieList.size(); i++){
						MovieBean bean = new MovieBean();
						bean = movieList.get(i);
					%>
						<li class="col">
							<div><img src="<%=bean.getPoster() %>" width = "150" height = "250"></div>
							<div><h2><%=bean.getTitle() %></h2></div>
						</li>
					<%} %></ol>
				</div>
			</div>
			<div class = "gender gender2" style="display: none;"><h3>여성들이 좋아하는 영화</h3>
				<div class="women_movie">
					<ol class="women_ol row">
					<% movieList = mgr.womenRank();
						for(int i =0; i<movieList.size(); i++){
						MovieBean bean = new MovieBean();
						bean = movieList.get(i);
					%>
						<li class="col">
							<div><img src="<%=bean.getPoster() %>" width = "150" height = "250"></div>
							<div><h2><%=bean.getTitle() %></h2></div>
						</li>
					<%} %></ol>
				</div>
			</div>
		</div>
		<!-- 나이대별 -->
		<div class = "tab tab4 age_div" style="display: none; ">
			<div class="age age1"><h3>10대</h3>
				<div class="teen_movie">
					<ol class="teen_ol row">
					<% movieList = mgr.teenRank();
						for(int i =0; i<movieList.size(); i++){
						MovieBean bean = new MovieBean();
						bean = movieList.get(i);
					%>
						<li class="col">
							<div><img src="<%=bean.getPoster() %>" width = "150" height = "250"></div>
							<div><h2><%=bean.getTitle() %></h2></div>
						</li>
					<%} %></ol>
				</div>
			</div>
			<div class="age age2" style="display: none;"><h3>20대</h3>
				<div class="twenty_movie">
					<ol class="twenty_ol row">
					<% movieList = mgr.twentyRank();
						for(int i =0; i<movieList.size(); i++){
						MovieBean bean = new MovieBean();
						bean = movieList.get(i);
					%>
						<li class="col">
							<div><img src="<%=bean.getPoster() %>" width = "150" height = "250"></div>
							<div><h2><%=bean.getTitle() %></h2></div>
						</li>
					<%} %></ol>
				</div>	
			</div>
			<div class="age age3" style="display: none;"><h3>30대</h3>
				<div class="thirty_movie">
					<ol class="thirty_ol row">
					<% movieList = mgr.thirtyRank();
						for(int i =0; i<movieList.size(); i++){
						MovieBean bean = new MovieBean();
						bean = movieList.get(i);
					%>
						<li class="col">
							<div><img src="<%=bean.getPoster() %>" width = "150" height = "250"></div>
							<div><h2><%=bean.getTitle() %></h2></div>
						</li>
					<%} %></ol>
				</div>	
			</div>
		</div>
	</div>
	
</div>
</body>

</html>