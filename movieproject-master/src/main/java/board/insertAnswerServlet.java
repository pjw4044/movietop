package board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class insertAnswerServlet
 */
@WebServlet("/board/insertAnswer")
public class insertAnswerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		QnaMgr bMgr=new QnaMgr();
		bMgr.insertAnswer(request);
		response.sendRedirect("qnaBoardPage.jsp");
	}

}
