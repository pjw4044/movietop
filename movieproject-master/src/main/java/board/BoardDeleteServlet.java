package board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


@WebServlet("/board/boardDelete")
public class BoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		BoardBean bean = (BoardBean)session.getAttribute("bean");
		BoardMgr mgr = new BoardMgr();
		mgr.deleteBoard(bean.getBoardIdx());
		String numPerPage = request.getParameter("numPerPage");
		String nowPage = request.getParameter("nowPage");
		String keyField = request.getParameter("keyField");
		String keyWord = request.getParameter("keyWord");
		String url = "boardPage.jsp?numPerPage="+numPerPage;
		url+="&nowPage="+nowPage;
		if(!(keyWord==null||keyWord.equals(""))) {
			url+="&keyField="+keyField;
			url+="&keyWord="+keyWord;
		}
		response.sendRedirect(url);
	}
	
	
	
	
	
}








