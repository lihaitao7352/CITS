import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // フォームからの入力を取得
        String orgCode = request.getParameter("orgCode");
        String itemCode = request.getParameter("itemCode");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        String url = "jdbc:oracle:thin:@localhost:1521:your_sid";
        String user = "your_username";
        String password = "your_password";

        List<Result> initialResults = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(url, user, password);
             Statement stmt = conn.createStatement()) {

            // 初期結果を取得
            String query = "SELECT * FROM initial_results";
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                // 結果をオブジェクトに変換してリストに追加
                Result result = new Result(
                    rs.getString("件名コード"),
                    rs.getString("件名名称"),
                    rs.getString("組織"),
                    rs.getString("予想着手日"),
                    rs.getString("予想完了日"),
                    rs.getString("予算着手日"),
                    rs.getString("予算完了日")
                );
                initialResults.add(result);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // JSP に初期結果を渡して表示
        request.setAttribute("initialResults", initialResults);
        request.getRequestDispatcher("search.jsp").forward(request, response);
    }
}
