package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import universal.DBConnectionMgr;

public class MovieMemberMgr {
	
	private DBConnectionMgr pool;
	
	public MovieMemberMgr() {
		pool  = DBConnectionMgr.getInstance();
	} 
	
	// 로그인 : 성공 -> true
	public boolean loginMember(String userid, String userpwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag =false;
		try {
			con = pool.getConnection();
			sql = "select * from user where userid=? and userpwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, userpwd);
			rs = pstmt.executeQuery();
			flag = rs.next();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	// 회원가입 
	public void joinMember(MovieMemberBeans bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "insert user(userid,usernn,userpwd,birth,gender) values(?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUserid());
			pstmt.setString(2, bean.getUsernn());
			pstmt.setString(3, bean.getUserpwd());
			pstmt.setInt(4, bean.getBirth());
			pstmt.setBoolean(5, bean.isGender());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return ;
	}
	// 아이디 중복확인
	public int checkId (String userid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int idCheck = 0;
		try {
			con = pool.getConnection();
			sql = "select userid from user where userid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				idCheck = 0; // 이미 존재 , 생성 불가능
			}else if(userid.equals("")){
				idCheck = 2; // 공백일때,
			}else {
				idCheck = 1; // 존재하지 않는 경우, 생성 가능
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return idCheck;
	}
	// 닉네임 중복확인
	public int checkNname (String usernn) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int nnCheck = 0;
		try {
			con = pool.getConnection();
			sql = "select userid from user where usernn=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usernn);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				nnCheck = 0; // 이미 존재 , 생성 불가능
			}else if(usernn.equals("")){
				nnCheck = 2; // 공백일때,
			}else {
				nnCheck = 1; // 존재하지 않는 경우, 생성 가능
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return nnCheck;
	}
	// 회원정보 가져오기
	public MovieMemberBeans getMember(String userid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MovieMemberBeans bean = new MovieMemberBeans();
		try {
			con = pool.getConnection();
			sql = "select * from user where userid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setUserid(rs.getString("userid"));
				bean.setUsernn(rs.getString("usernn"));
				bean.setUserpwd(rs.getString("userpwd"));
				bean.setBirth(rs.getInt("birth"));
				bean.setGender(rs.getBoolean("gender"));
				bean.setAdmin(rs.getBoolean("admin"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	// 닉네임으로 아이디 가져오기 
	public String getUserId(String userNm) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String userId ="";
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select * from user where usernn = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userNm);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				userId = rs.getString("userid");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return userId;
	}
	
	// 아이디로 닉네임 가져오기
	public String getUserNm(String userId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String userNm ="";
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select * from user where userid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				userNm = rs.getString("usernn");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return userNm;
	}
	
	// 회원정보수정 - id를 제외한 모든 값을 수정
	public String updateMember(MovieMemberBeans bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String userNm = "";
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update user set usernn=?, userpwd=? where userid=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, bean.getUsernn());
			userNm = bean.getUsernn();
			pstmt.setString(2, bean.getUserpwd());
			pstmt.setString(3, bean.getUserid());
			if(pstmt.executeUpdate()==1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return userNm;
	}

	// 회원탈퇴 
	public void memberOut(String userId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM user WHERE userid=? ;";
			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	public String findId(String userNm, String birth) {
		String id ="";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select userid from user where usernn =? and birth = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userNm);
			pstmt.setString(2, birth);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString("userid");
			}else {
				id = "no";
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return id;
	}
	public String findPw(String userId, String birth) {
		String pw ="";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select userpwd from user where userid =? and birth = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, birth);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pw = rs.getString("userpwd");
			}else {
				pw = "no";
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return pw;
	}
	
	
}
