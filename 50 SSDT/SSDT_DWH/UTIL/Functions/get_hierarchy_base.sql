CREATE FUNCTION [UTIL].[get_hierarchy_base]
(
  @HierTable nvarchar(255)
)
RETURNS TABLE
AS
/*
    Author:           noventum consulting GmbH

    Description:      creates a uniform parent-child base to flatten a given hierarchy to be storable in DIL

    Parameters:       @HierTable: name of the hierarchy of interest

    Execution Sample:
                      SELECT * FROM [UTIL].[get_hierarchy_base] ('0GL_ACCOUNT_T011_HIER_INT')
                      ORDER BY 1, 2

*/
RETURN
WITH
-- individual extraction from DAL tables (fix names!)
CTE_this_core AS (
  SELECT * FROM [INTERNAL_LOOKUP].[DAL_md_HierarchyBaseObject]
)

, CTE_this_coreplus AS (
  SELECT *
  FROM CTE_this_core
  WHERE [HierSrc] = @HierTable
)

, CTE_this_info AS (
-- Description from SAP-TEXT table to be listed in each target level
  SELECT * FROM [INTERNAL_LOOKUP].[DIL_md_HierarchyInfoObject]
)

, InfoObjectsDescs AS (
  SELECT * FROM CTE_this_info
  WHERE @HierTable LIKE CONCAT([hierarchy_entity], '%')
)

, CTE_this_base AS (
  SELECT
    *
    -- Sort may have 4 digits in each level and is derived by [NodeID] -- switched logic (compare #391): previously we had a substraction (from 10001) - now we use a construction
    , CAST((ROW_NUMBER() OVER (PARTITION BY [HierLevel], [ParentID] ORDER BY [NodeSort] ASC)) AS numeric(36, 0)) AS [Sort]
    -- Some hierarchies may have DATEFROM and DATETO (then the real fields have to be taken by "*" (usually already date datatype in DAL table)
    -- then uncomment this block....!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    --, [DATEFROM] AS [myDateFrom]
    --, [DATETO] AS [myDateTo]
    -- ..and comment this block..!
    , CAST(NULL AS date) AS [myDateFrom]
    , CAST(NULL AS date) AS [myDateTo]
    -- ...up to here!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  FROM CTE_this_coreplus
)

-- END of individual extraction from DAL tables (fix names!)

-- ---------------------------------------------------
--
-- Do not amend below - it will effect all hierarchies
--
-- ---------------------------------------------------
, Hier_Parent_Child AS (
  SELECT
    h.*
    , ISNULL(CASE WHEN h.NodeType_KEY = n.returnValue AND ISNULL(h.[TextShort_ori], '') != '' THEN h.[TextShort_ori] END, iod.[TextShort]) AS [TextShort]
    , ISNULL(CASE WHEN h.NodeType_KEY = n.returnValue AND ISNULL(h.[TextMedium_ori], '') != '' THEN h.[TextMedium_ori] END, iod.[TextMedium]) AS [TextMedium]
    , ISNULL(CASE WHEN h.NodeType_KEY = n.returnValue AND ISNULL(h.[TextLong_ori], '') != '' THEN h.[TextLong_ori] END, iod.[TextLong]) AS [TextLong]
    , CAST(ISNULL(h.[myDateFrom], [getKey_Date_Min].[returnValue]) AS date) AS [ValidFrom]
    , CAST(ISNULL(h.[myDateTo], [getKey_Date_Max].[returnValue]) AS date) AS [ValidTo]
  FROM CTE_this_base h
  LEFT JOIN InfoObjectsDescs iod ON (iod.[NodeName] = h.[NodeName])
  CROSS JOIN [INTERNAL_LOOKUP].[getKey_DateTime7_Min]() [getKey_Date_Min]
  CROSS JOIN [INTERNAL_LOOKUP].[getKey_Date_Max]() [getKey_Date_Max]
  CROSS JOIN [INTERNAL_LOOKUP].[getKey_Hierarchy_NodeType_Node]() n
)

-- Double all nodes that are parents of other nodes
-- This is needed for "postable parents" (isLeaf = 0 AND NodeID_Join = NULL)
, Hier_Parent_Child_Nodes_doubled AS (
  SELECT
    1 AS [isLeaf]
    , [NodeID] AS [NodeID_Join]
    , [NodeID]
    , [HierLevel]
    , [NodeName]
    , [ParentID]
    , [ChildID]
    , [NextID]
    , [TextShort]
    , [TextMedium]
    , [TextLong]
    , [NodeType_KEY]
    , [ValidFrom]
    , [ValidTo]
    , [Sort]
  FROM Hier_Parent_Child
  UNION ALL
  SELECT
    0 AS [isLeaf] -- "postable nodes" have isLeaf = 0
    , NULL AS [NodeID_Join] -- "postable nodes" have NodeID_JOIN = NULL
    , [NodeID]
    , [HierLevel]
    , [NodeName]
    , [ParentID]
    , [ChildID]
    , [NextID]
    , [TextShort]
    , [TextMedium]
    , [TextLong]
    , [NodeType_KEY]
    , [ValidFrom]
    , [ValidTo]
    , [Sort]
  FROM Hier_Parent_Child
  WHERE [NodeID] IN (SELECT DISTINCT X.[ParentID] FROM Hier_Parent_Child X)
)

SELECT
  [NodeID]
  , [isLeaf]
  , [HierLevel]
  , [NodeName]
  , [NodeID_Join]
  , [ParentID]
  , [ChildID]
  , [NextID]
  , [TextShort]
  , [TextMedium]
  , [TextLong]
  , [NodeType_KEY]
  , [ValidTo]
  , CAST([Sort] AS numeric(36, 0)) AS [Sort]
FROM Hier_Parent_Child_Nodes_doubled
