package movie;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

import universal.DBConnectionMgr;

public class MovieLikedMgr {

	private DBConnectionMgr pool;
	
	public MovieLikedMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public void insertLiked(int movieidx, int birth, boolean gender, String userid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "INSERT INTO likedmovie\r\n"
					+ "(MOVIEIDX, LIKEDTIME, USERID, gender, birth)\r\n"
					+ "VALUES(?, now(), ?, ?, ?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movieidx);
			pstmt.setString(2, userid);
			pstmt.setBoolean(3, gender);
			pstmt.setInt(4, birth);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	public void deleteLiked(int movieidx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM likedmovie\r\n"
					+ "WHERE movieidx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movieidx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}
