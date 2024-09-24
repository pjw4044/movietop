package movie;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.MovieMemberBeans;
import user.MovieMemberMgr;

/**
 * Servlet implementation class MovieLikedServlet
 */
@WebServlet("/MovieLikedServlet")
public class MovieLikedServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    MovieLikedMgr movieLikedMgr = new MovieLikedMgr();
	    MovieMemberMgr memberMgr = new MovieMemberMgr();
	    MovieMemberBeans bean = new MovieMemberBeans();
	    
	    int movieidx = Integer.parseInt(request.getParameter("movieidx"));
	    String flagParam = request.getParameter("flag");
	    boolean flag = (flagParam != null && flagParam.equals("true"));
	    String userid = request.getParameter("userid");

	    bean = memberMgr.getMember(userid);
	    int birth = bean.getBirth();
	    boolean gender = bean.isGender();
	    
	    try {
	    // moviegrademgr.java 호출
	    	if(flag == false) {
	    		movieLikedMgr.insertLiked(movieidx, birth, gender, userid);
	    	} else {
	    		movieLikedMgr.deleteLiked(movieidx);
	    		System.out.println("삭제 완료");
	    	}
	      
	      String result = "{\"success\": true}"; // 결과를 JSON 형태로 반환
	      response.getWriter().write(result);
	    } catch (Exception e) {
	      e.printStackTrace();
	      String result = "{\"success\": false}";
	      response.getWriter().write(result);
	    }
	  }

}
