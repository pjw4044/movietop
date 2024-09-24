package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/nnCheck")
public class NnCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String usernn = request.getParameter("usernn");
		PrintWriter out = response.getWriter();
		HttpSession mysession = request.getSession();
		String userid = (String) mysession.getAttribute("userid");
		MovieMemberMgr mgr = new MovieMemberMgr();
		
		MovieMemberBeans info = mgr.getMember(userid);
		String myNm = info.getUsernn();
		
		int nnCheck = mgr.checkNname(usernn);
		int existNn =0;
		if (usernn.equals(myNm)) {
			existNn=1;
		}
		
		
		//확인
		if(nnCheck==0) {
			if(existNn==0) {
			System.out.println("이미 존재하는 닉네임입니다");}
			else if(existNn==1) {
				System.out.println("기존의 닉네임과 같습니다.");
				nnCheck=3;	
			}
		}else if(nnCheck==1) {
			System.out.println("사용 가능한 닉네임입니다.");
		}else{
		}
		out.write(nnCheck+"");
	}

}
