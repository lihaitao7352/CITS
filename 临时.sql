SELECT 
PJHD.PJHD_PJ_COD
,PJHD.PJHD_KM_COD
,PJHD.PJHD_KM_TEK_STR_YM
,PJHD.PJHD_KM_EBS_OBN
,PJHD.PJHD_PJ_KJM
FROM 
BVTA1_PJHD PJHD
INNER JOIN BVTA1_KMID KMID
ON PJHD.PJHD_KM_COD = KMID.KMID_KM_COD
AND PJHD.PJHD_KM_TEK_STR_YM = KMID_TEK_STR_YM
AND PJHD.PJHD_KM_EBS_OBN = KMID_EBS_OBN
ORDER BY
PJHD.PJHD_PJ_COD
,PJHD.PJHD_KM_COD
,PJHD.PJHD_KM_TEK_STR_YM
,PJHD.PJHD_KM_EBS_OBN
,PJHD.PJHD_PJ_KJM
--
SELECT 
    PJHD.PJHD_PJ_COD,
    PJHD.PJHD_KM_COD,
    PJHD.PJHD_KM_TEK_STR_YM,
    PJHD.PJHD_KM_EBS_OBN,
    PJHD.PJHD_PJ_KJM
FROM 
    BVTA1_PJHD PJHD
INNER JOIN BVTA1_KMID KMID
    ON PJHD.PJHD_KM_COD = KMID.KMID_KM_COD
    AND PJHD.PJHD_KM_TEK_STR_YM = KMID.KMID_TEK_STR_YM
    AND PJHD.PJHD_KM_EBS_OBN = KMID.KMID_EBS_OBN
ORDER BY
    PJHD.PJHD_PJ_COD,
    PJHD.PJHD_KM_COD,
    PJHD.PJHD_KM_TEK_STR_YM,
    PJHD.PJHD_KM_EBS_OBN,
    PJHD.PJHD_PJ_KJM;
