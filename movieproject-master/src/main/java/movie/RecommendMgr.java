package movie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import universal.DBConnectionMgr;

public class RecommendMgr {
	private DBConnectionMgr pool;
	RankMgr mgr = new RankMgr();
	
	public RecommendMgr() {
		pool = DBConnectionMgr.getInstance();		
	}
	//주별 랭킹 영화
	public List<MovieBean> weekRank() {
		List<MovieBean> vlist = new ArrayList<MovieBean>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int idx=0;
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "select movieidx, count(movieidx) as cnt "
					+ "from likedmovie where likedtime >= DATE_SUB(NOW(), INTERVAL 1 WEEK)"
					+ " group by movieidx order by cnt desc LIMIT 3";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
			
				idx = rs.getInt("movieidx");
				MovieBean bean = mgr.getRecommend(idx);
				vlist.add(bean);
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//일별 랭킹 영화
	public List<MovieBean> daysRank() {
		List<MovieBean> vlist = new ArrayList<MovieBean>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int idx=0;
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "select movieidx, count(movieidx) as cnt "
					+ "from likedmovie where likedtime = CURDATE()"
					+ " group by movieidx order by cnt desc LIMIT 3";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
			
				idx = rs.getInt("movieidx");
				MovieBean bean = mgr.getRecommend(idx);
				vlist.add(bean);
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//월별
	public List<MovieBean> monthRank() {
		List<MovieBean> vlist = new ArrayList<MovieBean>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int idx=0;
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "select movieidx, count(movieidx) as cnt "
					+ "from likedmovie where likedtime >= DATE_SUB(NOW(), INTERVAL 1 MONTH)"
					+ " group by movieidx order by cnt desc LIMIT 3";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
			
				idx = rs.getInt("movieidx");
				MovieBean bean = mgr.getRecommend(idx);
				vlist.add(bean);
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//남성 영화
		public List<MovieBean> menRank() {
			List<MovieBean> vlist = new ArrayList<MovieBean>();
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int idx=0;
			String sql = null;
			
			try {
				con = pool.getConnection();
				sql = "select movieidx, count(movieidx) as cnt "
						+ "from likedmovie where gender = 1"
						+ " group by movieidx order by cnt desc LIMIT 3";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()) {
				
					idx = rs.getInt("movieidx");
					MovieBean bean = mgr.getRecommend(idx);
					vlist.add(bean);
					
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		//여성 영화
				public List<MovieBean> womenRank() {
					List<MovieBean> vlist = new ArrayList<MovieBean>();
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					int idx=0;
					String sql = null;
					
					try {
						con = pool.getConnection();
						sql = "select movieidx, count(movieidx) as cnt "
								+ "from likedmovie where gender = 0"
								+ " group by movieidx order by cnt desc LIMIT 3";
						pstmt = con.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while(rs.next()) {
						
							idx = rs.getInt("movieidx");
							MovieBean bean = mgr.getRecommend(idx);
							vlist.add(bean);
							
						}

					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt, rs);
					}
					return vlist;
				}
				//10대 영화
				public List<MovieBean> teenRank() {
					List<MovieBean> vlist = new ArrayList<MovieBean>();
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					int idx=0;
					String sql = null;
					
					try {
						con = pool.getConnection();
						sql = "select movieidx, count(movieidx) as cnt "
								+ "from likedmovie where  FLOOR(YEAR(NOW()) - birth) BETWEEN 10 AND 19"
								+ " group by movieidx order by cnt desc LIMIT 3";
						pstmt = con.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while(rs.next()) {
						
							idx = rs.getInt("movieidx");
							MovieBean bean = mgr.getRecommend(idx);
							vlist.add(bean);
							
						}

					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt, rs);
					}
					return vlist;
				}
				//20대 영화
				public List<MovieBean> twentyRank() {
					List<MovieBean> vlist = new ArrayList<MovieBean>();
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					int idx=0;
					String sql = null;
					
					try {
						con = pool.getConnection();
						sql = "select movieidx, count(movieidx) as cnt "
								+ "from likedmovie where  FLOOR(YEAR(NOW()) - birth) BETWEEN 20 AND 29"
								+ " group by movieidx order by cnt desc LIMIT 3";
						pstmt = con.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while(rs.next()) {
						
							idx = rs.getInt("movieidx");
							MovieBean bean = mgr.getRecommend(idx);
							vlist.add(bean);
							
						}

					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt, rs);
					}
					return vlist;
				}
				//30대 영화
				public List<MovieBean> thirtyRank() {
					List<MovieBean> vlist = new ArrayList<MovieBean>();
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					int idx=0;
					String sql = null;
					
					try {
						con = pool.getConnection();
						sql = "select movieidx, count(movieidx) as cnt "
								+ "from likedmovie where FLOOR(YEAR(NOW()) - birth) BETWEEN 30 AND 39"
								+ " group by movieidx order by cnt desc LIMIT 3";
						pstmt = con.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while(rs.next()) {
						
							idx = rs.getInt("movieidx");
							MovieBean bean = mgr.getRecommend(idx);
							vlist.add(bean);
							
						}

					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt, rs);
					}
					return vlist;
				}
}
