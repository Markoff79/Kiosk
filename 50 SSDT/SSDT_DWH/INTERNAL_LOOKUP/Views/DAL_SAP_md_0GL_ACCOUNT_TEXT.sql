CREATE VIEW [INTERNAL_LOOKUP].[DAL_SAP_md_0GL_ACCOUNT_TEXT] AS
WITH DAL AS (
  SELECT
    [LANGU]
    , [KTOPL]
    , [SAKNR]
    , [TXTSH]
    , CAST([TXTLG] AS nvarchar(60)) AS [TXTLG]
    --Englisch führend, danach Deutsch, dann LANGU wie gesetzt
    , ROW_NUMBER() OVER (
      PARTITION BY [KTOPL], [SAKNR] ORDER BY
        CASE
          WHEN [LANGU] = N'E' COLLATE Latin1_General_CS_AS THEN 1
          WHEN [LANGU] = N'D' COLLATE Latin1_General_CS_AS THEN 2
          ELSE 999
        END ASC
    ) AS r
  FROM [DAL_SAP].[md_0GL_ACCOUNT_TEXT]
)

SELECT
  [KTOPL] AS [ChartOfAccounts_KEY]
  , [SAKNR] AS [GLAccount_KEY]
  , [TXTSH] AS [GLAccount_DESC_short]
  , [TXTLG] AS [GLAccount_DESC_long]
FROM DAL
--nur führende Sprache...
WHERE r = 1
