package Controller;


import Dao.BookingDao;
import Dao.RoomDao;
import Model.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

public class BookingController {
    @WebServlet("/customer/book-room")
    public static class CustomerBookRoom extends HttpServlet{
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String room_id = req.getParameter("room_id");
            String from_date = req.getParameter("from_date");
            String to_date = req.getParameter("to_date");
            String room_type_id = req.getParameter("room_type_id");
            String customer_id = req.getSession().getAttribute("customer").toString();
            if (RoomDao.bookARoom(room_id, from_date, to_date, room_type_id, customer_id)){
                req.getSession().setAttribute("mess", "success|Đặt phòng thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Đặt phòng không thành công.");
            }
            resp.sendRedirect(req.getContextPath() + "/room-type?id=" + room_type_id + "&from_date=" + from_date + "&to_date=" + to_date);
        }
    }

    @WebServlet("/customer/booking")
    public static class CustomerViewBooking extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String customer_id = req.getSession().getAttribute("customer").toString();
            ArrayList<Booking> bookings = BookingDao.getBookingsOfCustomer(customer_id);
            req.setAttribute("bookings", bookings);
            req.getRequestDispatcher("/views/customer/booking.jsp").forward(req, resp);
        }
    }
}
