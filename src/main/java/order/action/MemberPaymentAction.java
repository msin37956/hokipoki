package order.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import gongu.svc.GonguReserveUpdateService;
import order.svc.MemberPaymentService;
import vo.ActionForward;

public class MemberPaymentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		HttpSession session = request.getSession();
		boolean paymentflag = false;
		boolean reserveflag = false;
		
		String gongu_id = request.getParameter("gongu_id");
		String member_id = (String)session.getAttribute("member_id");
	
		
		int delivery_id = Integer.parseInt(request.getParameter("delivery_id"));
		
		MemberPaymentService memberPaymentService = new MemberPaymentService();
		GonguReserveUpdateService gonguReserveUpdateService = new GonguReserveUpdateService();
		
		reserveflag = gonguReserveUpdateService.updateReserve(gongu_id);		
		paymentflag = memberPaymentService.paymentProcess(gongu_id,member_id,delivery_id);
		
		if(reserveflag && paymentflag) {
			return forward;
		}else {
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('결제 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		
		return forward;
	}

}
