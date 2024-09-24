package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/idCheck")
public class IdCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String userid = request.getParameter("userid");
		PrintWriter out = response.getWriter();
		
		MovieMemberMgr mgr = new MovieMemberMgr();
		int idCheck = mgr.checkId(userid);
		
		//확인 
//		if(idCheck==0) {
//			System.out.println("이미 존재하는 아이디입니다");
//		}else if(idCheck==1) {
//			System.out.println("사용 가능한 아이디입니다.");
//		}else {
//			System.out.println("");
//		}
		out.write(idCheck+"");
	}

}
