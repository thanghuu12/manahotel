package Controller;

import Dao.ReviewDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class ReviewController {
    @WebServlet("/customer/add-review")
    public static class AddReviewServlet extends HttpServlet {
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String rate = req.getParameter("rate");
            String comment = req.getParameter("comment");
            String customer_id = req.getSession().getAttribute("customer").toString();
            String booking_id = req.getParameter("booking_id");
            if (ReviewDao.addReview(booking_id, customer_id, rate, comment)) {
                req.getSession().setAttribute("mess", "success|Đánh giá thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Đánh giá không thành công.");
            }
            resp.sendRedirect(req.getContextPath() + "/customer/booking");
        }
    }

    @WebServlet("/customer/update-review")
    public static class UpdateReviewServlet extends HttpServlet {
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String rate = req.getParameter("rate");
            String comment = req.getParameter("comment");
            String customer_id = req.getSession().getAttribute("customer").toString();
            String booking_id = req.getParameter("booking_id");
            String review_id = req.getParameter("review_id");
            if (ReviewDao.updateReview(booking_id, customer_id, rate, comment, review_id)) {
                req.getSession().setAttribute("mess", "success|Cập nhật đánh giá thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Cập nhật đánh giá không thành công.");
            }
            resp.sendRedirect(req.getContextPath() + "/customer/booking");
        }
    }
}
