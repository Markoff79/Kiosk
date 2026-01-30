CREATE FUNCTION [INTERNAL_ETL].[DIL_td_AccountsPayableLineItem] ()
RETURNS TABLE
AS
/*

    Author:           BIDI\marco.nielinger
    Create date:      2021-07-13
    Revision History: yyyy-mm-dd Revisor
                      description (DescriptionOfChanges)

    Description:      selects all at generation time known columns of a source

    Execution Sample:
                      SELECT TOP (42) * FROM [INTERNAL_ETL].[DIL_td_AccountsPayableLineItem]()

*/
RETURN (
  --Zunächst werden die Delta-Datensätze pro BUKRS, GJAHR, BELNR und BUZEI anhand des Requests durchnummeriert
  WITH ap4_numbered AS (
    SELECT
      *
      , ROW_NUMBER() OVER (
        PARTITION BY BUKRS
        , GJAHR
        , BELNR
        , BUZEI ORDER BY
          JobTST DESC
          , TS_SEQUENCE_NUMBER DESC
      ) AS r
    FROM [DAL_SAP].[td_0FI_AP_4]
  )

  --Es wird pro BUKRS, GJAHR, BELNR und BUZEI nur der zuletzt gültige Datensatz ausgegeben
  --Stornierte Belege werden nicht berücksichtigt (z.B. alle UPDMODs ungleich Leerstring)
  , ap4 AS (
    SELECT *
    FROM ap4_numbered
    WHERE
      r = 1
      AND UPDMOD = ''
  )

  , FiscalYearMapping AS (
    SELECT
      FiscalYearPeriod
      , month_Time_ID
    FROM UTIL.getFiscalYearPeriodMapping()
  )

  SELECT
    COALESCE(FiscalYearMapping.[month_Time_ID], m_id.[returnValue]) AS [month_Time_ID]
    , COALESCE(d4_id.[returnValue], d_id.[returnValue]) AS [day_Time_ID_PostingDate]
    , ap4.[BELNR] AS [AccountingDocumentNumber_KEY]
    , ap4.[BUZEI] AS [AccountingDocumentPostingNumber_KEY]
    , ap4.[KOART] AS [AccountType_KEY]
    , ap4.[XARCH] AS [ArchiveIndicator_KEY]
    , ap4.[ZUONR] AS [AssignmentNumber_KEY]
    , ap4.[ZFBDT] AS [BaselineDateDueDate]
    , ap4.[FILKD] AS [BranchAccountNumber_KEY]
    , ap4.[KTOPL] AS [ChartOfAccounts_KEY]
    , ap4.[AUGDT] AS [ClearingDate]
    , ap4.[AUGBL] AS [ClearingDocumentNumber_KEY]
    , ap4.[BUKRS] AS [CompanyCode_KEY]
    , ap4.[LAND1] AS [Country_KEY]
    , ap4.[CPUDT] AS [CreationDate]
    , ap4.[KKBER] AS [CreditControlArea_KEY]
    , ap4.[SHKZG] AS [DebitCreditIndicator_KEY]
    , ap4.[BLDAT] AS [DocumentDate]
    , ap4.[BSTAT] AS [DocumentStatus_KEY]
    , ap4.[BLART] AS [DocumentType_KEY]
    , ap4.[SK1DT] AS [DueDateCashDiscount1]
    , ap4.[SK2DT] AS [DueDateCashDiscount2]
    , ap4.[NETDT] AS [DueDateNetPayment]
    , ap4.[MABER] AS [DunningArea_KEY]
    , ap4.[MANSP] AS [DunningBlock_KEY]
    , ap4.[MSCHL] AS [DunningKey_KEY]
    , ap4.[MANST] AS [DunninngLevel_KEY]
    , ap4.[MONAT] AS [FiscalPeriod]
    , ap4.[GJAHR] AS [FiscalYear]
    , ap4.[FISCPER] AS [FiscalYearPeriod]
    , ap4.[REBZJ] AS [FiscalYearRelevantInvoice]
    , ap4.[FISCVAR] AS [FiscalYearVariant_KEY]
    , ap4.[HKONT] AS [GLAccount_KEY]
    , ap4.[SAKNR] AS [GLAccountNumber_KEY]
    , ap4.[REBZG] AS [InvoiceDocumentNumber_KEY]
    , ap4.[REBZZ] AS [InvoiceDocumentPostingNumber_KEY]
    , ap4.[SGTXT] AS [ItemText_DESC]
    , ap4.[MADAT] AS [LastDunningDate]
    , ap4.[XNEGP] AS [NegativePostingFlag_KEY]
    , ap4.[ZBD3T] AS [NetPaymentTermsPeriod_QTY]
    , ap4.[ZLSPR] AS [PaymentBlock_KEY]
    , ap4.[ZLSCH] AS [PaymentMethod_KEY]
    , ap4.[BUDAT] AS [PostingDate]
    , ap4.[BSCHL] AS [PostingKey_KEY]
    , ap4.[RSTGR] AS [ReasonCodeForPayments_KEY]
    , ap4.[XBLNR] AS [ReferenceDocumentNumber_KEY]
    , ap4.[AWKEY] AS [ReferenceKey_KEY]
    , ap4.[XREF1] AS [ReferenceKeyBusinessPartner1_KEY]
    , ap4.[XREF2] AS [ReferenceKeyBusinessPartner2_KEY]
    , ap4.[XREF3] AS [ReferenceKeyDocumentItem_KEY]
    , ap4.[AWTYP] AS [ReferenceTransaction_KEY]
    , ap4.[VBELN] AS [SalesDocumentNumber_KEY]
    , ap4.[UMSKZ] AS [SpecialGLIndicator_KEY]
    , ap4.[STATUSPS] AS [StatusOfFIItem_KEY]
    , ap4.[UPOSZ] AS [SubitemNumber_KEY]
    , ap4.[ZTERM] AS [TermsOfPayment_KEY]
    , ap4.[UMSKS] AS [TransactionClassSpecialLedger_KEY]
    , ap4.[UPDMOD] AS [UpdateMode_KEY]
    , ap4.[LIFNR] AS [Vendor_KEY]
    , ap4.[PROJK] AS [WBSElement_PROJK_KEY]
    , ap4.[ZBD1P] AS [CashDiscount1_PCT]
    , ap4.[ZBD2P] AS [CashDiscount2_PCT]
    , ap4.[ZBD1T] AS [CashDiscountDays1_QTY]
    , ap4.[ZBD2T] AS [CashDiscountDays2_QTY]
    , ap4.[DMBTR] AS [LC_Amount_AMT]
    , ap4.[SKNTO] AS [LC_CashDiscount_AMT]
    , ap4.[DMHAB] AS [LC_Credit_AMT]
    , ap4.[LCURR] AS [LC_Currency_KEY]
    , ap4.[DMSOL] AS [LC_Debit_AMT]
    , ap4.[DMSHB] AS [LC_DebitCredit_AMT]
    , ap4.[DMBE2] AS [LC2_Amount_AMT]
    , ap4.[HWAE2] AS [LC2_Currency_KEY]
    , ap4.[DMBE3] AS [LC3_Amount_AMT]
    , ap4.[HWAE3] AS [LC3_Currency_KEY]
    , ap4.[WRBTR] AS [TC_Amount_AMT]
    , ap4.[WSKTO] AS [TC_CashDiscount_AMT]
    , ap4.[WRHAB] AS [TC_Credit_AMT]
    , ap4.[WAERS] AS [TC_Currency_KEY]
    , ap4.[WRSOL] AS [TC_Debit_AMT]
    , ap4.[WRSHB] AS [TC_DebitCredit_AMT]
    , ap4.[SKFBT] AS [TC_EligibleCashDiscount_AMT]
  FROM ap4
  LEFT JOIN FiscalYearMapping ON (FiscalYearMapping.[FiscalYearPeriod] = ap4.[FISCPER])
  CROSS APPLY [UTIL].[getDayTimeIDFromDate](ap4.[BUDAT]) d4_id
  CROSS JOIN [INTERNAL_LOOKUP].[getKey_Date_Max]() dmax -- https://docs.sqlfluff.com/en/stable/rules.html#inline-ignoring-errors -- noqa: AL05
  CROSS APPLY [UTIL].[getDayTimeIDFromDate](dmax.[returnValue]) d_id
  CROSS APPLY [UTIL].[getMonthTimeIDFromDate](dmax.[returnValue]) m_id
)
GO

EXECUTE sp_addextendedproperty
  @name = N'loadpattern'
  , @value = N'TruncateInsert'
  , @level0type = N'SCHEMA'
  , @level0name = N'INTERNAL_ETL'
  , @level1type = N'FUNCTION'
  , @level1name = N'DIL_td_AccountsPayableLineItem'
