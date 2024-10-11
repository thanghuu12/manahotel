package Controller;

import Dao.DBContext;
import Util.UploadImage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

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
    public static class Hotel extends HttpServlet{
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
    public static class Database extends HttpServlet{
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
             if (req.getParameter("status").equals("false")){
                 out.println("Khởi tạo database lỗi");
             }
         }
         if (db_name_connected.equals("")){
             out.println("Chưa kết nối với database nào");
         } else {
             out.println("Đã kết nối với database " + db_name_connected);
         }
         out.println("<a href='"+req.getContextPath()+"/recreate-db'><button type='button'>tạo lại database (drop tất cả các bảng)</button></a>");
         out.println("</body></html>");
     }
     @WebServlet("/recreate-db")
     public static class RecreateDB extends HttpServlet{
         @Override
         protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
             String sql = UploadImage.readFile(req.getServletContext().getRealPath("/") + "WEB-INF/init.sql");
             try {
                 req.getSession().setAttribute("mess", "success|Khởi tạo database thành công");
                 resp.sendRedirect(req.getContextPath() + "/");
             }catch (Exception e){
                 e.printStackTrace();
                 resp.sendRedirect(req.getContextPath() + "/database?status=false");

             }
         }
     }
 }
}
