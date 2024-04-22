/*「JPTD_SNI_TRH_KBN」がグループ内で一貫しているかどうかを確認するために「MIN」と「MAX」を使用する必要があるかどうかについての質問に対する答えですが、確かに「MIN」と「MAX」を使用する方法は効果的です。これにより、各「JPTD_PJ_COD」グループ内での「JPTD_SNI_TRH_KBN」の最小値と最大値を計算し、これらが同じであれば、そのグループ内の全ての値が同一であると判断することができます。

具体的には、以下のように窓口関数を用いることで、このチェックを行うことができます。

```sql
*/
WITH GroupCheck AS (
    SELECT
        JPTD.JPTD_PJ_COD,
        JPTD.JPTD_JYS_VER_RBN,
        JPTD.JPTD_SNI_TRH_KBN,
        MIN(JPTD.JPTD_SNI_TRH_KBN) OVER (PARTITION BY JPTD.JPTD_PJ_COD) AS Min_KBN,
        MAX(JPTD.JPTD_SNI_TRH_KBN) OVER (PARTITION BY JPTD.JPTD_PJ_COD) AS Max_KBN
    FROM
        BGTA3_JPTD JPTD
),
Verifications AS (
    SELECT
        GC.JPTD_PJ_COD,
        GC.JPTD_JYS_VER_RBN,
        GC.JPTD_SNI_TRH_KBN,
        CASE WHEN GC.Min_KBN = GC.Max_KBN THEN 1 ELSE 0 END AS IsUniform
    FROM
        GroupCheck GC
)
SELECT
    V.JPTD_PJ_COD,
    V.JPTD_JYS_VER_RBN,
    V.JPTD_SNI_TRH_KBN,
    CASE WHEN MIN(V.IsUniform) OVER (PARTITION BY V.JPTD_PJ_COD) = 1 THEN 'OK' ELSE 'NG' END AS 判断列
FROM
    Verifications V
ORDER BY
    V.JPTD_PJ_COD,
    V.JPTD_JYS_VER_RBN,
    V.JPTD_SNI_TRH_KBN
/*
このクエリでは、各プロジェクトコード（JPTD_PJ_COD）に対して最小値と最大値を計算し、
それらが一致するかどうかで全てのレコードが「OK」または「NG」と判断されます。これにより、グループ内の一貫性を簡単に確認できます。
また、他の方法としては、DISTINCT キーワードを使ったサブクエリを用いて特定の列の値がグループ内で一意かどうかをカウントする方法もありますが、`MIN` と `MAX` を使う方法の方がシンプルで効率的です。
*/

WITH ConsistencyCheck AS (
    SELECT
        JPTD.JPTD_PJ_COD,
        COUNT(DISTINCT JPTD.JPTD_SNI_TRH_KBN) AS UniqueCount
    FROM
        BGTA3_JPTD JPTD
    GROUP BY
        JPTD.JPTD_PJ_COD
)
SELECT
    JPTD.JPTD_PJ_COD,
    JPTD.JPTD_JYS_VER_RBN,
    JPTD.JPTD_SNI_TRH_KBN,
    CASE WHEN CC.UniqueCount = 1 THEN 'OK' ELSE 'NG' END AS 判断列
FROM
    BGTA3_JPTD JPTD
JOIN
    ConsistencyCheck CC ON JPTD.JPTD_PJ_COD = CC.JPTD_PJ_COD
WHERE
    JPTD.JPTD_SNI_TRH_KBN = '00'
ORDER BY
    JPTD.JPTD_PJ_COD, JPTD.JPTD_JYS_VER_RBN, JPTD.JPTD_SNI_TRH_KBN
