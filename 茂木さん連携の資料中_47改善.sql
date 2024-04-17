--sql1
SELECT PHJD.PHJD_KHA_COD AS KHA_COD
      ,SKMD.SKMD_SZK_COD AS SZK_COD
      ,PHJD.PHJD_KM_COD AS KM_COD
      ,PHJD.PHJD_TAS_YDO AS TAS_YDO
      ,PPJD.PPJD_KM_COD AS IRS_KM_COD
      ,SSKMD.SKMD_SZK_COD AS IRS_SZK_COD
      ,SUM(NVL(PHJD.PHJD_4M_JSC, 0) ) AS JSC_4M
      ,SUM(NVL(PHJD.PHJD_5M_JSC, 0) ) AS JSC_5M
      ,SUM(NVL(PHJD.PHJD_6M_JSC, 0) ) AS JSC_6M
      ,SUM(NVL(PHJD.PHJD_7M_JSC, 0) ) AS JSC_7M
      ,SUM(NVL(PHJD.PHJD_8M_JSC, 0) ) AS JSC_8M
      ,SUM(NVL(PHJD.PHJD_9M_JSC, 0) ) AS JSC_9M
      ,SUM(NVL(PHJD.PHJD_10M_JSC, 0) ) AS JSC_10M
      ,SUM(NVL(PHJD.PHJD_11M_JSC, 0) ) AS JSC_11M
      ,SUM(NVL(PHJD.PHJD_12M_JSC, 0) ) AS JSC_12M
      ,SUM(NVL(PHJD.PHJD_1M_JSC, 0) ) AS JSC_1M
      ,SUM(NVL(PHJD.PHJD_2M_JSC, 0) ) AS JSC_2M
      ,SUM(NVL(PHJD.PHJD_3M_JSC, 0) ) AS JSC_3M
  FROM BGTA2_PHJD PHJD
 INNER JOIN BGTA3_PPJD PPJD ON PPJD.PPJD_KHA_COD = PHJD.PHJD_KHA_COD
   AND PPJD.PPJD_PJ_COD = PHJD.PHJD_IRS_PJ_COD
   AND PPJD.PPJD_IRM_PJ_COD = PHJD.PHJD_PJ_COD
 INNER JOIN BGTA2_SKMD SSKMD ON SSKMD.SKMD_KHA_COD = PPJD.PPJD_KHA_COD
   AND SSKMD.SKMD_KBS_VER_ID = '60'
   AND SSKMD.SKMD_KM_COD = PPJD.PPJD_KM_COD
 INNER JOIN BGTAZ_PTCD PTCD ON PTCD.PTCD_KHA_COD = PHJD.PHJD_KHA_COD
   AND PTCD.PTCD_PJ_COD = PHJD.PHJD_PJ_COD
 INNER JOIN BGTA2_SKMD SKMD ON SKMD.SKMD_KHA_COD = PHJD.PHJD_KHA_COD
   AND SKMD.SKMD_KBS_VER_ID = '60'
   AND SKMD.SKMD_KM_COD = PHJD.PHJD_KM_COD
 WHERE PHJD.PHJD_KHA_COD = '20512'
   AND PHJD.PHJD_TAS_YDO BETWEEN '2023'AND '2023'
   AND PHJD.PHJD_GHM_LV1_COD = '52'
   AND PHJD.PHJD_YSS_DTK_COD = '9'
   AND PHJD.PHJD_YSS_DTB_COD = '92'
 GROUP BY PHJD.PHJD_KHA_COD
         ,SKMD.SKMD_SZK_COD
         ,PHJD.PHJD_KM_COD
         ,PHJD.PHJD_TAS_YDO
         ,PPJD.PPJD_KM_COD
         ,SSKMD.SKMD_SZK_COD
 ORDER BY PHJD.PHJD_KHA_COD
         ,SKMD.SKMD_SZK_COD
         ,PHJD.PHJD_KM_COD
         ,PHJD.PHJD_TAS_YDO

