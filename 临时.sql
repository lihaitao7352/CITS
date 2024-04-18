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



在Excel中，如果你想要判断一个列中的某个数据对应另一个列中有多条不同的数据，你可以使用组合函数如COUNTIFS和SUMPRODUCT来实现这一功能。这里有两种方法可以实现你的需求：

方法1: 使用 COUNTIFS 函数
你可以使用COUNTIFS函数来统计每个唯一数据在第二列中出现的次数。这个方法需要额外的列来帮助计算。

假设你有两列数据：列A（数据列）和列B（对应列），你可以在列C中设置以下公式来计算：

在C1中输入公式，并向下拖动以填充其他单元格：

excel
Copy code
=COUNTIFS(A:A, A1, B:B, B1)
这个公式计算列A中与A1相同的所有数据中，列B对应值为B1的次数。

然后，你可以使用以下公式在列D中找到列A中相同数据对应列B的不同数据数量：

excel
Copy code
=IF(A1=A2, "", SUMPRODUCT((A$1:A$100=A1)/COUNTIFS(A$1:A$100, A$1:A$100, B$1:B$100, B$1:B$100)))
这个公式会在每个数据组的开始处显示不同的数据总数，其他相同的数据处则不显示任何内容。

方法2: 使用 SUMPRODUCT 函数
