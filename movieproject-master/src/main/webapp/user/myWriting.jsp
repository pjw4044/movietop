<!-- myWriting.jsp -->
<%@page import="user.MovieMemberMgr"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardMgr"%>
<%@page import="board.BoardBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>My Writing</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<jsp:useBean id="mgr2" class="board.BoardMgr"></jsp:useBean>

<h1>내 작성글</h1>
</head>
<%
	HttpSession mySession = request.getSession();
	/* String userId = (String) session.getAttribute("userId"); */
	String userId3 = "sujeong123";
	/* String userNm = (String) session.getAttribute("userNm");  */
	MovieMemberMgr mgr1 = new MovieMemberMgr();
	/* String userid = mgr1.getUserId(userNm); */
	List<BoardBean> myBoardList = mgr2.getMyboardList(userId3);
	
	
	
%>
<script >
function deleteMyBoard() {
	 var checkboxes = document.getElementsByName("boardcheck");
	  var message_idx = [];
	  for (var i = checkboxes.length-1; i >=0 ; i--) {
		    if (checkboxes[i].checked) {
		        var message_id = checkboxes[i].value;
		        message_idx.push(message_id);
		        
		      }
	  }
	  $.ajax({
		    url: "/myapp/movieProject/myboardDeleteServlet",
		    type: "POST",
		    data: JSON.stringify({message_idx: message_idx}),
		    contentType: "application/json",
		    success: function(data) {
		    	location.reload();
		    	
		    },
		    error: function() {
		      // 요청이 실패했을 때 실행할 코드
		    }
		  });
}
</script>
<body>

<table class="table table-hover" >
  <thead>
    <tr>
    <th scope="col">삭제</th>
     <th scope="col">카테고리</th>
      <th scope="col">제목</th>
      <th scope="col">날짜</th>
   
    </tr>
  </thead>
  <tbody>
  	  <% 
            for(BoardBean board2 : myBoardList) {
            	String cate = board2.getCategory();
                String title = board2.getTitle();
                java.util.Date date = board2.getPostedDate();
       %>
    <tr>
             <td><input type="checkbox" name="boardcheck" value="<%=board2.getBoardIdx()%>"></td>
            <td><%=board2.getCategory()%></td>
            <td><%=board2.getTitle()%></td>
            <td><%=board2.getPostedDate()%></td>
            
    </tr>
    <% } %>
  </tbody>
</table>
<button type="button" onclick="deleteMyBoard()">삭제</button>


</body>
</html>