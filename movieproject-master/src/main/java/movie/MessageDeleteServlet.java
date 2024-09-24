package movie;

import java.io.BufferedReader;
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.google.gson.reflect.TypeToken;
import com.google.gson.Gson;


@WebServlet("/movieProject/messageDeleteServlet")
public class MessageDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userNm = (String)session.getAttribute("userNm");
		MessageMgr mgr = new MessageMgr();
		
		 StringBuilder sb = new StringBuilder();
		  BufferedReader br = request.getReader();
		  String line;
		  while ((line = br.readLine()) != null) {
		    sb.append(line);
		  }
		  br.close();
		  String requestBody = sb.toString();	
		  //System.out.println(requestBody);
		  Type type = new TypeToken<Map<String, List<String>>>(){}.getType();
		  Map<String, List<String>> data = new Gson().fromJson(requestBody, type);
		  List<String> messageIdxList = data.get("message_idx");
		  for(int i=messageIdxList.size()-1; i>=0;i--) {
			//  System.out.println("i:"+messageIdxList.get(i));
			  mgr.deleteMessage(userNm,  Integer.parseInt(messageIdxList.get(i)));
		  }
	}
}
