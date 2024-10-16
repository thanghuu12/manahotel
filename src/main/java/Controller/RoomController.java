package Controller;

import Dao.DBContext;
import Dao.RoomDao;
import Dao.RoomTypeDao;
import Dao.UtilityDao;
import Model.Room;
import Model.RoomType;
import Model.Utility;
import Util.UploadImage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

public class RoomController {
    @WebServlet("/hotel/manage-room")
    public static class ManageRoom extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            ArrayList<Utility> utilities = UtilityDao.getAllUtilities();
            ArrayList<RoomType> roomTypes = RoomTypeDao.getAllRoomTypesOfAHotel((Integer) req.getSession().getAttribute("hotel"));
            ArrayList<Room> rooms = RoomDao.getAllRoomsOfAHotel(req.getSession().getAttribute("hotel").toString());
            req.setAttribute("utilities", utilities);
            req.setAttribute("roomTypes", roomTypes);
            req.setAttribute("rooms", rooms);
            req.getRequestDispatcher("/views/hotel/room.jsp").forward(req, resp);
        }
    }

    @WebServlet("/hotel/add-room")
    @MultipartConfig(
            fileSizeThreshold = 1024 * 1024,
            maxFileSize = 1024 * 1024 * 50,
            maxRequestSize = 1024 * 1024 * 50
    )
    public static class AddRoom extends HttpServlet {
        public static ArrayList<String> generateRange(String x, String y) {
            int start = Integer.parseInt(x);
            int end = Integer.parseInt(y);
            ArrayList<String> range = new ArrayList<>();
            for (int i = start; i <= end; i++) {
                range.add(String.valueOf(i));
            }
            return range;
        }

        public static void insert1room(ArrayList<Integer> images_ids, String room_type_id, String[] utilityIds, String roomNumber, String area, String beds, String price, String hotel_id) {
            int room_id = DBContext.insertGetLastId("insert into rooms(number, room_type_id, beds, area, price, is_available, hotel_id) values (?, ?, ?, ?, ?, 'true', ?);", new String[]{roomNumber, room_type_id, beds, area, price, hotel_id});
            StringBuilder sql = new StringBuilder();
            String[] images_ids_string = new String[images_ids.size()];
            for (int i = 0; i < images_ids.size(); i++) {
                images_ids_string[i] = String.valueOf(images_ids.get(i));
                sql.append("insert into room_has_images(room_id, image_id) VALUES (").append(room_id).append(", ?);");
            }
            DBContext.executeUpdate(String.valueOf(sql), images_ids_string);
            sql = new StringBuilder();
            for (int i = 0; i < utilityIds.length; i++) {
                sql.append("insert into room_has_utilities(utility_id, room_id) values (?, ").append(room_id).append(");");
            }
            DBContext.executeUpdate(String.valueOf(sql), utilityIds);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            ArrayList<String> fileNames = UploadImage.multipleFileUpload(req, "images");
            ArrayList<Integer> images_ids = DBContext.insertGetLastIds("insert into images(url) values (?);", fileNames.toArray(new String[0]));
            String room_type_id = req.getParameter("room_type_id");
            String[] utilityIds = req.getParameterValues("utility_ids");
            String from = req.getParameter("from");
            String to = req.getParameter("to");
            String area = req.getParameter("area");
            String beds = req.getParameter("beds");
            String price = req.getParameter("price");
            String hotel_id = req.getSession().getAttribute("hotel").toString();
            try {
                if (to.isEmpty()) {
                    insert1room(images_ids, room_type_id, utilityIds, from, area, beds, price, hotel_id);
                } else {
                    ArrayList<String> range = generateRange(from, to);
                    for (int i = 0; i < range.size(); i++) {
                        insert1room(images_ids, room_type_id, utilityIds, range.get(i), area, beds, price, hotel_id);
                    }
                }
            } catch (Exception e) {
                req.getSession().setAttribute("mess", "error|Lỗi hệ thống.");
                resp.sendRedirect(req.getContextPath() + "/hotel/manage-room");
            }
            req.getSession().setAttribute("mess", "success|Thêm phòng thành công.");
            resp.sendRedirect(req.getContextPath() + "/hotel/manage-room");
        }
    }
    @WebServlet("/hotel/change-availability")
    public static class ChangeAvailability extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String id = req.getParameter("id");
            String hotel_id = req.getSession().getAttribute("hotel").toString();
            if (DBContext.executeUpdate("update rooms set is_available = ~ is_available where id = ? and hotel_id = ?;", new String[]{id, hotel_id})){
                req.getSession().setAttribute("mess", "success|Cập nhật thành công.");
                resp.sendRedirect(req.getContextPath() + "/hotel/manage-room");
            } else {
                req.getSession().setAttribute("mess", "error|Lỗi hệ thống.");
                resp.sendRedirect(req.getContextPath() + "/hotel/manage-room");
            }
        }
    }
    @WebServlet("/hotel/update-room")
    @MultipartConfig(
            fileSizeThreshold = 1024 * 1024,
            maxFileSize = 1024 * 1024 * 50,
            maxRequestSize = 1024 * 1024 * 50
    )
    public static class HotelUpdateRoom extends HttpServlet{
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            try {
                String room_id = req.getParameter("id");
                String hotel_id = req.getSession().getAttribute("hotel").toString();
                String room_type_id = req.getParameter("room_type_id");
                String[] utility_ids = req.getParameterValues("utility_ids");
                String number = req.getParameter("number");
                String area = req.getParameter("area");
                String beds = req.getParameter("beds");
                String price = req.getParameter("price");
                String images_to_delete = req.getParameter("images_to_delete");
                RoomDao.updateRoom(number, room_type_id, beds, area, price, room_id, hotel_id);
                RoomDao.updateUtilities(utility_ids, room_id, hotel_id);
                ArrayList<String> fileNames = UploadImage.multipleFileUpload(req, "images");
                ArrayList<Integer> images_ids = DBContext.insertGetLastIds("insert into images(url) values (?);", fileNames.toArray(new String[0]));
                RoomDao.updateImagesOfRoom(images_ids, images_to_delete, hotel_id, room_id);
            } catch (Exception e){
                e.printStackTrace();
                req.getSession().setAttribute("mess", "error|Lỗi hệ thống.");
                resp.sendRedirect(req.getContextPath() + "/hotel/manage-room");
            }
            req.getSession().setAttribute("mess", "success|Cập nhật thành công.");
            resp.sendRedirect(req.getContextPath() + "/hotel/manage-room");
        }
    }
}
