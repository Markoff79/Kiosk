CREATE TABLE [DIL].[td_AccountsPayableLineItem] (
  [month_Time_ID] int NOT NULL
  , [day_Time_ID_PostingDate] int NOT NULL
  , [AccountingDocumentNumber_KEY] nvarchar(10) NULL
  , [AccountingDocumentPostingNumber_KEY] nvarchar(3) NULL
  , [AccountType_KEY] nvarchar(1) NULL
  , [ArchiveIndicator_KEY] nvarchar(1) NULL
  , [AssignmentNumber_KEY] nvarchar(18) NULL
  , [BaselineDateDueDate] date NULL
  , [BranchAccountNumber_KEY] nvarchar(10) NULL
  , [ChartOfAccounts_KEY] nvarchar(4) NULL
  , [ClearingDate] date NULL
  , [ClearingDocumentNumber_KEY] nvarchar(10) NULL
  , [CompanyCode_KEY] nvarchar(4) NULL
  , [Country_KEY] nvarchar(3) NULL
  , [CreationDate] date NULL
  , [CreditControlArea_KEY] nvarchar(4) NULL
  , [DebitCreditIndicator_KEY] nvarchar(1) NULL
  , [DocumentDate] date NULL
  , [DocumentStatus_KEY] nvarchar(1) NULL
  , [DocumentType_KEY] nvarchar(2) NULL
  , [DueDateCashDiscount1] date NULL
  , [DueDateCashDiscount2] date NULL
  , [DueDateNetPayment] date NULL
  , [DunningArea_KEY] nvarchar(2) NULL
  , [DunningBlock_KEY] nvarchar(1) NULL
  , [DunningKey_KEY] nvarchar(1) NULL
  , [DunninngLevel_KEY] nvarchar(1) NULL
  , [FiscalPeriod] nvarchar(2) NULL
  , [FiscalYear] nvarchar(4) NULL
  , [FiscalYearPeriod] nvarchar(7) NULL
  , [FiscalYearRelevantInvoice] nvarchar(4) NULL
  , [FiscalYearVariant_KEY] nvarchar(2) NULL
  , [GLAccount_KEY] nvarchar(10) NULL
  , [GLAccountNumber_KEY] nvarchar(10) NULL
  , [InvoiceDocumentNumber_KEY] nvarchar(10) NULL
  , [InvoiceDocumentPostingNumber_KEY] nvarchar(3) NULL
  , [ItemText_DESC] nvarchar(50) NULL
  , [LastDunningDate] date NULL
  , [NegativePostingFlag_KEY] nvarchar(1) NULL
  , [NetPaymentTermsPeriod_QTY] numeric(3, 0) NULL
  , [PaymentBlock_KEY] nvarchar(1) NULL
  , [PaymentMethod_KEY] nvarchar(1) NULL
  , [PostingDate] date NULL
  , [PostingKey_KEY] nvarchar(2) NULL
  , [ReasonCodeForPayments_KEY] nvarchar(3) NULL
  , [ReferenceDocumentNumber_KEY] nvarchar(16) NULL
  , [ReferenceKey_KEY] nvarchar(20) NULL
  , [ReferenceKeyBusinessPartner1_KEY] nvarchar(12) NULL
  , [ReferenceKeyBusinessPartner2_KEY] nvarchar(12) NULL
  , [ReferenceKeyDocumentItem_KEY] nvarchar(20) NULL
  , [ReferenceTransaction_KEY] nvarchar(5) NULL
  , [SalesDocumentNumber_KEY] nvarchar(10) NULL
  , [SpecialGLIndicator_KEY] nvarchar(1) NULL
  , [StatusOfFIItem_KEY] nvarchar(1) NULL
  , [SubitemNumber_KEY] nvarchar(4) NULL
  , [TermsOfPayment_KEY] nvarchar(4) NULL
  , [TransactionClassSpecialLedger_KEY] nvarchar(1) NULL
  , [UpdateMode_KEY] nvarchar(1) NULL
  , [Vendor_KEY] nvarchar(10) NULL
  , [WBSElement_PROJK_KEY] nvarchar(8) NULL
  , [CashDiscount1_PCT] numeric(5, 3) NULL
  , [CashDiscount2_PCT] numeric(5, 3) NULL
  , [CashDiscountDays1_QTY] numeric(3, 0) NULL
  , [CashDiscountDays2_QTY] numeric(3, 0) NULL
  , [LC_Amount_AMT] numeric(13, 2) NULL
  , [LC_CashDiscount_AMT] numeric(13, 2) NULL
  , [LC_Credit_AMT] numeric(13, 2) NULL
  , [LC_Currency_KEY] nvarchar(5) NULL
  , [LC_Debit_AMT] numeric(13, 2) NULL
  , [LC_DebitCredit_AMT] numeric(13, 2) NULL
  , [LC2_Amount_AMT] numeric(13, 2) NULL
  , [LC2_Currency_KEY] nvarchar(5) NULL
  , [LC3_Amount_AMT] numeric(13, 2) NULL
  , [LC3_Currency_KEY] nvarchar(5) NULL
  , [TC_Amount_AMT] numeric(13, 2) NULL
  , [TC_CashDiscount_AMT] numeric(13, 2) NULL
  , [TC_Credit_AMT] numeric(13, 2) NULL
  , [TC_Currency_KEY] nvarchar(5) NULL
  , [TC_Debit_AMT] numeric(13, 2) NULL
  , [TC_DebitCredit_AMT] numeric(13, 2) NULL
  , [TC_EligibleCashDiscount_AMT] numeric(13, 2) NULL
  , [tst] datetime2(3) CONSTRAINT [DF_DIL_td_AccountsPayableLineItem_tst] DEFAULT (SYSDATETIME()) NOT NULL

  , [meta_created_execution_id] bigint NOT NULL DEFAULT -1
  , [meta_created_by] nvarchar(128) NOT NULL DEFAULT (SUSER_NAME())
  , [meta_created_at] datetime2(7) NOT NULL DEFAULT (SYSDATETIME())
) WITH (DATA_COMPRESSION = PAGE);
GO
