package Controller;

import Dao.RoomTypeDao;
import Dao.UtilityDao;
import Model.RoomType;
import Model.Utility;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

public class RoomController {
    @WebServlet("/hotel/manage-room")
    public static class ManageRoom extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            ArrayList<Utility> utilities = UtilityDao.getAllUtilities();
            ArrayList<RoomType> roomTypes = RoomTypeDao.getAllRoomTypesOfAHotel((Integer) req.getSession().getAttribute("hotel"));
            req.setAttribute("utilities", utilities);
            req.setAttribute("roomTypes", roomTypes);
            req.getRequestDispatcher("/views/hotel/room.jsp").forward(req, resp);
        }
    }
}
