Sub CheckMultipleEntriesBatch()
    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets("Sheet1")  ' シート名が正しいことを確認してください
    Dim lastRow As Long
    lastRow = ws.Cells(ws.Rows.Count, "D").End(xlUp).Row  ' データがD列にあると仮定
    
    ' バッチ処理パラメータの設定
    Dim batchSize As Long
    Dim startRow As Long, endRow As Long, batch As Long
    
    batchSize = 10000  ' 1バッチあたりの行数、必要に応じて調整
    
    ' 処理速度を速めるために一部の機能を無効化
    Application.ScreenUpdating = False
    Application.Calculation = xlCalculationManual
    Application.EnableEvents = False
    
    ' データをバッチ処理
    For startRow = 1 To lastRow Step batchSize
        endRow = startRow + batchSize - 1
        If endRow > lastRow Then endRow = lastRow
        ProcessBatch ws, startRow, endRow
    Next startRow
    
    ' Excelの機能を再度有効にする
    Application.ScreenUpdating = True
    Application.Calculation = xlCalculationAutomatic
    Application.EnableEvents = True
    
    MsgBox "処理が完了しました！"
End Sub

Sub ProcessBatch(ws As Worksheet, startRow As Long, endRow As Long)
    Dim i As Long, j As Long
    Dim dict As Object
    Dim key As Variant
    
    For i = startRow To endRow
        Set dict = CreateObject("Scripting.Dictionary")
        For j = startRow To endRow
            If ws.Cells(j, 4).Value = ws.Cells(i, 4).Value Then  ' AデータがD列にあると仮定
                dict(ws.Cells(j, 5).Value) = 1  ' BデータがE列にあると仮定
            End If
        Next j
        
        ' 複数の異なる値に対応しているか判断
        If dict.Count > 1 Then
            ws.Cells(i, 26).Value = "多条"  ' 結果をZ列に出力
        Else
            ws.Cells(i, 26).Value = "単条"
        End If
    Next i
End Sub
---------------
=IF(COUNTIF(FILTER(B:B, A:A=A1)) > 1, "多条", "单条")

---------------------
=1/COUNTIFS(A:A, A1, B:B, B1)
=IF(SUMIF(A:A, A1, C:C) > 1, "多条", "单条")

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
CASE WHEN COUNT(*) OVER (PARTITION BY KKMID_KM_COD) = 1
ELSE ROW_NUMBER() OVER (PARTITON BY KKMID_KM_COD ORDER BY P.PJHD_PJ_COD) 
END AS rownum
FROM (
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
    )
