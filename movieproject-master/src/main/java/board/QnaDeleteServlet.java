package board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class QnaDeleteServlet
 */
@WebServlet("/board/QnaDelete")
public class QnaDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		QnaBoardBean bean = (QnaBoardBean)session.getAttribute("bean");
		QnaMgr mgr = new QnaMgr();
		mgr.deleteQna(bean.getQnaIdx());
		String numPerPage = request.getParameter("numPerPage");
		String nowPage = request.getParameter("nowPage");
		String keyField = request.getParameter("keyField");
		String keyWord = request.getParameter("keyWord");
		String url = "qnaBoardPage.jsp?numPerPage="+numPerPage;
		url+="&nowPage="+nowPage;
		if(!(keyWord==null||keyWord.equals(""))) {
			url+="&keyField="+keyField;
			url+="&keyWord="+keyWord;
		}
		response.sendRedirect(url);
	}

}
