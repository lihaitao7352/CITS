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
=IF(COUNTIFS(A:A, A1, B:B, "<>"&B1)>0, "一对多", "一对一")


=IF(COUNTIF(A:A, A1) > 1, "N", "")
-----------------------------------------
SELECT
    KMID.KMID_KM_COD,
    KMID.KMID_TEK_STR_YM,
    KMID.KMID_TEK_END_YM,
    KMID.KMID_EBS_OBN,
    KMID.KMID_SIY_FLG,
    KMID.KMID_KM_KJM,
    PJHD.PJHD_PJ_COD,
    PJHD.PJHD_KM_COD,
    PJHD.PJHD_KM_TEK_STR_YM,
    PJHD.PJHD_KM_EBS_OBN,
    PJHD.PJHD_SIY_FLG,
    PJHD.PJHD_PJ_KJM
FROM 
    BVTA1_PJHD PJHD
INNER JOIN BVTA1_KMID KMID
    ON PJHD.PJHD_KM_COD = KMID.KMID_KM_COD
    AND PJHD.PJHD_KM_TEK_STR_YM = KMID.KMID_TEK_STR_YM
    AND PJHD.PJHD_KM_EBS_OBN = KMID.KMID_EBS_OBN
    AND PJHD.PJHD_KHA_COD = KMID.KMID_KHA_COD
WHERE PJHD.PJHD_KHA_COD =  '20512'
AND KMID.KMID_KHA_COD = '20512'
ORDER BY
    PJHD.PJHD_PJ_COD,
    PJHD.PJHD_KM_COD,
    PJHD.PJHD_KM_TEK_STR_YM,
    PJHD.PJHD_KM_EBS_OBN,
    PJHD.PJHD_PJ_KJM;
-------------------------------------------
SELECT
    K.KMID_KM_COD,
    K.KMID_TEK_STR_YM,
    K.KMID_TEK_END_YM,
    K.KMID_EBS_OBN,
    K.KMID_SIY_FLG,
    K.KMID_KM_KJM,
    P.PJHD_PJ_COD,
    P.PJHD_KM_COD,
    P.PJHD_KM_TEK_STR_YM,
    P.PJHD_KM_EBS_OBN,
    P.PJHD_SIY_FLG,
    P.PJHD_PJ_KJM
FROM 
    BVTA1_PJHD P
INNER JOIN BVTA1_KMID K
    ON P.PJHD_KM_COD = K.KMID_KM_COD
    AND P.PJHD_KM_TEK_STR_YM = K.KMID_TEK_STR_YM
    AND P.PJHD_KM_EBS_OBN = K.KMID_EBS_OBN
    AND P.PJHD_KHA_COD = K.KMID_KHA_COD
    AND P.PJHD_KHA_COD = '20512'
ORDER BY
    P.PJHD_PJ_COD,
    P.PJHD_KM_COD,
    P.PJHD_KM_TEK_STR_YM,
    P.PJHD_KM_EBS_OBN,
    P.PJHD_PJ_KJM;


了解了你的需求。你希望检查Excel中A列的每个值，查看它是否对应B列中多个不同的值。我们可以使用VBA编写一个脚本来实现这个功能，该脚本将检查A列中的每个值，并统计它对应的B列中不同值的数量，然后在C列中标记是否存在多种不同的B值。

以下是一个VBA脚本示例，你可以用来实现这个功能：

### 步骤 1: 打开VBA编辑器
1. 在Excel中，按下 `Alt + F11` 打开VBA编辑器。
2. 在VBA编辑器中，选择 `插入` -> `模块`，在弹出的窗口中插入一个新的模块。

### 步骤 2: 复制并粘贴以下代码
在新模块中粘贴以下代码：

```vba
Sub CheckMultipleEntries()
    Dim ws As Worksheet
    Dim lastRow As Long, i As Long
    Dim dict As Object
    Dim key As Variant
    Dim result As String
    
    ' 设定工作表
    Set ws = ThisWorkbook.Sheets("Sheet1")  ' 根据需要更改工作表名称
    
    ' 确定数据范围
    lastRow = ws.Cells(ws.Rows.Count, "A").End(xlUp).Row
    
    ' 清除之前的结果
    ws.Range("C1:C" & lastRow).ClearContents
    
    ' 创建字典以存储值及其不同的计数
    Set dict = CreateObject("Scripting.Dictionary")
    
    ' 遍历每一行
    For i = 1 To lastRow
        key = ws.Cells(i, 1).Value & "<>" & ws.Cells(i, 2).Value
        If Not dict.Exists(key) Then
            dict.Add key, Nothing
        End If
    Next i
    
    ' 再次遍历以标记结果
    For i = 1 To lastRow
        result = "单条"
        For Each key In dict.Keys
            If Left(key, Len(ws.Cells(i, 1).Value)) = ws.Cells(i, 1).Value Then
                If dict(key) Is Nothing Then
                    dict(key) = ws.Cells(i, 2).Value
                ElseIf dict(key) <> ws.Cells(i, 2).Value Then
                    result = "多条"
                    Exit For
                End If
            End If
        Next key
        ws.Cells(i, 3).Value = result
    Next i
    
    MsgBox "处理完成！"
End Sub
```

### 步骤 3: 运行脚本
- 回到Excel界面。
- 按下 `Alt + F8`，选择 `CheckMultipleEntries`，然后点击 `运行`。

这个脚本会检查A列中的每个值，并查找B列中是否存在多个不同的对应值，结果会在C列显示为“多条”或“单条”。

### 注意：
- 确保你的数据在"Sheet1"中，或者根据实际的工作表名称修改代码中的`ThisWorkbook.Sheets("Sheet1")`部分。
- 如果数据量非常大，此宏可能运行较慢，可以考虑优化或分批处理数据。
