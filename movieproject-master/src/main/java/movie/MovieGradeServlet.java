package movie;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MovieGradeServlet")
public class MovieGradeServlet extends HttpServlet {
	  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    MovieGradeMgr movieGradeMgr = new MovieGradeMgr();
	    
	    int movieidx = Integer.parseInt(request.getParameter("movieidx"));
	    String btncheckParam = request.getParameter("btncheck");
	    boolean btncheck = (btncheckParam != null && btncheckParam.equals("true"));
	    String flagParam = request.getParameter("flag");
	    boolean flag = (flagParam != null && flagParam.equals("true"));


	    try {
	    // moviegrademgr.java 호출
	      movieGradeMgr.updateGrade(movieidx, btncheck, flag);
	      String result = "{\"success\": true}"; // 결과를 JSON 형태로 반환
	      response.getWriter().write(result);
	    } catch (Exception e) {
	      e.printStackTrace();
	      String result = "{\"success\": false}";
	      response.getWriter().write(result);
	    }
	  }
	}
