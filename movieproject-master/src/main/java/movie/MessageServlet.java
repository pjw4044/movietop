package movie;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import user.MovieMemberMgr;


@WebServlet("/movieProject/messageServlet")
public class MessageServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession mySession = request.getSession();
		MessageMgr mgr = new MessageMgr();
		MovieMemberMgr memMgr = new MovieMemberMgr();
		boolean complete = false;
		String userId = (String)mySession.getAttribute("userId");
		complete = mgr.insertMessage(request, userId);
		// 보내는 사람의 닉네임이 올바르지 않는경우 complete = false;
		if(complete) {
		response.sendRedirect("/movieProject/movie/checkMessage.jsp");
		}else {
			System.out.println("닉네임이 올바르지 않습니다 . 에러 페이지로..");
		}
	}
}
