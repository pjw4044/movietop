package board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/board/agoraDelete")
public class AgoraDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		AgoraBean bean = (AgoraBean)session.getAttribute("bean");
		AgoraMgr mgr = new AgoraMgr();
		mgr.deleteAgora(bean.getAgoraIdx());
		String numPerPage = request.getParameter("numPerPage");
		String nowPage = request.getParameter("nowPage");
		String keyField = request.getParameter("keyField");
		String keyWord = request.getParameter("keyWord");
		String url = "agoraBoardPage.jsp?numPerPage="+numPerPage;
		url+="&nowPage="+nowPage;
		if(!(keyWord==null||keyWord.equals(""))) {
			url+="&keyField="+keyField;
			url+="&keyWord="+keyWord;
		}
		response.sendRedirect(url);
	}

}
