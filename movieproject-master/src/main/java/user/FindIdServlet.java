package user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class findIdServlet
 */
@WebServlet("/findIdServlet" )
public class FindIdServlet extends HttpServlet {
	public static final String SAVEFOLDER = "C:/Jsp/movieProject/src/main/webapp/moviepage/";
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1024*1024*20;//20MB

	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MultipartRequest multi = 
				new MultipartRequest(request, SAVEFOLDER, MAXSIZE, 
						ENCODING, new DefaultFileRenamePolicy());
		String userNm = multi.getParameter("sendNm");
		String birth = multi.getParameter("sendBirth");
		System.out.println("userNm:"+userNm);
		System.out.println("birth:"+birth);
		MovieMemberMgr memMgr = new MovieMemberMgr();
		String userId = memMgr.findId(userNm, birth);
		System.out.println("id:"+userId);
		request.setAttribute("id", userId);
		RequestDispatcher rd = request.getRequestDispatcher("/moviepage/findId.jsp");
		rd.forward(request, response);
	}

}
