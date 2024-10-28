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
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

public class HomeController {
    @WebServlet("/home")
    public static class Index extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            req.getRequestDispatcher("/views/public/index.jsp").forward(req, resp);
        }
    }

    @WebServlet("/admin")
    public static class Admin extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            req.getRequestDispatcher("/views/admin/panel.jsp").forward(req, resp);
        }
    }

    @WebServlet("/hotel")
    public static class Hotel extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            req.getRequestDispatcher("/views/hotel/panel.jsp").forward(req, resp);
        }
    }

    /*   @WebServlet("/test-delete-image")
       public static class DeleteImage extends HttpServlet {
           @Override
           protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
               System.out.println(req.getServletContext().getRealPath("/") + "assets/uploads/a.txt");
               Path path = Paths.get(req.getServletContext().getRealPath("/") + "assets/uploads/a.txt");
               System.out.println(Files.deleteIfExists(path));
           }
       }*/
    @WebServlet("/database")
    public static class Database extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
            String db_name_connected = "";
            try {
                db_name_connected = DBContext.getConnection().getCatalog();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            resp.setContentType("text/html");
            PrintWriter out = resp.getWriter();
            out.println("<html><body>");
            if (req.getParameter("status") != null) {
                if (req.getParameter("status").equals("false")) {
                    out.println("Khởi tạo database lỗi");
                }
            }
            if (db_name_connected.equals("")) {
                out.println("Chưa kết nối với database nào");
            } else {
                out.println("Đã kết nối với database " + db_name_connected);
            }
            out.println("<a href='" + req.getContextPath() + "/recreate-db'><button type='button'>tạo lại database (drop tất cả các bảng)</button></a>");
            out.println("</body></html>");
        }

        @WebServlet("/recreate-db")
        public static class RecreateDB extends HttpServlet {
            @Override
            protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
                String sql = UploadImage.readFile(req.getServletContext().getRealPath("/") + "WEB-INF/init.sql");
                try {
                    DBContext.executeUpdate(sql, new String[]{});
                    req.getSession().setAttribute("mess", "success|Khởi tạo database thành công");
                    resp.sendRedirect(req.getContextPath() + "/");
                } catch (Exception e) {
                    e.printStackTrace();
                    resp.sendRedirect(req.getContextPath() + "/database?status=false");
                }
            }
        }

        @WebServlet("/search")
        public static class Search extends HttpServlet {
            @Override
            protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                String query = req.getParameter("query");
                String[] utility_ids = req.getParameterValues("utility_ids");
                String price_from = req.getParameter("price_from");
                String price_to = req.getParameter("price_to");
                String sort = req.getParameter("sort");
                ArrayList<Utility> utilities = UtilityDao.getAllUtilities();
                req.setAttribute("utilities", utilities);
                ArrayList<RoomType> roomTypes;
                if (query == null && utility_ids == null && price_from == null && price_to == null && sort == null) {
                    roomTypes = new ArrayList<>();
                } else {
                    roomTypes = RoomTypeDao.search(query, utility_ids, price_from, price_to, sort);
                }
                req.setAttribute("roomTypes", roomTypes);
                req.getRequestDispatcher("/views/public/search.jsp").forward(req, resp);
            }
        }
    }
    @WebServlet("/hotel/statistic")
    public static class Statistic extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            req.getRequestDispatcher("/views/hotel/statistic.jsp").forward(req, resp);
        }
    }
}
