package user;

import java.io.IOException;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/memberJoin") 
public class MemberJoin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String userId = request.getParameter("userid");
		String userNn = request.getParameter("usernn");
		String userPwd = request.getParameter("userpwd");
		String userPwd2 = request.getParameter("userpwd");
		String birth = request.getParameter("birth");
		String gender1 = request.getParameter("gender");
		
		MovieMemberBeans bean = new MovieMemberBeans();
		MovieMemberMgr mgr = new MovieMemberMgr();
		
		
		boolean gender = true;
		if(Integer.parseInt(request.getParameter("gender"))==1) {
			gender=true;
		}else {
			gender=false;
		}
	
		// 빈칸이 하나라도 비어있으면 회원가입 안됨.
		if(userId.isEmpty()||userNn.isEmpty()||userPwd.isEmpty()||userPwd2.isEmpty()
				||birth.isEmpty()||gender1.isEmpty()) {
			String message = "Please fill in all the required fields.";
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script type='text/javascript'>");
            out.println("alert('" + message + "');");
            out.println("location='movieMember.jsp';");
            out.println("</script>");
		} else if(mgr.checkId(userId)==0 | mgr.checkNname(userNn)==0){
			String message = "사용 가능한 아이디와 닉네임을 입력해주세요.";
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script type='text/javascript'>");
            out.println("alert('" + message + "');");
            out.println("history.go(-1);"); // 이전 페이지로 이동
            out.println("</script>");
            
            }else {
			bean.setUserid(request.getParameter("userid"));
			bean.setUsernn(request.getParameter("usernn"));
			bean.setUserpwd(request.getParameter("userpwd"));
			bean.setBirth(Integer.parseInt(request.getParameter("birth")));
			bean.setGender(gender);
			mgr.joinMember(bean);
			response.sendRedirect("/movieProject/user/login.jsp");
		}
	
	
	}

}
