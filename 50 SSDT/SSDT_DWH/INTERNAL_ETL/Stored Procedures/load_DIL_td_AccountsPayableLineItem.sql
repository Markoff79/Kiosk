CREATE PROCEDURE [INTERNAL_ETL].[load_DIL_td_AccountsPayableLineItem]
  @execution_id bigint = -1
  , @RowCount bigint = NULL OUTPUT
  , @RowsInserted bigint = NULL OUTPUT
  , @RowsUpdated bigint = NULL OUTPUT
  , @RowsDeleted bigint = NULL OUTPUT
  , @RowsUpdatedDeactivated bigint = NULL OUTPUT
  , @RowsUpdatedReactivated bigint = NULL OUTPUT
AS
/*

    Author:           noventum consulting GmbH

    Description:      loads from source into target

    Parameters:       (none)

    Execution Sample:
                      EXECUTE INTERNAL_ETL.load_DIL_td_AccountsPayableLineItem

*/
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN
  DECLARE @start_time datetime = GETDATE()
  DECLARE @end_time datetime
  DECLARE @start_megabyte numeric(28, 5)
  DECLARE @start_rows int
  DECLARE @end_megabyte numeric(28, 5)

  SELECT
    @RowsDeleted = SUM(row_count)
    , @start_megabyte = 0
    , @start_rows = 0
  FROM sys.dm_db_partition_stats WITH (NOLOCK)
  WHERE object_id = OBJECT_ID('DIL.td_AccountsPayableLineItem') AND (index_id = 0 OR index_id = 1);

  TRUNCATE TABLE DIL.td_AccountsPayableLineItem;

  WITH CTE_gen_INTERNAL_ETL_load_DIL_td_AccountsPayableLineItem AS (
    SELECT
      [month_Time_ID]
      , [day_Time_ID_PostingDate]
      , [AccountingDocumentNumber_KEY]
      , [AccountingDocumentPostingNumber_KEY]
      , [AccountType_KEY]
      , [ArchiveIndicator_KEY]
      , [AssignmentNumber_KEY]
      , [BaselineDateDueDate]
      , [BranchAccountNumber_KEY]
      , [ChartOfAccounts_KEY]
      , [ClearingDate]
      , [ClearingDocumentNumber_KEY]
      , [CompanyCode_KEY]
      , [Country_KEY]
      , [CreationDate]
      , [CreditControlArea_KEY]
      , [DebitCreditIndicator_KEY]
      , [DocumentDate]
      , [DocumentStatus_KEY]
      , [DocumentType_KEY]
      , [DueDateCashDiscount1]
      , [DueDateCashDiscount2]
      , [DueDateNetPayment]
      , [DunningArea_KEY]
      , [DunningBlock_KEY]
      , [DunningKey_KEY]
      , [DunninngLevel_KEY]
      , [FiscalPeriod]
      , [FiscalYear]
      , [FiscalYearPeriod]
      , [FiscalYearRelevantInvoice]
      , [FiscalYearVariant_KEY]
      , [GLAccount_KEY]
      , [GLAccountNumber_KEY]
      , [InvoiceDocumentNumber_KEY]
      , [InvoiceDocumentPostingNumber_KEY]
      , [ItemText_DESC]
      , [LastDunningDate]
      , [NegativePostingFlag_KEY]
      , [NetPaymentTermsPeriod_QTY]
      , [PaymentBlock_KEY]
      , [PaymentMethod_KEY]
      , [PostingDate]
      , [PostingKey_KEY]
      , [ReasonCodeForPayments_KEY]
      , [ReferenceDocumentNumber_KEY]
      , [ReferenceKey_KEY]
      , [ReferenceKeyBusinessPartner1_KEY]
      , [ReferenceKeyBusinessPartner2_KEY]
      , [ReferenceKeyDocumentItem_KEY]
      , [ReferenceTransaction_KEY]
      , [SalesDocumentNumber_KEY]
      , [SpecialGLIndicator_KEY]
      , [StatusOfFIItem_KEY]
      , [SubitemNumber_KEY]
      , [TermsOfPayment_KEY]
      , [TransactionClassSpecialLedger_KEY]
      , [UpdateMode_KEY]
      , [Vendor_KEY]
      , [WBSElement_PROJK_KEY]
      , [CashDiscount1_PCT]
      , [CashDiscount2_PCT]
      , [CashDiscountDays1_QTY]
      , [CashDiscountDays2_QTY]
      , [LC_Amount_AMT]
      , [LC_CashDiscount_AMT]
      , [LC_Credit_AMT]
      , [LC_Currency_KEY]
      , [LC_Debit_AMT]
      , [LC_DebitCredit_AMT]
      , [LC2_Amount_AMT]
      , [LC2_Currency_KEY]
      , [LC3_Amount_AMT]
      , [LC3_Currency_KEY]
      , [TC_Amount_AMT]
      , [TC_CashDiscount_AMT]
      , [TC_Credit_AMT]
      , [TC_Currency_KEY]
      , [TC_Debit_AMT]
      , [TC_DebitCredit_AMT]
      , [TC_EligibleCashDiscount_AMT]
    FROM INTERNAL_ETL.DIL_td_AccountsPayableLineItem()
  )

  INSERT INTO DIL.td_AccountsPayableLineItem WITH (TABLOCK) (
    [month_Time_ID]
    , [day_Time_ID_PostingDate]
    , [AccountingDocumentNumber_KEY]
    , [AccountingDocumentPostingNumber_KEY]
    , [AccountType_KEY]
    , [ArchiveIndicator_KEY]
    , [AssignmentNumber_KEY]
    , [BaselineDateDueDate]
    , [BranchAccountNumber_KEY]
    , [ChartOfAccounts_KEY]
    , [ClearingDate]
    , [ClearingDocumentNumber_KEY]
    , [CompanyCode_KEY]
    , [Country_KEY]
    , [CreationDate]
    , [CreditControlArea_KEY]
    , [DebitCreditIndicator_KEY]
    , [DocumentDate]
    , [DocumentStatus_KEY]
    , [DocumentType_KEY]
    , [DueDateCashDiscount1]
    , [DueDateCashDiscount2]
    , [DueDateNetPayment]
    , [DunningArea_KEY]
    , [DunningBlock_KEY]
    , [DunningKey_KEY]
    , [DunninngLevel_KEY]
    , [FiscalPeriod]
    , [FiscalYear]
    , [FiscalYearPeriod]
    , [FiscalYearRelevantInvoice]
    , [FiscalYearVariant_KEY]
    , [GLAccount_KEY]
    , [GLAccountNumber_KEY]
    , [InvoiceDocumentNumber_KEY]
    , [InvoiceDocumentPostingNumber_KEY]
    , [ItemText_DESC]
    , [LastDunningDate]
    , [NegativePostingFlag_KEY]
    , [NetPaymentTermsPeriod_QTY]
    , [PaymentBlock_KEY]
    , [PaymentMethod_KEY]
    , [PostingDate]
    , [PostingKey_KEY]
    , [ReasonCodeForPayments_KEY]
    , [ReferenceDocumentNumber_KEY]
    , [ReferenceKey_KEY]
    , [ReferenceKeyBusinessPartner1_KEY]
    , [ReferenceKeyBusinessPartner2_KEY]
    , [ReferenceKeyDocumentItem_KEY]
    , [ReferenceTransaction_KEY]
    , [SalesDocumentNumber_KEY]
    , [SpecialGLIndicator_KEY]
    , [StatusOfFIItem_KEY]
    , [SubitemNumber_KEY]
    , [TermsOfPayment_KEY]
    , [TransactionClassSpecialLedger_KEY]
    , [UpdateMode_KEY]
    , [Vendor_KEY]
    , [WBSElement_PROJK_KEY]
    , [CashDiscount1_PCT]
    , [CashDiscount2_PCT]
    , [CashDiscountDays1_QTY]
    , [CashDiscountDays2_QTY]
    , [LC_Amount_AMT]
    , [LC_CashDiscount_AMT]
    , [LC_Credit_AMT]
    , [LC_Currency_KEY]
    , [LC_Debit_AMT]
    , [LC_DebitCredit_AMT]
    , [LC2_Amount_AMT]
    , [LC2_Currency_KEY]
    , [LC3_Amount_AMT]
    , [LC3_Currency_KEY]
    , [TC_Amount_AMT]
    , [TC_CashDiscount_AMT]
    , [TC_Credit_AMT]
    , [TC_Currency_KEY]
    , [TC_Debit_AMT]
    , [TC_DebitCredit_AMT]
    , [TC_EligibleCashDiscount_AMT]
    , [meta_created_execution_id]
  )
  SELECT
    [month_Time_ID]
    , [day_Time_ID_PostingDate]
    , [AccountingDocumentNumber_KEY]
    , [AccountingDocumentPostingNumber_KEY]
    , [AccountType_KEY]
    , [ArchiveIndicator_KEY]
    , [AssignmentNumber_KEY]
    , [BaselineDateDueDate]
    , [BranchAccountNumber_KEY]
    , [ChartOfAccounts_KEY]
    , [ClearingDate]
    , [ClearingDocumentNumber_KEY]
    , [CompanyCode_KEY]
    , [Country_KEY]
    , [CreationDate]
    , [CreditControlArea_KEY]
    , [DebitCreditIndicator_KEY]
    , [DocumentDate]
    , [DocumentStatus_KEY]
    , [DocumentType_KEY]
    , [DueDateCashDiscount1]
    , [DueDateCashDiscount2]
    , [DueDateNetPayment]
    , [DunningArea_KEY]
    , [DunningBlock_KEY]
    , [DunningKey_KEY]
    , [DunninngLevel_KEY]
    , [FiscalPeriod]
    , [FiscalYear]
    , [FiscalYearPeriod]
    , [FiscalYearRelevantInvoice]
    , [FiscalYearVariant_KEY]
    , [GLAccount_KEY]
    , [GLAccountNumber_KEY]
    , [InvoiceDocumentNumber_KEY]
    , [InvoiceDocumentPostingNumber_KEY]
    , [ItemText_DESC]
    , [LastDunningDate]
    , [NegativePostingFlag_KEY]
    , [NetPaymentTermsPeriod_QTY]
    , [PaymentBlock_KEY]
    , [PaymentMethod_KEY]
    , [PostingDate]
    , [PostingKey_KEY]
    , [ReasonCodeForPayments_KEY]
    , [ReferenceDocumentNumber_KEY]
    , [ReferenceKey_KEY]
    , [ReferenceKeyBusinessPartner1_KEY]
    , [ReferenceKeyBusinessPartner2_KEY]
    , [ReferenceKeyDocumentItem_KEY]
    , [ReferenceTransaction_KEY]
    , [SalesDocumentNumber_KEY]
    , [SpecialGLIndicator_KEY]
    , [StatusOfFIItem_KEY]
    , [SubitemNumber_KEY]
    , [TermsOfPayment_KEY]
    , [TransactionClassSpecialLedger_KEY]
    , [UpdateMode_KEY]
    , [Vendor_KEY]
    , [WBSElement_PROJK_KEY]
    , [CashDiscount1_PCT]
    , [CashDiscount2_PCT]
    , [CashDiscountDays1_QTY]
    , [CashDiscountDays2_QTY]
    , [LC_Amount_AMT]
    , [LC_CashDiscount_AMT]
    , [LC_Credit_AMT]
    , [LC_Currency_KEY]
    , [LC_Debit_AMT]
    , [LC_DebitCredit_AMT]
    , [LC2_Amount_AMT]
    , [LC2_Currency_KEY]
    , [LC3_Amount_AMT]
    , [LC3_Currency_KEY]
    , [TC_Amount_AMT]
    , [TC_CashDiscount_AMT]
    , [TC_Credit_AMT]
    , [TC_Currency_KEY]
    , [TC_Debit_AMT]
    , [TC_DebitCredit_AMT]
    , [TC_EligibleCashDiscount_AMT]
    , @execution_id AS [meta_created_execution_id]
  FROM CTE_gen_INTERNAL_ETL_load_DIL_td_AccountsPayableLineItem

  SELECT
    @RowsInserted = SUM(row_count) - @start_rows
    , @RowCount = SUM(row_count) - @start_rows
    , @end_time = GETDATE()
    , @end_megabyte = SUM(used_page_count) / 1024.0 * 8.0
  FROM sys.dm_db_partition_stats WITH (NOLOCK)
  WHERE object_id = OBJECT_ID('DIL.td_AccountsPayableLineItem') AND (index_id = 0 OR index_id = 1);

  SELECT
    '[DIL].[td_AccountsPayableLineItem]' AS [table]
    , 'TruncateInsert' AS [loadpattern]
    , @RowsInserted AS rows_inserted
    , @RowsDeleted AS rows_deleted
    , @start_time AS start_time
    , @end_time AS end_time
    , DATEDIFF(SECOND, @start_time, @end_time) AS duration_in_seconds
    , (@end_megabyte - @start_megabyte) AS megabyte_written
    , CAST((@end_megabyte - @start_megabyte) / IIF(DATEDIFF(SECOND, @start_time, @end_time) > 0, DATEDIFF(SECOND, @start_time, @end_time), 1) AS numeric(28, 5)) AS megabyte_written_per_second
END
