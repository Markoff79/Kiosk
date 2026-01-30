CREATE VIEW [INTERNAL_LOOKUP].[DAL_SAP_md_0GL_ACCOUNT_T011_HIER_INT] AS
/*

    Author:           noventum consulting GmbH

    Description:      formatting view for standard hierachy-flattening

    Parameters:       (none)

    Execution Sample:
                      SELECT * FROM [INTERNAL_LOOKUP].[DAL_SAP_md_0GL_ACCOUNT_T011_HIER_INT]

*/
SELECT
  CAST('0GL_ACCOUNT_T011_HIER_INT' AS nvarchar(255)) AS [HierSrc]
  , [NodeID]
  , [ParentID]
  , [ChildID]
  , [NextID]
  , CAST([NodeID] AS bigint) AS [NodeSort]
  , [NodeName]
  , [TLEVEL] AS [HierLevel] -- [Level]
  , IIF([FIELDNM] = nm.[returnValue], n.[returnValue], l.[returnValue]) AS [NodeType_KEY] -- Node or Leaf
  , [TXTSH] AS [TextShort_ori]  -- [ShortText]
  , [TXTMD] AS [TextMedium_ori] -- [MediumText]
  , [TXTLG] AS [TextLong_ori]   -- [LongText]
FROM [DAL_SAP].[md_0GL_ACCOUNT_T011_HIER_INT]
CROSS JOIN [INTERNAL_LOOKUP].[getKey_Hierarchy_SAPNodeIdentifier]() nm
CROSS JOIN [INTERNAL_LOOKUP].[getKey_Hierarchy_NodeType_Node]() n
CROSS JOIN [INTERNAL_LOOKUP].[getKey_Hierarchy_NodeType_Leaf]() l
-- DAL table without link nodes (we will not support linked nodes)
WHERE [Link] = ''
