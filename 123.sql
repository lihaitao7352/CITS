SELECT
    PHJD.PHJD_KHA_COD AS KHA_COD,
    SKMD.SKMD_SZK_COD AS SZK_COD,
    PHJD.PHJD_KM_COD AS KM_COD,
    PHJD.PHJD_TAS_YDO AS TAS_YDO,
    PPJD.PPJD_KM_COD AS IRS_KM_COD,
    SKMD.SKMD_SZK_COD AS IRS_SZK_COD,
    SUM(NVL(PHJD.PHJD_4M_JSC, 0)) AS JSC_04M,
    SUM(NVL(PHJD.PHJD_5M_JSC, 0)) AS JSC_05M,
    SUM(NVL(PHJD.PHJD_6M_JSC, 0)) AS JSC_06M,
    SUM(NVL(PHJD.PHJD_7M_JSC, 0)) AS JSC_07M,
    SUM(NVL(PHJD.PHJD_8M_JSC, 0)) AS JSC_08M,
    SUM(NVL(PHJD.PHJD_9M_JSC, 0)) AS JSC_09M,
    SUM(NVL(PHJD.PHJD_10M_JSC, 0)) AS JSC 10M,
    SUM(NVL(PHJD.PHJD_11M_JSC, 0)) AS JSC 11M,
    SUM(NVL(PHJD.PHJD_12M_JSC, 0)) AS JSC 12M,
    SUM(NVL(PHJD.PHJD_1M_JSC, 0)) AS JSC 01M,
    SUM(NVL(PHJD.PHJD_2M_JSC, 0)) AS JSC 02M,
    SUM(NVL(PHJD.PHJD_3M_JSC, 0)) AS JSC 03M
FROM
    BGTA2_PHJD PHJD
INNER JOIN
    BGTA3_PPJD PPJD ON PPJD.PPJD_KHA_COD = PHJD.PHJD_KHA_COD
    AND PPJD.PPJD_PJ_COD = PHJD.PHJD_IRS_PJ_COD
    AND PPJD.PPJD_IRM_PJ_COD = PHJD.PHJD_PJ_COD
INNER JOIN
    BGTA2_SKMD SKMD ON SKMD.SKMD_KHA_COD = PHJD.PHJD_KHA_COD
    AND SKMD.SKMD_KBS_VER_ID = '60'
    AND SKMD.SKMD_KM_COD = PHJD.PHJD_KM_COD  -- 确保选择逻辑与 SQL2 一致
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
    PPJD.PPJD_KM_COD,
    SKMD.SKMD_SZK_COD
ORDER BY
    PHJD.PHJD_KHA_COD,
    SKMD.SKMD_SZK_COD,
    PHJD.PHJD_KM_COD,
    PHJD.PHJD_TAS_YDO;
