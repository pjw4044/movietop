<!-- myHeart.jsp -->
<%@page import="movie.RankMgr"%>
<%@page import="user.LikedMovieBean"%>
<%@page import="java.util.List"%>
<%@page import="user.LikedMovieMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>My Heart</title>

        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>mypage</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="/css/mypage.css" />
    
</head>
<%
	HttpSession mySession4 = request.getSession();
	/* String userId4 = (String) session.getAttribute("userId"); */
	String userId4 = "haha11";
	LikedMovieMgr mgr4 = new LikedMovieMgr();
	
	List<LikedMovieBean> myLikedList = mgr4.getMyLikedList(userId4);
	
%>

<body>

<div align="center">

<h1>♡</h1>
<%-- <div class="container">
<div class="row row-cols-2 row-cols-md-6 g-4">

    <!-- JSP 페이지에서 반복문을 사용하여 카드를 생성합니다. -->
    <div class="row">
    <%
    for (LikedMovieBean liked : myLikedList) {
		RankMgr rmgr = new RankMgr();
    	String title = liked.getTitle();
    	String poster = rmgr.getImg(title);
    %>

    <div class="col-6">
    <div class="card h-100">
      <img src="<%= poster %>" class="card-img-top" alt="Movie Poster" style="width: 100px; height: 100px">
      <div class="card-body">
        <h5 class="card-title"><%= title %></h5>
      </div>
    </div>
  </div>
  <% } %>

  </div>
</div> --%>
<div class="container" style="margin-top: 50px;" >
  <div class="row row-cols-2 row-cols-md-6 g-4 justify-content-center">
    <% for (LikedMovieBean liked : myLikedList) {
		RankMgr rmgr = new RankMgr();
    	String title = liked.getTitle();
    	String poster = liked.getPoster();
    %>
    
    <div class="col-mb-3">
    <a href="board.jsp?title=<%=title%>">
      <div class="card h-100">
        <img src="<%=poster%>" class="card-img-top" alt="Movie Poster" >
        <div class="card-body">
          <p class="card-title"><%= title %></p>
        </div></a>
      </div>
      
    </div>
    <% } %>
  </div>
</div>

</div>


</body>
</html>