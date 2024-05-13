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

            // SQL 查询语句
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
            
            // 执行查询
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                // 結果をオブジェクトに変換してリストに追加
                Result result = new Result(
                    rs.getString("SKMD_KM_COD"),
                    rs.getString("AKND_AKN_MSY"),
                    rs.getString("SKMD_SZK_COD"),
                    rs.getString("SKMD_CKS_YMD"),
                    rs.getString("SKMD_KRY_YMD"),
                    rs.getString("YKMD_CKS_YMD"),
                    rs.getString("YKMD_KRY_YMD")
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
