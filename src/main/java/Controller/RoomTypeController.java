package Controller;

import Dao.RoomTypeDao;
import Model.RoomType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class RoomTypeController {
    @WebServlet("/hotel/manage-room-type")
    public static class HotelViewRoomType extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            ArrayList<RoomType> roomTypes = RoomTypeDao.getAllRoomTypesOfAHotel((Integer) req.getSession().getAttribute("hotel"));
            req.setAttribute("roomTypes", roomTypes);
            req.getRequestDispatcher("/views/hotel/room-type.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
            String hotel_id = req.getSession().getAttribute("hotel").toString();
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            if (RoomTypeDao.addRoomType(name, description, hotel_id)){
                req.getSession().setAttribute("mess", "success|Thêm mới thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Lỗi hệ thống");
            }
            resp.sendRedirect(req.getContextPath() + "/hotel/manage-room-type");
        }
    }
    @WebServlet("/hotel/update-room-type")
    public static class UpdateRoomType extends HttpServlet{
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
            String hotel_id = req.getSession().getAttribute("hotel").toString();
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            String id = req.getParameter("id");
            if (RoomTypeDao.updateRoomType(name, description, hotel_id, id)){
                req.getSession().setAttribute("mess", "success|Cập nhật thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Lỗi hệ thống");
            }
            resp.sendRedirect(req.getContextPath() + "/hotel/manage-room-type");
        }
    }
}
