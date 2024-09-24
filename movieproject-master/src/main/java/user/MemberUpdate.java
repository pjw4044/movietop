package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/memberUpdate")
public class MemberUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		MovieMemberBeans bean = new MovieMemberBeans();
		MovieMemberMgr mgr = new MovieMemberMgr();
		HttpSession mysession = request.getSession();
		String userId2 = (String) mysession.getAttribute("userId");
		/* String myId = mgr.getUserId((String)mysession.getAttribute("userNm")); */
		String usernn = request.getParameter("usernn");
		String userpwd = request.getParameter("userpwd");
		
		bean.setUsernn(request.getParameter("usernn"));
		bean.setUserpwd(request.getParameter("userpwd"));
		bean.setUserid(userId2);
		mgr.updateMember(bean);
		/* String userNm = mgr.updateMember(bean); */
		/* mysession.setAttribute("userNm", userNm); */
		response.sendRedirect("myPage.jsp");
	}

}