--sql2
SELECT A.KHA_COD
      ,A.SZK_COD
      ,A.KM_COD
      ,A.TAS_YDO
      ,A.IRS_KM_COD
      ,B.IRS_SZK_COD
      ,SUM(A.JSC_04M) AS JSC_04M
      ,SUM(A.JSC_05M) AS JSC_05M
      ,SUM(A.JSC_06M) AS JSC_06M
      ,SUM(A.JSC_07M) AS JSC_07M
      ,SUM(A.JSC_08M) AS JSC_08M
      ,SUM(A.JSC_09M) AS JSC_09M
      ,SUM(A.JSC_10M) AS JSC_10M
      ,SUM(A.JSC_11M) AS JSC_11M
      ,SUM(A.JSC_12M) AS JSC_12M
      ,SUM(A.JSC_01M) AS JSC_01M
      ,SUM(A.JSC_02M) AS JSC_02M
      ,SUM(A.JSC_03M) AS JSC_03M
  FROM (SELECT PHJD.PHJD_KHA_COD AS KHA_COD
              ,SKMD.SKMD_SZK_COD AS SZK_COD
              ,PHJD.PHJD_KM_COD  AS KM_COD
              ,PHJD.PHJD_TAS_YDO AS TAS_YDO
              ,PPJD.PPJD_KM_COD  AS IRS_KM_COD
              ,NVL(PHJD.PHJD_4M_JSC , 0) AS JSC_04M
              ,NVL(PHJD.PHJD_5M_JSC , 0) AS JSC_05M
              ,NVL(PHJD.PHJD_6M_JSC , 0) AS JSC_06M
              ,NVL(PHJD.PHJD_7M_JSC , 0) AS JSC_07M
              ,NVL(PHJD.PHJD_8M_JSC , 0) AS JSC_08M
              ,NVL(PHJD.PHJD_9M_JSC , 0) AS JSC_09M
              ,NVL(PHJD.PHJD_10M_JSC, 0) AS JSC_10M
              ,NVL(PHJD.PHJD_11M_JSC, 0) AS JSC_11M
              ,NVL(PHJD.PHJD_12M_JSC, 0) AS JSC_12M
              ,NVL(PHJD.PHJD_1M_JSC , 0) AS JSC_01M
              ,NVL(PHJD.PHJD_2M_JSC , 0) AS JSC_02M
              ,NVL(PHJD.PHJD_3M_JSC , 0) AS JSC_03M
          FROM BGTA2_PHJD PHJD
              ,(SELECT PPJD_KHA_COD
                      ,PPJD_KM_COD
                      ,PPJD_PJ_COD
                      ,PPJD_IRM_PJ_COD
                  FROM BGTA3_PPJD
                 WHERE PPJD_KHA_COD = '20512'
                   AND PPJD_IRM_PJ_COD IS NOT NULL) PPJD
              ,(SELECT SKMD_KHA_COD
                      ,SKMD_KM_COD
                      ,SKMD_SZK_COD
                 FROM BGTA2_SKMD SKMD
                 WHERE SKMD_KHA_COD    = '20512'
                   AND SKMD_KBS_VER_ID = 60) SKMD
         WHERE PHJD.PHJD_KHA_COD     = '20512'
           AND PHJD.PHJD_IRS_PJ_COD IS NOT NULL
           AND PHJD.PHJD_TAS_YDO BETWEEN '2023'AND '2023'
           AND PHJD.PHJD_YSS_DTK_COD = '9'
           AND PHJD.PHJD_YSS_DTB_COD = '92'
           AND PHJD.PHJD_GHM_LV1_COD = '52'

           AND EXISTS(SELECT 1 FROM BGTAZ_PTCD PTCD
                       WHERE PHJD.PHJD_KHA_COD     = PTCD.PTCD_KHA_COD
                         AND PHJD.PHJD_PJ_COD      = PTCD.PTCD_PJ_COD)

           AND PHJD.PHJD_KHA_COD     = PPJD.PPJD_KHA_COD
           AND PHJD.PHJD_IRS_PJ_COD  = PPJD.PPJD_PJ_COD
           AND PHJD.PHJD_PJ_COD      = PPJD.PPJD_IRM_PJ_COD

           AND PHJD.PHJD_KHA_COD     = SKMD.SKMD_KHA_COD
           AND PHJD.PHJD_KM_COD      = SKMD.SKMD_KM_COD) A

      ,(SELECT SSKMD.SKMD_KHA_COD AS KHA_COD
              ,SSKMD.SKMD_KM_COD  AS KM_COD
              ,SSKMD.SKMD_SZK_COD AS IRS_SZK_COD
          FROM BGTA2_SKMD SSKMD
         WHERE SSKMD.SKMD_KHA_COD    = '20512'
           AND SSKMD.SKMD_KBS_VER_ID = 60) B
 WHERE A.KHA_COD                     = B.KHA_COD
   AND A.IRS_KM_COD                  = B.KM_COD
 GROUP BY A.KHA_COD
         ,A.SZK_COD
         ,A.KM_COD
         ,A.TAS_YDO
         ,A.IRS_KM_COD
         ,B.IRS_SZK_COD
 ORDER BY A.KHA_COD
         ,A.SZK_COD
         ,A.KM_COD
         ,A.TAS_YDO;

