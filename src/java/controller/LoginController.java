/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import user.UserDAO;
import user.UserDTO;

/**
 *
 * @author hd
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private static final String ERROR="login.jsp";
    private static final String AD="AD";
    private static final String ADMIN_PAGE="admin.jsp";
    private static final String US="US";
    private static final String USER_PAGE="home.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url= ERROR;
        try {
            String UserId= request.getParameter("UserIdorEmail");
            String Password= request.getParameter("Password");
            UserDAO dao= new UserDAO();
            UserDTO loginUser= dao.checkLogin(UserId, Password);

            if(loginUser!= null){
                HttpSession session= request.getSession();
                session.setAttribute("LOGIN_USER", loginUser);

                String RoleID= loginUser.getRoleID();
                if(AD.equals(RoleID)){
                    url= ADMIN_PAGE;
                }else if(US.equals(RoleID)){
                    url= USER_PAGE;
                }else{
                    request.setAttribute("message", "Your role is not support!");
                }
            }else{
                request.setAttribute("message", "Incorrect UserId or Password");
            }
            
        } catch (Exception e) {
            log("Error at LoginController: "+ e.toString());
        }finally{
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
