

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.Period;
import java.util.Scanner;
import java.util.StringTokenizer;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserVal
 */
//@WebServlet(name = "UserValidation", urlPatterns = { "/CustomerValidation" })
public class UserVal extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserVal() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		out.println("hi");
		
		
		String url = "jdbc:mysql://localhost:3306/GrocStore?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
        String user = "root";
        String password = "Alpha@123";
        
        try (Connection myConn = DriverManager.getConnection(url, user, password);) {
        	Statement st = myConn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM Customer WHERE UserName = \"" + request.getParameter("usrName") + "\"" + "AND Password = \"" + request.getParameter("passwd") + "\"");
            
//            while(rs.next()) {
//            	out.println(rs.getString("UserName") + " " + rs.getString("Password"));
//            }
            if(rs.next()) {
            	out.println("login successful");
            }
            else {
            	out.println("login unsuccessful");
            }
            
            
        
        }
        catch(SQLException ex) {
        	Logger lgr = Logger.getLogger(UserVal.class.getName());
            lgr.log(Level.SEVERE, ex.getMessage(), ex);
        }
		
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
