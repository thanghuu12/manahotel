package Controller;

import Dao.UtilityDao;
import Model.Utility;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

public class UtilityController {
    @WebServlet("/admin/manage-utility")
    public static class ManageUtility extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            ArrayList<Utility> utilities = UtilityDao.getAllUtilities();
            req.setAttribute("utilities", utilities);
            req.getRequestDispatcher("/views/admin/utility-control.jsp").forward(req, resp);
        }

        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
            String name = req.getParameter("name");
            if (UtilityDao.addUtility(name)){
                req.getSession().setAttribute("mess", "success|Thêm mới thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Lỗi hệ thống.");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/manage-utility");
        }
    }

    @WebServlet("/admin/update-utility")
    public static class UpdateUtility extends HttpServlet{
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
            String id = req.getParameter("id");
            String name = req.getParameter("name");
            if (UtilityDao.updateUtility(name, id)){
                req.getSession().setAttribute("mess", "success|Cập nhật thành công.");
            } else {
                req.getSession().setAttribute("mess", "error|Lỗi hệ thống.");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/manage-utility");
        }
    }
}
