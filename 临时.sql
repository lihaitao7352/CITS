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
