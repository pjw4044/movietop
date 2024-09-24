package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import universal.DBConnectionMgr;

public class LikedMovieMgr {
	private DBConnectionMgr pool;
	
	public LikedMovieMgr(){
		pool  = DBConnectionMgr.getInstance();
	} 
	// 내가 좋아요 한 영화 목록
	public List<LikedMovieBean> getMyLikedList(String userid){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<LikedMovieBean> myLikedList = new ArrayList<>();
		try {
			con = pool.getConnection();
			sql = "SELECT movie.TITLE , movie.POSTER\r\n"
					+ "FROM likedmovie\r\n"
					+ "JOIN movie ON likedmovie.MOVIEIDX = movie.MOVIEIDX\r\n"
					+ "WHERE likedmovie.userid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				LikedMovieBean myLiked = new LikedMovieBean();
				myLiked.setPoster(rs.getString("poster"));
				myLiked.setTitle(rs.getString("title"));
				myLikedList.add(myLiked);
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return myLikedList;
	}

}
