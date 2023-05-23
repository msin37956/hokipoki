package admin.svc;

import java.sql.Connection;
import java.util.ArrayList;

import dao.GonguDAO;
import dao.OrderDAO;
import vo.Gongu;

import static db.JdbcUtil.*;

public class AdminGonguSetStatusService {

	public boolean setNextStatus(int gongu_id, String nextStatus) {
		boolean nextResult = false;

		Connection con = null;

		try {
			con = getConnection();
			GonguDAO gonguDAO = GonguDAO.getInstance();
			gonguDAO.setConnection(con);

			int updateCount = gonguDAO.updateGonguStatus(gongu_id, nextStatus);

			if (updateCount > 0) {
				nextResult = true;
				commit(con);

			} else {
				rollback(con);
			}

		} catch (Exception e) {
			System.out.println("공구상태변경오류:" + e);
			rollback(con);

		} finally {
			close(con);
		}

		return nextResult;
	}

	public ArrayList<Gongu> startGonguAll() {
		ArrayList<Gongu> startList = null;

		Connection con = null;

		try {
			con = getConnection();
			// System.out.println(con);
			GonguDAO gonguDAO = GonguDAO.getInstance();
			gonguDAO.setConnection(con);

			startList = gonguDAO.startGongu();

			if (startList.size() > 0) {
				commit(con);

			} else {
				rollback(con);
			}

		} catch (Exception e) {
			System.out.println("공구진행시작오류:" + e);
			e.printStackTrace();
			rollback(con);

		} finally {
			close(con);
		}

		return startList;
	}

	public ArrayList<Gongu> closeGonguAll() {
		ArrayList<Gongu> closeList = null;

		Connection con = null;

		try {
			con = getConnection();
			// System.out.println(con);
			GonguDAO gonguDAO = GonguDAO.getInstance();
			gonguDAO.setConnection(con);

			closeList = gonguDAO.closeGongu();

			if (closeList.size() > 0) {
				// 주문상태도 변경
				con = getConnection();
				OrderDAO orderDAO = OrderDAO.getInstance();
				orderDAO.setConnection(con);

				boolean isOrderUpdateSuccess = false;

				int orderUpdateCount = 0;
				orderUpdateCount = orderDAO.updateOrder(closeList);

				System.out.println(orderUpdateCount);

				if (orderUpdateCount > 0) {
					isOrderUpdateSuccess = true;
					commit(con);

				} else {
					rollback(con);
				}

			} else {
				rollback(con);
			}

		} catch (Exception e) {
			System.out.println("공구종료오류:" + e);
			e.printStackTrace();
			rollback(con);

		} finally {
			close(con);
		}

		return closeList;
	}

}
