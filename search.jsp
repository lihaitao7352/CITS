<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>検索画面</title>
<script>
    function requestAction() {
        alert("依頼の処理を実行します");
    }

    function releaseAction() {
        alert("解除の処理を実行します");
    }
</script>
</head>
<body>
    <h1>検索画面</h1>
    <form action="SearchServlet" method="post">
        組織コード：<input type="text" name="orgCode"><br>
        件名コード：<input type="text" name="itemCode"><br>
        着手日：<input type="text" name="startDate"><br>
        完了日：<input type="text" name="endDate"><br>
        <input type="submit" value="検索">
    </form>

    <h2>初期検索結果</h2>
    <p>--状態　　☑　〇：未　☑　●：年度切替　☑　差戻　☑　承認</p>
    <table>
        <thead>
            <tr>
                <th>連番</th>
                <th>件名コード</th>
                <th>件名名称</th>
                <th>組織</th>
                <th>予想着手日</th>
                <th>予想完了日</th>
                <th>予算着手日</th>
                <th>予算完了日</th>
                <th>状態</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="result" items="${initialResults}" varStatus="loop">
                <tr>
                    <td>${loop.index + 1}</td>
                    <td>${result.itemCode}</td>
                    <td>${result.itemName}</td>
                    <td>${result.organization}</td>
                    <td>${result.startDate}</td>
                    <td>${result.endDate}</td>
                    <td>${result.budgetStartDate}</td>
                    <td>${result.budgetEndDate}</td>
                    <td>状態列</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <button onclick="requestAction()">依頼</button>
    <button onclick="releaseAction()">解除</button>
</body>
</html>
