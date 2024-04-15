SELECT 
    PHJD.PHJD_KHA_COD AS KHA_COD,
    SKMD.SKMD_SZK_COD AS SZK_COD,
    PHJD.PHJD_KM_COD AS KM_COD,
    PHJD.PHJD_TAS_YDO AS TAS_YDO,
    PPJD.PPJD_KM_COD AS IRS_KM_COD,
    SSKMD.SKMD_SZK_COD AS IRS_SZK_COD,
    SUM(NVL(PHJD.PHJD_4M_JSC, 0)) AS JSC_4M,
    SUM(NVL(PHJD.PHJD_5M_JSC, 0)) AS JSC_5M,
    SUM(NVL(PHJD.PHJD_6M_JSC, 0)) AS JSC_6M,
    SUM(NVL(PHJD.PHJD_7M_JSC, 0)) AS JSC_7M,
    SUM(NVL(PHJD.PHJD_8M_JSC, 0)) AS JSC_8M,
    SUM(NVL(PHJD.PHJD_9M_JSC, 0)) AS JSC_9M,
    SUM(NVL(PHJD.PHJD_10M_JSC, 0)) AS JSC_10M,
    SUM(NVL(PHJD.PHJD_11M_JSC, 0)) AS JSC 11M,
    SUM(NVL(PHJD.PHJD_12M_JSC, 0)) AS JSC 12M,
    SUM(NVL(PHJD.PHJD_1M_JSC, 0)) AS JSC 1M,
    SUM(NVL(PHJD.PHJD_2M_JSC, 0)) AS JSC 2M,
    SUM(NVL(PHJD.PHJD_3M_JSC, 0)) AS JSC 3M
FROM BGTA2_PHJD PHJD
INNER JOIN BGTA3_PPJD PPJD ON PHJD.PHJD_KHA_COD = PPJD.PPJD_KHA_COD
    AND PHJD.PHJD_IRS_PJ_COD = PPJD.PPJD_PJ_COD
    AND PHJD.PHJD_PJ_COD = PPJD.PPJD_IRM_PJ_COD
INNER JOIN BGTAZ_PTCD PTCD ON PTCD.PTCD_KHA_COD = PHJD.PHJD_KHA_COD
    AND PTCD.PTCD_PJ_COD = PHJD.PHJD_PJ_COD
INNER JOIN BGTA2_SKMD SKMD ON SKMD.SKMD_KHA_COD = PHJD.PHJD_KHA_COD
    AND SKMD.SKMD_KM_COD = PHJD.PHJD_KM_COD
    AND SKMD.SKMD_KBS_VER_ID = '60'
INNER JOIN BGTA2_SKMD SSKMD ON SSKMD.SKMD_KM_COD = PPJD.PPJD_KM_COD
    AND SSKMD.SKMD_KHA_COD = PPJD.PPJD_KHA_COD
    AND SSKMD.SKMD_KBS_VER_ID = '60'
WHERE 
    PHJD.PHJD_KHA_COD = '20512'
    AND PHJD.PHJD_TAS_YDO = '2023'
    AND PHJD.PHJD_GHM_LV1_COD = '52'
    AND PHJD.PHJD_YSS_DTK_COD = '9'
    AND PHJD.PHJD_YSS_DTB_COD = '92'
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
