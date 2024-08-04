<%@page import="Project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%
String course = request.getParameter("course");
String branch = request.getParameter("branch");
String rollNo = request.getParameter("rollNo");
String name = request.getParameter("name");
String fatherName = request.getParameter("fatherName");
String gender = request.getParameter("gender");

System.out.println("Course: " + course);

if (course == null || course.isEmpty()) {
    // Display an error message to the user
    out.println("<p style=\"color: red;\">Course field cannot be empty. Please provide a value for the course.</p>");
} else {
    try {
        Connection con = ConnectionProvider.getCon();
        PreparedStatement pstmt = con.prepareStatement("INSERT INTO student (course, branch, rollNo, name, fatherName, gender) VALUES (?, ?, ?, ?, ?, ?)");
        pstmt.setString(1, course);
        pstmt.setString(2, branch);
        pstmt.setString(3, rollNo); // Assuming rollNo is a string
        pstmt.setString(4, name);
        pstmt.setString(5, fatherName);
        pstmt.setString(6, gender);

        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            response.sendRedirect("adminHome.jsp");
        } else {
            throw new SQLException("Failed to insert data into the database.");
        }
        
        pstmt.close();
        con.close();
    } catch(SQLException e) {
        // Log the error
        e.printStackTrace();
        // Display the error message to the user
        out.println("<p style=\"color: red;\">An error occurred while processing your request: " + e.getMessage() + "</p>");
    }
}
%>

