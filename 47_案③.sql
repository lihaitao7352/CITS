/*
案②と茂木さん連携の改善案結合
1:インラインビューを直接使用して、特にSKMDテーブルにフィルタ条件を適用する際、全表スキャンを減少させることができます。
2:SUM(NVL())を使用することで、データが空でも計算を確実に行うことができます。
3:複雑なロジックをサブクエリに分解することで、データベースのオプティマイザがクエリをより効率的に処理するのに役立つ可能性があります。
4:EXISTSを使用して存在性チェックを行うことで、直接のJOIN操作よりも効率的です。
もうすごし改善ところ：COALESCE関数は短絡評価（ショートサーキット評価）を使用するため、特定の状況下でNVLよりも効率的です。
*/
SELECT
    PHJD.PHJD_KHA_COD AS KHA_COD,
    SKMD.SKMD_SZK_COD AS SZK_COD,
    PHJD.PHJD_KM_COD AS KM_COD,
    PHJD.PHJD_TAS_YDO AS TAS_YDO,
    PPJD.PPJD_KM_COD AS IRS_KM_COD,
    SKMD.SKMD_SZK_COD AS IRS_SZK_COD,
    SUM(NVL(PHJD.PHJD_4M_JSC, 0)) AS JSC_4M,
    SUM(NVL(PHJD.PHJD_5M_JSC, 0)) AS JSC_5M,
    SUM(NVL(PHJD.PHJD_6M_JSC, 0)) AS JSC_6M,
    SUM(NVL(PHJD.PHJD_7M_JSC, 0)) AS JSC_7M,
    SUM(NVL(PHJD.PHJD_8M_JSC, 0)) AS JSC_8M,
    SUM(NVL(PHJD.PHJD_9M_JSC, 0)) AS "JSC_9M",
    SUM(NVL(PHJD.PHJD_10M_JSC, 0)) AS "JSC_10M",
    SUM(NVL(PHJD.PHJD_11M_JSC, 0)) AS "JSC_11M",
    SUM(NVL(PHJD.PHJD_12M_JSC, 0)) AS "JSC_12M",
    SUM(NVL(PHJD.PHJD_1M_JSC, 0)) AS "JSC_1M",
    SUM(NVL(PHJD.PHJD_2M_JSC, 0)) AS "JSC_2M",
    SUM(NVL(PHJD.PHJD_3M_JSC, 0)) AS "JSC_3M"
FROM
    BGTA2_PHJD PHJD
INNER JOIN
    BGTA3_PPJD PPJD ON PPJD.PPJD_KHA_COD = PHJD.PHJD_KHA_COD
    AND PPJD.PPJD_PJ_COD = PHJD.PHJD_IRS_PJ_COD
    AND PPJD.PPJD_IRM_PJ_COD = PHJD.PHJD_PJ_COD
INNER JOIN
    BGTA2_SKMD SKMD ON SKMD.SKMD_KHA_COD = PHJD.PHJD_KHA_COD
    AND SKMD.SKMD_KBS_VER_ID = '60'
    AND SKMD.SKMD_KM_COD IN (PPJD.PPJD_KM_COD, PHJD.PHJD_KM_COD)
WHERE
    PHJD.PHJD_KHA_COD = '20512'
    AND PHJD.PHJD_TAS_YDO = '2023'
    AND PHJD.PHJD_GHM_LV1_COD = '52'
    AND PHJD.PHJD_YSS_DTK_COD = '9'
    AND PHJD.PHJD_YSS_DTB_COD = '92'
    AND EXISTS (
        SELECT 1
        FROM BGTAZ_PTCD PTCD
        WHERE PTCD.PTCD_KHA_COD = PHJD.PHJD_KHA_COD
        AND PTCD.PTCD_PJ_COD = PHJD.PHJD_PJ_COD
    )
GROUP BY
    PHJD.PHJD_KHA_COD,
    SKMD.SKMD_SZK_COD,
    PHJD.PHJD_KM_COD,
    PHJD.PHJD_TAS_YDO,
    PPJD.PPJD_KM_COD
ORDER BY
    PHJD.PHJD_KHA_COD,
    SKMD.SKMD_SZK_COD,
    PHJD.PHJD_KM_COD,
    PHJD.PHJD_TAS_YDO;
