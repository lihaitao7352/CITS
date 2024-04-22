/**********仕様**********
プロジェクト	VER	社内取引	
	12345	1	00	OK
	12345	2	00	
	12456	1	00	NG
	12456	2	10	
リスト		VER	社内取引	
	12456	1	00	
		2	10	
テーブル名：実行予算・プロジェクト情報（BGTA3_JPTD）
*/
SELECT
    SUBSTR(JPTD.JPTD_PJ_COD, 1, 9),
    JPTD.JPTD_PJ_COD,
    JPTD.JPTD_JYS_VER_RBN,
    JPTD.JPTD_SNI_TRH_KBN
FROM
    BGTA3_JPTD JPTD
WHERE
    JPTD.JPTD_SNI_TRH_KBN = '00'
ORDER BY
    SUBSTR(JPTD.JPTD_PJ_COD, 1, 9),
    JPTD.JPTD_PJ_COD,
    JPTD.JPTD_JYS_VER_RBN,
    JPTD.JPTD_SNI_TRH_KBN



---
	プロジェクト	VER	社内取引	
	12345	1	00	OK
	12345	2	00	
	12456	1	00	NG
	12456	2	10	実行予算・プロジェクト情報
リスト		VER	社内取引	
	12456	1	00	
		2	10	


--------------
WITH RankedProjects AS (
    SELECT
        JPTD.JPTD_PJ_COD,
        JPTD.JPTD_JYS_VER_RBN,
        JPTD.JPTD_SNI_TRH_KBN,
        ROW_NUMBER() OVER (PARTITION BY JPTD.JPTD_PJ_COD ORDER BY JPTD.JPTD_JYS_VER_RBN) AS Rank
    FROM
        BGTA3_JPTD JPTD
    WHERE
        JPTD.JPTD_SNI_TRH_KBN = '00'
)
SELECT
    SUBSTR(RankedProjects.JPTD_PJ_COD, 1, 9) AS PJ_COD_Short,
    RankedProjects.JPTD_PJ_COD,
    RankedProjects.JPTD_JYS_VER_RBN,
    RankedProjects.JPTD_SNI_TRH_KBN,
    CASE
        WHEN RankedProjects.Rank = 1 THEN 'OK'
        ELSE 'NG'
    END AS 判断列
FROM
    RankedProjects
ORDER BY
    PJ_COD_Short,
    RankedProjects.JPTD_PJ_COD,
    RankedProjects.JPTD_JYS_VER_RBN,
    RankedProjects.JPTD_SNI_TRH_KBN




-----------------------
WITH SequentialCheck AS (
    SELECT
        JPTD.JPTD_PJ_COD,
        JPTD.JPTD_JYS_VER_RBN,
        JPTD.JPTD_SNI_TRH_KBN,
        LAG(JPTD.JPTD_JYS_VER_RBN, 1) OVER (PARTITION BY JPTD.JPTD_PJ_COD ORDER BY JPTD.JPTD_JYS_VER_RBN) AS Prev_VER,
        MIN(JPTD.JPTD_SNI_TRH_KBN) OVER (PARTITION BY JPTD.JPTD_PJ_COD) AS Min_KBN,
        MAX(JPTD.JPTD_SNI_TRH_KBN) OVER (PARTITION BY JPTD.JPTD_PJ_COD) AS Max_KBN
    FROM
        BGTA3_JPTD JPTD
    WHERE
        JPTD.JPTD_SNI_TRH_KBN = '00'
)
SELECT
    SUBSTR(SC.JPTD_PJ_COD, 1, 9) AS PJ_COD_Short,
    SC.JPTD_PJ_COD,
    SC.JPTD_JYS_VER_RBN,
    SC.JPTD_SNI_TRH_KBN,
    CASE
        WHEN SC.JPTD_JYS_VER_RBN = SC.Prev_VER + 1 AND SC.Min_KBN = SC.Max_KBN THEN 'OK'
        ELSE 'NG'
    END AS 判断列
FROM
    SequentialCheck SC
ORDER BY
    PJ_COD_Short,
    SC.JPTD_PJ_COD,
    SC.JPTD_JYS_VER_RBN,
    SC.JPTD_SNI_TRH_KBN

