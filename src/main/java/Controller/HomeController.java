package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

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
}