--With
WITH SubQuery_PPJD AS (
    SELECT PPJD_KHA_COD, PPJD_KM_COD, PPJD_PJ_COD, PPJD_IRM_PJ_COD
    FROM BGTA3_PPJD
    WHERE PPJD_KHA_COD = '20512'
      AND PPJD_IRM_PJ_COD IS NOT NULL
),
SubQuery_SKMD AS (
    SELECT SKMD_KHA_COD, SKMD_KM_COD, SKMD_SZK_COD
    FROM BGTA2_SKMD
    WHERE SKMD_KHA_COD = '20512'
      AND SKMD_KBS_VER_ID = 60
),
FinalData AS (
    SELECT PHJD.PHJD_KHA_COD AS KHA_COD,
           SKMD.SKMD_SZK_COD AS SZK_COD,
           PHJD.PHJD_KM_COD AS KM_COD,
           PHJD.PHJD_TAS_YDO AS TAS_YDO,
           PPJD.PPJD_KM_COD AS IRS_KM_COD,
           NVL(PHJD.PHJD_4M_JSC, 0) AS JSC_04M,
           NVL(PHJD.PHJD_5M_JSC, 0) AS JSC_05M,
           NVL(PHJD.PHJD_6M_JSC, 0) AS JSC_06M,
           NVL(PHJD.PHJD_7M_JSC, 0) AS JSC_07M,
           NVL(PHJD.PHJD_8M_JSC, 0) AS JSC_08M,
           NVL(PHJD.PHJD_9M_JSC, 0) AS JSC_09M,
           NVL(PHJD.PHJD_10M_JSC, 0) AS JSC_10M,
           NVL(PHJD.PHJD_11M_JSC, 0) AS JSC_11M,
           NVL(PHJD.PHJD_12M_JSC, 0) AS JSC_12M,
           NVL(PHJD.PHJD_1M_JSC, 0) AS JSC_01M,
           NVL(PHJD.PHJD_2M_JSC, 0) AS JSC_02M,
           NVL(PHJD.PHJD_3M_JSC, 0) AS JSC_03M
    FROM BGTA2_PHJD PHJD
    JOIN SubQuery_PPJD PPJD ON PHJD.PHJD_KHA_COD = PPJD.PPJD_KHA_COD
                            AND PHJD.PHJD_IRS_PJ_COD = PPJD.PPJD_PJ_COD
                            AND PHJD.PHJD_PJ_COD = PPJD.PPJD_IRM_PJ_COD
    JOIN SubQuery_SKMD SKMD ON PHJD.PHJD_KHA_COD = SKMD.SKMD_KHA_COD
                            AND PHJD.PHJD_KM_COD = SKMD.SKMD_KM_COD
    WHERE PHJD.PHJD_KHA_COD = '20512'
      AND PHJD.PHJD_TAS_YDO BETWEEN '2023'AND '2023'
      AND PHJD.PHJD_YSS_DTK_COD = '9'
      AND PHJD.PHJD_YSS_DTB_COD = '92'
      AND PHJD.PHJD_GHM_LV1_COD = '52'
),
IRSData AS (
    SELECT SKMD_KHA_COD AS KHA_COD,
           SKMD_KM_COD AS KM_COD,
           SKMD_SZK_COD AS IRS_SZK_COD
    FROM BGTA2_SKMD
    WHERE SKMD_KHA_COD = '20512'
      AND SKMD_KBS_VER_ID = 60
)
SELECT A.KHA_COD, A.SZK_COD, A.KM_COD, A.TAS_YDO, A.IRS_KM_COD, B.IRS_SZK_COD,
       SUM(A.JSC_04M) AS JSC_04M,
       SUM(A.JSC_05M) AS JSC_05M,
       SUM(A.JSC_06M) AS JSC_06M,
       SUM(A.JSC_07M) AS JSC_07M,
       SUM(A.JSC_08M) AS JSC_08M,
       SUM(A.JSC_09M) AS JSC_09M,
       SUM(A.JSC_10M) AS JSC_10M,
       SUM(A.JSC_11M) AS JSC_11M,
       SUM(A.JSC_12M) AS JSC_12M,
       SUM(A.JSC_01M) AS JSC_01M,
       SUM(A.JSC_02M) AS JSC_02M,
       SUM(A.JSC_03M) AS JSC_03M
FROM FinalData A
JOIN IRSData B ON A.KHA_COD = B.KHA_COD AND A.IRS_KM_COD = B.KM_COD
GROUP BY A.KHA_COD, A.SZK_COD, A.KM_COD, A.TAS_YDO, A.IRS_KM_COD, B.IRS_SZK_COD
ORDER BY A.KHA_COD, A.SZK_COD, A.KM_COD, A.TAS_YDO;
--
PPJD_IRM_SZK_COD※Indexなし
PPJD_IRM_PJ_COD※Indexなし
<WHERE>
PPJD_SNI_TRH_KBN※Indexなし

