<?xml version="1.0" encoding="UTF-8"?>

<!--
  本資料には、東京電力株式会社またはその他の企業の秘密情報が含まれている
  可能性があります。当社の許可なく本資料の複製物を作成すること、本資料の
  内容を本来の目的以外に使用すること、ならびに第三者に開示、公開する行為
  を禁止します。                                東京電力株式会社 2010.09.16

  サブシステム名：

  ver1.0   
-->

<!DOCTYPE system-config SYSTEM "dtd/bean-config.dtd">

<bean-config>

    <!-- APFW バッチ処理用データソース定義 -->
    <bean name="BatchDataSource" class="jp.co.tepco.rv.batch.integration.BatchDataSource">

    <!-- Confirm ここから 実行環境に応じて変更すること -->
        <!-- JDBCドライバクラス名（完全修飾名） -->
        <property name="driverClassName" value="oracle.jdbc.OracleDriver"/>
        <!-- 接続URL -->
        <property name="url" value="jdbc:oracle:thin:@bxscrdb01:10032/BX01"/>
        <!-- 接続ユーザー名 -->
        <property name="user" value="BXGAP02"/>
        <!-- 接続ユーザーのパスワード -->
        <property name="password" value="pega3S00"/>
        <!-- DBMS名称（Oracle|DB2） -->
        <property name="DbmsName" value="Oracle"/>
        <!-- Confirm ここまで -->
        <!-- 自動コミット設定（変更不可） -->
        <property name="autoCommit" value="false"/>
        <!-- 自動切断設定（変更不可） -->
        <property name="autoClose" value="false"/>
    </bean>

    <!-- Webサービス連携 -->
    <bean name="DefaultESBSendSOAPHandler"
      class="jp.co.tepco.ifit.fw.service.jaxws.handler.ESBSendSOAPHandler">
      <!-- ESB連携ヘッダのバージョン項目 -->
      <property name="version" value="1" />
      <!-- ESB連携ヘッダの自システムID項目 -->
      <property name="requesterSystemId" value="B_X" />
    </bean>

    <!-- お知らせメッセージサービスの設定 -->
    <bean name="BX_01"
        class="jp.co.tepco.ifit.fw.common.bean.factory.JaxWsWebServiceEndpointFactory">
      <!-- サービスのエンドポイントアドレスに対する設定 -->
      <property name="wsdlLocation" value="file:C:/workspace_G85/G_BGOnYosanGenka/BGOnYosanGenka/keiri/B3/config/wsdl/Wbxa3a1OshiraseMessageService.wsdl" />
      <property name="namespace" value="http://wsi.on.a1.a3.bx.tepco.co.jp/" />
      <property name="serviceName" value="Wbxa3a1OshiraseMessageService" />
      <property name="remoteInterface" value="jp.co.tepco.bx.a3.a1.on.wsi.Wbxa3a1OshiraseMessage" />
      <property name="enhancements" expression="new Object[]{#DefaultESBSendSOAPHandler, #BasicAuthSettings}"/>
    </bean>

    <!-- 経理データ配信サービスの設定 -->
    <bean name="BX_02"
        class="jp.co.tepco.ifit.fw.common.bean.factory.JaxWsWebServiceEndpointFactory">
      <!-- サービスのエンドポイントアドレスに対する設定 -->
      <property name="wsdlLocation" value="file:C:/workspace_G85/G_BGOnYosanGenka/BGOnYosanGenka/keiri/B3/config/wsdl/Wbxa3a1RenkeiInfoService.wsdl" />
      <property name="namespace" value="http://wsi.on.a1.a3.bx.tepco.co.jp/" />
      <property name="serviceName" value="Wbxa3a1RenkeiInfoService" />
      <property name="remoteInterface" value="jp.co.tepco.bx.a3.a1.on.wsi.Wbxa3a1RenkeiInfo" />
      <property name="enhancements" expression="new Object[]{#DefaultESBSendSOAPHandler, #BasicAuthSettings}"/>
    </bean>

    <!-- 稼働日判定サービスの設定 -->
    <bean name="BX_03"
        class="jp.co.tepco.ifit.fw.common.bean.factory.JaxWsWebServiceEndpointFactory">
      <!-- サービスのエンドポイントアドレスに対する設定 -->
      <property name="wsdlLocation" value="file:C:/workspace_G85/G_BGOnYosanGenka/BGOnYosanGenka/keiri/B3/config/wsdl/Wbxa5a1JudgeKadobiService.wsdl" />
      <property name="namespace" value="http://wsi.on.a1.a5.bx.tepco.co.jp/" />
      <property name="serviceName" value="Wbxa5a1JudgeKadobiService" />
      <property name="remoteInterface" value="jp.co.tepco.bx.a5.a1.on.wsi.Wbxa5a1JudgeKadobi" />
      <property name="enhancements" expression="new Object[]{#DefaultESBSendSOAPHandler, #BasicAuthSettings}"/>
    </bean>

    <!-- PDF同期帳票作成サービスの設定 -->
    <bean name="SynchronizationReportPDF"
      class="jp.co.tepco.ifit.fw.common.bean.factory.JaxWsWebServiceEndpointFactory">
      <property name="wsdlLocation" value="file:C:/workspace_G85/G_BGOnYosanGenka/BGOnYosanGenka/keiri/B3/config/wsdl/S1_1001O_S1ReportPDFSynService.wsdl" />
      <property name="portName" value="S1ReportPDFSynPort" />
      <property name="namespace" value="http://wsi.on.cz.sc.s1.tepco.co.jp/" />
      <property name="serviceName" value="S1ReportPDFSynService" />
      <property name="remoteInterface" value="jp.co.tepco.s1.sc.cz.on.wsi.S1ReportPDFSyn" />
      <property name="enhancements" expression="new Object[]{#DefaultESBSendSOAPHandler, #BasicAuthSettings}"/>
    </bean>

    <!-- Excel同期帳票作成サービスの設定 -->
    <bean name="SynchronizationReportExcel"
      class="jp.co.tepco.ifit.fw.common.bean.factory.JaxWsWebServiceEndpointFactory">
      <property name="wsdlLocation" value="file:C:/workspace_G85/G_BGOnYosanGenka/BGOnYosanGenka/keiri/B3/config/wsdl/S1_0901O_S1ReportExcelSynService.wsdl" />
      <property name="portName" value="S1ReportExcelSynPort" />
      <property name="namespace" value="http://wsi.on.ca.sc.s1.tepco.co.jp/" />
      <property name="serviceName" value="S1ReportExcelSynService" />
      <property name="remoteInterface" value="jp.co.tepco.s1.sc.ca.on.wsi.S1ReportExcelSyn" />
      <property name="enhancements" expression="new Object[]{#DefaultESBSendSOAPHandler, #BasicAuthSettings}"/>
    </bean>

    <!-- PDF非同期帳票作成サービスの設定 -->
    <bean name="NonSynchronizationReportPDF"
      class="jp.co.tepco.ifit.fw.common.bean.factory.JaxWsWebServiceEndpointFactory">
      <property name="wsdlLocation" value="file:C:/workspace_G85/G_BGOnYosanGenka/BGOnYosanGenka/keiri/B3/config/wsdl/S1_0201-S1_0801O_S1ReportApplyService.wsdl" />
      <property name="portName" value="S1ReportApplyPort" />
      <property name="namespace" value="http://wsi.on.cy.sc.s1.tepco.co.jp/" />
      <property name="serviceName" value="S1ReportApplyService" />
      <property name="remoteInterface" value="jp.co.tepco.s1.sc.cy.on.wsi.S1ReportApply" />
      <property name="enhancements" expression="new Object[]{#DefaultESBSendSOAPHandler, #BasicAuthSettings}"/>
    </bean>

    <!-- Excel非同期帳票作成サービスの設定 -->
    <bean name="NonSynchronizationReportExcel"
      class="jp.co.tepco.ifit.fw.common.bean.factory.JaxWsWebServiceEndpointFactory">
      <property name="wsdlLocation" value="file:C:/workspace_G85/G_BGOnYosanGenka/BGOnYosanGenka/keiri/B3/config/wsdl/S1_0201-S1_0801O_S1ReportApplyService.wsdl" />
      <property name="portName" value="S1ReportApplyPort" />
      <property name="namespace" value="http://wsi.on.cy.sc.s1.tepco.co.jp/" />
      <property name="serviceName" value="S1ReportApplyService" />
      <property name="remoteInterface" value="jp.co.tepco.s1.sc.cy.on.wsi.S1ReportApply" />
      <property name="enhancements" expression="new Object[]{#DefaultESBSendSOAPHandler, #BasicAuthSettings}"/>
    </bean>

    <!-- 帳票検索サービスの設定 -->
    <bean name="SearchReport"
      class="jp.co.tepco.ifit.fw.common.bean.factory.JaxWsWebServiceEndpointFactory">
      <property name="wsdlLocation" value="file:C:/workspace_G85/G_BGOnYosanGenka/BGOnYosanGenka/keiri/B3/config/wsdl/S1_0201-S1_0801O_S1ReportApplyService.wsdl" />
      <property name="portName" value="S1ReportApplyPort" />
      <property name="namespace" value="http://wsi.on.cy.sc.s1.tepco.co.jp/" />
      <property name="serviceName" value="S1ReportApplyService" />
      <property name="remoteInterface" value="jp.co.tepco.s1.sc.cy.on.wsi.S1ReportApply" />
      <property name="enhancements" expression="new Object[]{#DefaultESBSendSOAPHandler, #BasicAuthSettings}"/>
    </bean>

    <!-- 帳票取得サービスの設定 -->
    <bean name="GetReport"
      class="jp.co.tepco.ifit.fw.common.bean.factory.JaxWsWebServiceEndpointFactory">
      <property name="wsdlLocation" value="file:C:/workspace_G85/G_BGOnYosanGenka/BGOnYosanGenka/keiri/B3/config/wsdl/S1_0201-S1_0801O_S1ReportApplyService.wsdl" />
      <property name="portName" value="S1ReportApplyPort" />
      <property name="namespace" value="http://wsi.on.cy.sc.s1.tepco.co.jp/" />
      <property name="serviceName" value="S1ReportApplyService" />
      <property name="remoteInterface" value="jp.co.tepco.s1.sc.cy.on.wsi.S1ReportApply" />
      <property name="enhancements" expression="new Object[]{#DefaultESBSendSOAPHandler, #BasicAuthSettings}"/>
    </bean>

    <!-- 新規申請登録サービスの設定 -->
    <bean name="RegistItem"
      class="jp.co.tepco.ifit.fw.common.bean.factory.JaxWsWebServiceEndpointFactory">
      <property name="wsdlLocation" value="file:C:/workspace_G85/G_BGOnYosanGenka/BGOnYosanGenka/keiri/B3/config/wsdl/S1_1101-S1_2701O_S1WorkflowService.wsdl" />
      <property name="portName" value="S1WorkflowPort" />
      <property name="namespace" value="http://wsi.on.ez.se.s1.tepco.co.jp/" />
      <property name="serviceName" value="S1WorkflowService" />
      <property name="remoteInterface" value="jp.co.tepco.s1.se.ez.on.wsi.S1Workflow" />
      <property name="enhancements" expression="new Object[]{#DefaultESBSendSOAPHandler, #BasicAuthSettings}"/>
    </bean>

    <!-- 案件承認サービスの設定 -->
    <bean name="ApproveItem"
      class="jp.co.tepco.ifit.fw.common.bean.factory.JaxWsWebServiceEndpointFactory">
      <property name="wsdlLocation" value="file:C:/workspace_G85/G_BGOnYosanGenka/BGOnYosanGenka/keiri/B3/config/wsdl/S1_1101-S1_2701O_S1WorkflowService.wsdl" />
      <property name="portName" value="S1WorkflowPort" />
      <property name="namespace" value="http://wsi.on.ez.se.s1.tepco.co.jp/" />
      <property name="serviceName" value="S1WorkflowService" />
      <property name="remoteInterface" value="jp.co.tepco.s1.se.ez.on.wsi.S1Workflow" />
      <property name="enhancements" expression="new Object[]{#DefaultESBSendSOAPHandler, #BasicAuthSettings}"/>
    </bean>

    <!-- 案件差戻しサービスの設定 -->
    <bean name="ReturnItem"
      class="jp.co.tepco.ifit.fw.common.bean.factory.JaxWsWebServiceEndpointFactory">
      <property name="wsdlLocation" value="file:C:/workspace_G85/G_BGOnYosanGenka/BGOnYosanGenka/keiri/B3/config/wsdl/S1_1101-S1_2701O_S1WorkflowService.wsdl" />
      <property name="portName" value="S1WorkflowPort" />
      <property name="namespace" value="http://wsi.on.ez.se.s1.tepco.co.jp/" />
      <property name="serviceName" value="S1WorkflowService" />
      <property name="remoteInterface" value="jp.co.tepco.s1.se.ez.on.wsi.S1Workflow" />
      <property name="enhancements" expression="new Object[]{#DefaultESBSendSOAPHandler, #BasicAuthSettings}"/>
    </bean>

    <!-- 案件廃案サービスの設定 -->
    <bean name="DestroyItem"
      class="jp.co.tepco.ifit.fw.common.bean.factory.JaxWsWebServiceEndpointFactory">
      <property name="wsdlLocation" value="file:C:/workspace_G85/G_BGOnYosanGenka/BGOnYosanGenka/keiri/B3/config/wsdl/S1_1101-S1_2701O_S1WorkflowService.wsdl" />
      <property name="portName" value="S1WorkflowPort" />
      <property name="namespace" value="http://wsi.on.ez.se.s1.tepco.co.jp/" />
      <property name="serviceName" value="S1WorkflowService" />
      <property name="remoteInterface" value="jp.co.tepco.s1.se.ez.on.wsi.S1Workflow" />
      <property name="enhancements" expression="new Object[]{#DefaultESBSendSOAPHandler, #BasicAuthSettings}"/>
    </bean>

    <!-- 新規申請登録(一括)サービスの設定 -->
    <bean name="BulkRegistItem"
      class="jp.co.tepco.ifit.fw.common.bean.factory.JaxWsWebServiceEndpointFactory">
      <property name="wsdlLocation" value="file:C:/workspace_G85/G_BGOnYosanGenka/BGOnYosanGenka/keiri/B3/config/wsdl/S1_6B01-S1_6E01O_S1WorkflowBulkService.wsdl" />
      <property name="portName" value="S1WorkflowBulkPort" />
      <property name="namespace" value="http://wsi.on.ey.se.s1.tepco.co.jp/" />
      <property name="serviceName" value="S1WorkflowBulkService" />
      <property name="remoteInterface" value="jp.co.tepco.s1.se.ey.on.wsi.S1WorkflowBulk" />
      <property name="enhancements" expression="new Object[]{#DefaultESBSendSOAPHandler, #BasicAuthSettings}"/>
    </bean>

    <!-- 案件承認(一括)サービスの設定 -->
    <bean name="BulkApproveItem"
      class="jp.co.tepco.ifit.fw.common.bean.factory.JaxWsWebServiceEndpointFactory">
      <property name="wsdlLocation" value="file:C:/workspace_G85/G_BGOnYosanGenka/BGOnYosanGenka/keiri/B3/config/wsdl/S1_6B01-S1_6E01O_S1WorkflowBulkService.wsdl" />
      <property name="portName" value="S1WorkflowBulkPort" />
      <property name="namespace" value="http://wsi.on.ey.se.s1.tepco.co.jp/" />
      <property name="serviceName" value="S1WorkflowBulkService" />
      <property name="remoteInterface" value="jp.co.tepco.s1.se.ey.on.wsi.S1WorkflowBulk" />
      <property name="enhancements" expression="new Object[]{#DefaultESBSendSOAPHandler, #BasicAuthSettings}"/>
    </bean>

    <!-- 案件差戻し(一括)サービスの設定 -->
    <bean name="BulkReturnItem"
      class="jp.co.tepco.ifit.fw.common.bean.factory.JaxWsWebServiceEndpointFactory">
      <property name="wsdlLocation" value="file:C:/workspace_G85/G_BGOnYosanGenka/BGOnYosanGenka/keiri/B3/config/wsdl/S1_6B01-S1_6E01O_S1WorkflowBulkService.wsdl" />
      <property name="portName" value="S1WorkflowBulkPort" />
      <property name="namespace" value="http://wsi.on.ey.se.s1.tepco.co.jp/" />
      <property name="serviceName" value="S1WorkflowBulkService" />
      <property name="remoteInterface" value="jp.co.tepco.s1.se.ey.on.wsi.S1WorkflowBulk" />
      <property name="enhancements" expression="new Object[]{#DefaultESBSendSOAPHandler, #BasicAuthSettings}"/>
    </bean>

    <!-- 案件廃案(一括)サービスの設定 -->
    <bean name="BulkDestroyItem"
      class="jp.co.tepco.ifit.fw.common.bean.factory.JaxWsWebServiceEndpointFactory">
      <property name="wsdlLocation" value="file:C:/workspace_G85/G_BGOnYosanGenka/BGOnYosanGenka/keiri/B3/config/wsdl/S1_6B01-S1_6E01O_S1WorkflowBulkService.wsdl" />
      <property name="portName" value="S1WorkflowBulkPort" />
      <property name="namespace" value="http://wsi.on.ey.se.s1.tepco.co.jp/" />
      <property name="serviceName" value="S1WorkflowBulkService" />
      <property name="remoteInterface" value="jp.co.tepco.s1.se.ey.on.wsi.S1WorkflowBulk" />
      <property name="enhancements" expression="new Object[]{#DefaultESBSendSOAPHandler, #BasicAuthSettings}"/>
    </bean>

    <!-- BASIC 認証定義の設定-->
    <bean name="BasicAuthSettings" class="jp.co.tepco.ifit.fw.service.jaxws.BasicAuthSettings">
      <property name="passwordCiphered" value="false" />
      <property name="userName" value="pbb3e000" />
      <property name="password" value="pega3S00" />
    </bean>
</bean-config>
