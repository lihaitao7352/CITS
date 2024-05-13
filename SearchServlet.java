import java.io.IOException;
import java.sql.*;
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

             String query = "SELECT " +
                                "SKMD.SKMD_KM_COD, " +
                                "AKND.AKND_AKN_MSY, " +
                                "SKMD.SKMD_SZK_COD, " +
                                "SKMD.SKMD_CKS_YMD, " +
                                "SKMD.SKMD_KRY_YMD, " +
                                "YKMD.YKMD_CKS_YMD, " +
                                "YKMD.YKMD_KRY_YMD " +
                           "FROM " +
                                "BGTA2_SKMD SKMD " +
                                "JOIN BGTA3_AKND AKND ON SKMD.SKMD_KHA_COD = AKND.AKND_KHA_COD " +
                                    "AND SKMD.SKMD_SZK_COD = AKND.AKND_SZK_COD " +
                                    "AND SKMD.SKMD_KM_COD = AKND.AKND_KM_COD " +
                                "LEFT JOIN BGTA1_YKMD YKMD ON SKMD.SKMD_KHA_COD = YKMD.YKMD_KHA_COD " +
                                    "AND SKMD.SKMD_SZK_COD = YKMD.YKMD_SZK_COD " +
                                    "AND SKMD.SKMD_KM_COD = YKMD.YKMD_KM_COD " +
                                    "AND YKMD.YKMD_KBY_VER_ID = (SELECT MAX(YKMD_KBY_VER_ID) FROM BGTA1_YKMD WHERE YKMD_KHA_COD = SKMD.SKMD_KHA_COD) " +
                           "WHERE " +
                                "SKMD.SKMD_KBS_VER_ID = (SELECT MAX(SKMD_KBS_VER_ID) FROM BGTA2_SKMD WHERE SKMD_KHA_COD = SKMD.SKMD_KHA_COD)";
                                
            ResultSet rs = stmt.executeQuery(query);

            // 既存のデータをクリア
            stmt.executeUpdate("DELETE FROM temp_search_results");

            try (PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO temp_search_results (item_code, item_name, organization_code, predicted_start_date, predicted_end_date, budget_start_date, budget_end_date) VALUES (?, ?, ?, ?, ?, ?, ?)")) {
                while (rs.next()) {
                    Result result = new Result(
                        rs.getString("item_code"),
                        rs.getString("item_name"),
                        rs.getString("organization_code"),
                        rs.getDate("predicted_start_date"),
                        rs.getDate("predicted_end_date"),
                        rs.getDate("budget_start_date"),
                        rs.getDate("budget_end_date")
                    );
                    initialResults.add(result);

                    // 临时表へのデータ挿入
                    pstmt.setString(1, result.getItemCode());
                    pstmt.setString(2, result.getItemName());
                    pstmt.setString(3, result.getOrganizationCode());
                    pstmt.setDate(4, result.getPredictedStartDate());
                    pstmt.setDate(5, result.getPredictedEndDate());
                    pstmt.setDate(6, result.getBudgetStartDate());
                    pstmt.setDate(7, result.getBudgetEndDate());
                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("initialResults", initialResults);
        request.getRequestDispatcher("search.jsp").forward(request, response);
    }
}
