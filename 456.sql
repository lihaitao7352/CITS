/*SQLクエリの改善についての説明を日本語で提供します。以下の最適化されたクエリは、可読性と効率性を高めるためのものです。*/
SELECT 
    PHJD.PHJD_KHA_COD AS KHA_COD,
    SKMD.SKMD_SZK_COD AS SZK_COD,
    PHJD.PHJD_KM_COD AS KM_COD,
    PHJD.PHJD_TAS_YDO AS TAS_YDO,
    PPJD.PPJD_KM_COD AS IRS_KM_COD,
    SSKMD.SKMD_SZK_COD AS IRS_SZK_COD,
    SUM(NVL(PHJD.PHJD_4M_JSC, 0)) AS JSC_04M,
    SUM(NVL(PHJD.PHJD_5M_JSC, 0)) AS JSC_05M,
    SUM(NVL(PHJD.PHJD_6M_JSC, 0)) AS JSC_06M,
    SUM(NVL(PHJD.PHJD_7M_JSC, 0)) AS JSC_07M,
    SUM(NVL(PHJD.PHJD_8M_JSC, 0)) AS JSC_08M,
    SUM(NVL(PHJD.PHJD_9M_JSC, 0)) AS JSC_09M,
    SUM(NVL(PHJD.PHJD_10M_JSC, 0)) AS JSC_10M,
    SUM(NVL(PHJD.PHJD_11M_JSC, 0)) AS JSC_11M,
    SUM(NVL(PHJD.PHJD_12M_JSC, 0)) AS JSC_12M,
    SUM(NVL(PHJD.PHJD_1M_JSC, 0)) AS JSC_01M,
    SUM(NVL(PHJD.PHJD_2M_JSC, 0)) AS JSC_02M,
    SUM(NVL(PHJD.PHJD_3M_JSC, 0)) AS JSC_03M
FROM 
    BGTA2_PHJD PHJD
JOIN
    BGTA3_PPJD PPJD ON PHJD.PHJD_KHA_COD = PPJD.PPJD_KHA_COD
        AND PHJD.PHJD_IRS_PJ_COD = PPJD.PPJD_PJ_COD
        AND PHJD.PHJD_PJ_COD = PPJD.PPJD_IRM_PJ_COD
JOIN
    BGTA2_SKMD SKMD ON PHJD.PHJD_KHA_COD = SKMD.SKMD_KHA_COD
        AND PHJD.PHJD_KM_COD = SKMD.SKMD_KM_COD
        AND SKMD.SKMD_KBS_VER_ID = 60
JOIN
    BGTA2_SKMD SSKMD ON PHJD.PHJD_KM_COD = SSKMD.SKMD_KM_COD
        AND SSKMD.SKMD_KHA_COD = '20512'
        AND SSKMD.SKMD_KBS_VER_ID = 60
WHERE
    PHJD.PHJD_KHA_COD = '20512'
    AND PHJD.PHJD_TAS_YDO = '2023'
    AND PHJD.PHJD_YSS_DTK_COD = '9'
    AND PHJD.PHJD_YSS_DTB_COD = '92'
    AND PHJD.PHJD_GHM_LV1_COD = '52'
GROUP BY 
    PHJD.PHJD_KHA_COD,
    SKMD.SKMD_SZK_COD,
    PHJD.PHJD_KM_COD,
    PHJD.PHJD_TAS_YDO,
    PPJD.PPJD_KM_COD,
    SSKMD.SKMD_SZK_COD
ORDER BY 
    PHJD.PHJD_KHA_COD,
    SKMD.SKMD_SZK_COD,
    PHJD.PHJD_KM_COD,
    PHJD.PHJD_TAS_YDO;
