テプシスのプロジェクト予想・プロジェクト情報のプ想プロ情報＿業務種別＿コード(PPJD_GMS_COD)
が正しいかチェックしたいのですが。
チェックのSQLの作成をお願いします。

/*条件1.

【プロジェクト予想・プロジェクト情報】の「プ想プロ情報＿件名＿コード」(複数あり)一件に絞り
【件名予想・件名情報】の最新バージョン(指定)の「プ予想件名情報＿件名＿コード」とマッチングして
「プ想プロ情報＿業務種別＿コード」と「予想件名情報＿業務種別＿コード」に差異があるプロジェクトを抽出する。

取得項目
①会社コード
②所属コード
③プロジェクトコード
④件名コード
⑤業務種別コード
⑥着手日
⑦完了日

ソート
①②③④
*/
SELECT
    PPJD.PPJD_KHA_COD AS 会社コード,
    PPJD.PPJD_SZK_COD AS 所属コード,
    PPJD.PPJD_PJ_COD AS プロジェクトコード,
    PPJD.PPJD_KM_COD AS 件名コード,
    PPJD.PPJD_GMS_COD AS 業務種別コード,
    PPJD.PPJD_CKS_YMD AS 着手日,
    PPJD.PPJD_KRY_YMD AS 完了日
FROM
    BGTA3_PPJD PPJD
JOIN
    BGTA2_SKMD SKMD ON PPJD.PPJD_KM_COD = SKMD.SKMD_KM_COD
    AND SKMD.SKMD_KBS_VER_ID = (
        SELECT MAX(SKMD_KBS_VER_ID)
        FROM BGTA2_SKMD
        WHERE SKMD_KHA_COD = SKMD.SKMD_KHA_COD
          AND SKMD_KM_COD = SKMD.SKMD_KM_COD
    )
WHERE
    PPJD.PPJD_GMS_COD <> SKMD.SKMD_GMS_COD
ORDER BY
    PPJD.PPJD_KHA_COD,
    PPJD.PPJD_SZK_COD,
    PPJD.PPJD_PJ_COD,
    PPJD.PPJD_KM_COD;

/*条件2.

【プロジェクト予想・プロジェクト情報】のプ想プロ情報＿所属＿コードと
【組織属性定数(BVTB3_SSZD)】の最新の組織属性＿組織＿コードをマッチングし組織属性＿組織＿分類＿コードを取得する。
取得した「組織属性＿組織＿分類＿コード」と【契約区分定数(BVTG1_KKBD)】の「契約区分情報＿契約＿区分＿コード(9%)」の
「契約区分情報＿組織＿分類＿コード」とマッチングする。マッチングしなければエラーとする。
取得した「契約区分情報＿組織＿分類＿コード」と【業務種別定数(BVTG1_GMSD)】の「業務種別情報＿契約＿区分＿コード(GMSD_KEK_KBN_COD)」
とマッチングして「業務種別情報＿業務種別＿コード」を取得する。
取得した「業務種別情報＿業務種別＿コード」とプ【プロジェクト予想・プロジェクト情報】の「プ想プロ情報＿業務種別＿コード」を比較して
アンマッチのプロジェクトを抽出する。

取得項目
①会社コード
②所属コード
③プロジェクトコード
④プロジェクト予想・プロジェクト情報/業務種別コード　
⑤業務種別定数/業務種別コード
⑥着手日
⑦完了日

ソート
①②③
*/
WITH SSZD_NEW AS (
    SELECT DISTINCT
        SSZD.SSZD_SSI_COD, --組織属性_組織_コード
        SSZD.SSZD_SSI_BNR_COD --組織属性_組織_分類_コード
    FROM
        BVTB3_SSZD SSZD
    WHERE
        /* 組織属性定数テーブルの最新の日付を指定 */
),
KKBD_NEW AS (
    SELECT
        KKBD.KKBD_SSI_BNR_COD--契約区分情報_組織_分類_コード
    FROM
        BVTG1_KKBD KKBD
    WHERE
        KKBD.KKBD_KEK_KBN_COD  LIKE '9%' --契約区分情報_契約_区分_コード
)
SELECT
    PPJD.PPJD_KHA_COD,
    PPJD.PPJD_SZK_COD,
    PPJD.PPJD_PJ_COD,
    PPJD.PPJD_GMS_COD AS プロジェクト情報業務種別コード,
    GMSD.GMSD_GMS_COD AS 業務種別定数業務種別コード,
    PPJD.PPJD_CKS_YMD,
    PPJD.PPJD_KRY_YMD
FROM
    BGTA3_PPJD PPJD
JOIN
    SSZD_NEW SN ON PPJD.PPJD_SZK_COD = SN.SSZD_SSI_COD
JOIN
    KKBD_NEW KM ON SN.SSZD_SSI_BNR_COD = KN.KKBD_SSI_BNR_COD
JOIN
    BVTG1_GMSD GMSD ON GMSD.GMSD_KEK_KBN_COD = KN.KKBD_SSI_BNR_COD
WHERE
    PPJD.PPJD_GMS_COD <> GMSD.GMSD_GMS_COD
ORDER BY
    PPJD.PPJD_KHA_COD,
    PPJD.PPJD_SZK_COD,
    PPJD.PPJD_PJ_COD;
/*条件3.
【プロジェクト予想・プロジェクト情報】の「プ想プロ情報＿プロジェクト＿コード」と
【プロジェクト情報（カレント）】の「プロカレント＿プロジェクト＿コード」をマッチングし
「プ想プロ情報＿業務種別＿コード」と「プロカレント＿業務種別＿コード」に差異があるプロジェクトを抽出する。

取得項目
①会社コード
②所属コード
③プロジェクトコード
④プロジェクト予想・プロジェクト情報/業務種別コード　
⑤プロジェクト情報（カレント）/業務種別コード
⑥着手日
⑦完了日

ソート

①②③
どちらかの一方にある場合は差異とする。
*/
SELECT
    a.会社コード,
    a.所属コード,
    a.プロジェクトコード,
    a.プ想プロ情報_業務種別_コード AS 予想業務種別コード,
    b.プロカレント_業務種別_コード AS 現在業務種別コード,
    a.着手日,
    a.完了日
FROM
    プロジェクト予想・プロジェクト情報 a
JOIN
    プロジェクト情報（カレント） b ON a.プ想プロ情報_プロジェクト_コード = b.プロカレント_プロジェクト_コード
WHERE
    a.プ想プロ情報_業務種別_コード != b.プロカレント_業務種別_コード
ORDER BY
    a.会社コード, a.所属コード, a.プロジェクトコード;
