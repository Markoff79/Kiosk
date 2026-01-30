CREATE FUNCTION [UTIL].[get_hierarchy_flattened]
(
  @HierTable nvarchar(255)
)
RETURNS TABLE
AS
/*
    Author:           noventum consulting GmbH

    Description:      creates a flattened hierarchy to be storable in DIL

    Parameters:       @HierTable: name of the hierarchy of interest

    Execution Sample:
                      SELECT * FROM [UTIL].[get_hierarchy_flattened] ('0GL_ACCOUNT_T011_HIER_IAS0')
                      ORDER BY 1 DESC, [HIER_GENERIC_Sort]

                      SELECT * FROM [UTIL].[get_hierarchy_flattened] ('0PROFIT_CTR_0106_HIER_1000Z_HC_DACH')
                      ORDER BY 1 DESC, [HIER_GENERIC_Sort]

*/
RETURN
WITH Hier_Parent_Child_Nodes_doubled AS (
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
    , [Sort]
  FROM [UTIL].[get_hierarchy_base](@HierTable)
)

, Hier_HierLevel01 AS (
  SELECT * FROM Hier_Parent_Child_Nodes_doubled WHERE HierLevel = '01'
)

, Hier_HierLevel02 AS (
  SELECT *
  FROM Hier_Parent_Child_Nodes_doubled
  WHERE HierLevel = '02'
)

, Hier_HierLevel03 AS (
  SELECT *
  FROM Hier_Parent_Child_Nodes_doubled
  WHERE HierLevel = '03'
)

, Hier_HierLevel04 AS (
  SELECT *
  FROM Hier_Parent_Child_Nodes_doubled
  WHERE HierLevel = '04'
)

, Hier_HierLevel05 AS (
  SELECT *
  FROM Hier_Parent_Child_Nodes_doubled
  WHERE HierLevel = '05'
)

, Hier_HierLevel06 AS (
  SELECT *
  FROM Hier_Parent_Child_Nodes_doubled
  WHERE HierLevel = '06'
)

, Hier_HierLevel07 AS (
  SELECT *
  FROM Hier_Parent_Child_Nodes_doubled
  WHERE HierLevel = '07'
)

, Hier_HierLevel08 AS (
  SELECT *
  FROM Hier_Parent_Child_Nodes_doubled
  WHERE HierLevel = '08'
)

, Hier_HierLevel09 AS (
  SELECT *
  FROM Hier_Parent_Child_Nodes_doubled
  WHERE HierLevel = '09'
)

, Hier_HierLevel10 AS (
  SELECT *
  FROM Hier_Parent_Child_Nodes_doubled
  WHERE HierLevel = '10'
)

, Hier_HierLevel11 AS (
  SELECT *
  FROM Hier_Parent_Child_Nodes_doubled
  WHERE HierLevel = '11'
)

, Hier_HierLevel12 AS (
  SELECT *
  --Fixed Leaf-HierLevel, therfore "possible Nodes" (recursion) not doubled
  FROM Hier_Parent_Child_Nodes_doubled
  WHERE
    HierLevel = '12'
    AND isLeaf = 1
)

-- Now combine HierLevel by HierLevel ("01-->02-->03-->...-->12")
-- If a node is a leaf (e.g. "NodeID_Join from HierLevel 02 ist not referenced by ParentID in HierLevel 03") its is also taken for the next HierLevel ("Herunterreichen")
-- For historicized hierarchies the ValidFrom/To between parent-child-relations is combined
, HierLevel02 AS (
  SELECT
    a.[NodeType_KEY] AS NodeType_L01
    , a.NodeName AS NodeKey_L01
    , a.TextShort AS NodeDescShort_L01
    , a.TextMedium AS NodeDescMedium_L01
    , a.TextLong AS NodeDescLong_L01
    , a.Sort AS NodeSort_L01
    --, a.ValidFrom AS ValidFrom_L01
    --, a.ValidTo AS ValidTo_L01
    , CASE WHEN b.NodeID IS NULL THEN a.[NodeType_KEY] ELSE b.[NodeType_KEY] END AS NodeType_L02
    , CASE WHEN b.NodeID IS NULL THEN a.NodeName ELSE b.NodeName END AS NodeKey_L02
    , CASE WHEN b.NodeID IS NULL THEN a.TextShort ELSE b.TextShort END AS NodeDescShort_L02
    , CASE WHEN b.NodeID IS NULL THEN a.TextMedium ELSE b.TextMedium END AS NodeDescMedium_L02
    , CASE WHEN b.NodeID IS NULL THEN a.TextLong ELSE b.TextLong END AS NodeDescLong_L02
    , a.Sort * 1000 + COALESCE(b.Sort, 0) AS Sort
    , a.Sort * 1000 + CASE WHEN b.NodeID IS NULL THEN 0 ELSE b.Sort END AS NodeSort_L02
    , CASE WHEN b.NodeID IS NULL THEN a.isLeaf ELSE b.isLeaf END AS isLeaf
    , CASE WHEN b.NodeID IS NULL THEN CAST(a.HierLevel AS smallint) ELSE CAST(b.HierLevel AS smallint) END AS HierLevel
    , b.NodeID_Join
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidFrom ELSE b.ValidFrom END AS ValidFrom_L02
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidTo ELSE b.ValidTo END AS ValidTo_L02
    --, CASE
    --  WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
    --    THEN ISNULL(a.ValidFrom, '10000101')
    --  ELSE ISNULL(b.ValidFrom, '10000101')
    --END AS ValidFrom
    --, CASE
    --  WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
    --    THEN ISNULL(a.ValidTo, '99991231')
    --  ELSE ISNULL(b.ValidTo, '99991231')
    --END AS ValidTo
  FROM Hier_HierLevel01 a LEFT OUTER JOIN Hier_HierLevel02 b ON (b.ParentID = a.NodeID_Join)
  --WHERE
  --  CASE
  --    WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
  --      THEN ISNULL(a.ValidFrom, '10000101')
  --    ELSE ISNULL(b.ValidFrom, '10000101')
  --  END
  --  <
  --  CASE
  --    WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
  --      THEN ISNULL(a.ValidTo, '99991231')
  --    ELSE ISNULL(b.ValidTo, '99991231')
  --  END
)

, HierLevel03 AS (
  SELECT
    a.NodeType_L01
    , a.NodeKey_L01
    , a.NodeDescShort_L01
    , a.NodeDescMedium_L01
    , a.NodeDescLong_L01
    , a.NodeSort_L01
    --, a.ValidFrom_L01
    --, a.ValidTo_L01
    , a.NodeType_L02
    , a.NodeKey_L02
    , a.NodeDescShort_L02
    , a.NodeDescMedium_L02
    , a.NodeDescLong_L02
    , a.NodeSort_L02
    --, a.ValidFrom_L02
    --, a.ValidTo_L02
    , CASE WHEN b.NodeID IS NULL THEN a.NodeType_L02 ELSE b.[NodeType_KEY] END AS NodeType_L03
    , CASE WHEN b.NodeID IS NULL THEN a.NodeKey_L02 ELSE b.NodeName END AS NodeKey_L03
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescShort_L02 ELSE b.TextShort END AS NodeDescShort_L03
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescMedium_L02 ELSE b.TextMedium END AS NodeDescMedium_L03
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescLong_L02 ELSE b.TextLong END AS NodeDescLong_L03
    , a.Sort * 1000 + COALESCE(b.Sort, 0) AS Sort
    , a.Sort * 1000 + CASE WHEN b.NodeID IS NULL THEN 0 ELSE b.Sort END AS NodeSort_L03
    , CASE WHEN b.NodeID IS NULL THEN a.isLeaf ELSE b.isLeaf END AS isLeaf
    , CASE WHEN b.NodeID IS NULL THEN CAST(a.HierLevel AS smallint) ELSE CAST(b.HierLevel AS smallint) END AS HierLevel
    , b.NodeID_Join
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidFrom_L02 ELSE b.ValidFrom END AS ValidFrom_L03
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidTo_L02 ELSE b.ValidTo END AS ValidTo_L03
    --, CASE
    --  WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
    --    THEN ISNULL(a.ValidFrom, '10000101')
    --  ELSE ISNULL(b.ValidFrom, '10000101')
    --END AS ValidFrom
    --, CASE
    --  WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
    --    THEN ISNULL(a.ValidTo, '99991231')
    --  ELSE ISNULL(b.ValidTo, '99991231')
    --END AS ValidTo
  FROM HierLevel02 a LEFT OUTER JOIN Hier_HierLevel03 b ON (b.ParentID = a.NodeID_Join)
  --WHERE
  --  CASE
  --    WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
  --      THEN ISNULL(a.ValidFrom, '10000101')
  --    ELSE ISNULL(b.ValidFrom, '10000101')
  --  END
  --  <
  --  CASE
  --    WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
  --      THEN ISNULL(a.ValidTo, '99991231')
  --    ELSE ISNULL(b.ValidTo, '99991231')
  --  END
)

, HierLevel04 AS (
  SELECT
    a.NodeType_L01
    , a.NodeKey_L01
    , a.NodeDescShort_L01
    , a.NodeDescMedium_L01
    , a.NodeDescLong_L01
    , a.NodeSort_L01
    --, a.ValidFrom_L01
    --, a.ValidTo_L01
    , a.NodeType_L02
    , a.NodeKey_L02
    , a.NodeDescShort_L02
    , a.NodeDescMedium_L02
    , a.NodeDescLong_L02
    , a.NodeSort_L02
    --, a.ValidFrom_L02
    --, a.ValidTo_L02
    , a.NodeType_L03
    , a.NodeKey_L03
    , a.NodeDescShort_L03
    , a.NodeDescMedium_L03
    , a.NodeDescLong_L03
    , a.NodeSort_L03
    --, a.ValidFrom_L03
    --, a.ValidTo_L03
    , CASE WHEN b.NodeID IS NULL THEN a.NodeType_L03 ELSE b.[NodeType_KEY] END AS NodeType_L04
    , CASE WHEN b.NodeID IS NULL THEN a.NodeKey_L03 ELSE b.NodeName END AS NodeKey_L04
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescShort_L03 ELSE b.TextShort END AS NodeDescShort_L04
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescMedium_L03 ELSE b.TextMedium END AS NodeDescMedium_L04
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescLong_L03 ELSE b.TextLong END AS NodeDescLong_L04
    , a.Sort * 1000 + COALESCE(b.Sort, 0) AS Sort
    , a.Sort * 1000 + CASE WHEN b.NodeID IS NULL THEN 0 ELSE b.Sort END AS NodeSort_L04
    , CASE WHEN b.NodeID IS NULL THEN a.isLeaf ELSE b.isLeaf END AS isLeaf
    , CASE WHEN b.NodeID IS NULL THEN CAST(a.HierLevel AS smallint) ELSE CAST(b.HierLevel AS smallint) END AS HierLevel
    , b.NodeID_Join
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidFrom_L03 ELSE b.ValidFrom END AS ValidFrom_L04
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidTo_L03 ELSE b.ValidTo END AS ValidTo_L04
    --, CASE
    --  WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
    --    THEN ISNULL(a.ValidFrom, '10000101')
    --  ELSE ISNULL(b.ValidFrom, '10000101')
    --END AS ValidFrom
    --, CASE
    --  WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
    --    THEN ISNULL(a.ValidTo, '99991231')
    --  ELSE ISNULL(b.ValidTo, '99991231')
    --END AS ValidTo
  FROM HierLevel03 a LEFT OUTER JOIN Hier_HierLevel04 b ON (b.ParentID = a.NodeID_Join)
  --WHERE
  --  CASE
  --    WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
  --      THEN ISNULL(a.ValidFrom, '10000101')
  --    ELSE ISNULL(b.ValidFrom, '10000101')
  --  END
  --  <
  --  CASE
  --    WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
  --      THEN ISNULL(a.ValidTo, '99991231')
  --    ELSE ISNULL(b.ValidTo, '99991231')
  --  END
)

, HierLevel05 AS (
  SELECT
    a.NodeType_L01
    , a.NodeKey_L01
    , a.NodeDescShort_L01
    , a.NodeDescMedium_L01
    , a.NodeDescLong_L01
    , a.NodeSort_L01
    --, a.ValidFrom_L01
    --, a.ValidTo_L01
    , a.NodeType_L02
    , a.NodeKey_L02
    , a.NodeDescShort_L02
    , a.NodeDescMedium_L02
    , a.NodeDescLong_L02
    , a.NodeSort_L02
    --, a.ValidFrom_L02
    --, a.ValidTo_L02
    , a.NodeType_L03
    , a.NodeKey_L03
    , a.NodeDescShort_L03
    , a.NodeDescMedium_L03
    , a.NodeDescLong_L03
    , a.NodeSort_L03
    --, a.ValidFrom_L03
    --, a.ValidTo_L03
    , a.NodeType_L04
    , a.NodeKey_L04
    , a.NodeDescShort_L04
    , a.NodeDescMedium_L04
    , a.NodeDescLong_L04
    , a.NodeSort_L04
    --, a.ValidFrom_L04
    --, a.ValidTo_L04
    , CASE WHEN b.NodeID IS NULL THEN a.NodeType_L04 ELSE b.[NodeType_KEY] END AS NodeType_L05
    , CASE WHEN b.NodeID IS NULL THEN a.NodeKey_L04 ELSE b.NodeName END AS NodeKey_L05
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescShort_L04 ELSE b.TextShort END AS NodeDescShort_L05
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescMedium_L04 ELSE b.TextMedium END AS NodeDescMedium_L05
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescLong_L04 ELSE b.TextLong END AS NodeDescLong_L05
    , a.Sort * 1000 + COALESCE(b.Sort, 0) AS Sort
    , a.Sort * 1000 + CASE WHEN b.NodeID IS NULL THEN 0 ELSE b.Sort END AS NodeSort_L05
    , CASE WHEN b.NodeID IS NULL THEN a.isLeaf ELSE b.isLeaf END AS isLeaf
    , CASE WHEN b.NodeID IS NULL THEN CAST(a.HierLevel AS smallint) ELSE CAST(b.HierLevel AS smallint) END AS HierLevel
    , b.NodeID_Join
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidFrom_L04 ELSE b.ValidFrom END AS ValidFrom_L05
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidTo_L04 ELSE b.ValidTo END AS ValidTo_L05
    --, CASE
    --  WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
    --    THEN ISNULL(a.ValidFrom, '10000101')
    --  ELSE ISNULL(b.ValidFrom, '10000101')
    --END AS ValidFrom
    --, CASE
    --  WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
    --    THEN ISNULL(a.ValidTo, '99991231')
    --  ELSE ISNULL(b.ValidTo, '99991231')
    --END AS ValidTo
  FROM HierLevel04 a LEFT OUTER JOIN Hier_HierLevel05 b ON (b.ParentID = a.NodeID_Join)
  --WHERE
  --  CASE
  --    WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
  --      THEN ISNULL(a.ValidFrom, '10000101')
  --    ELSE ISNULL(b.ValidFrom, '10000101')
  --  END
  --  <
  --  CASE
  --    WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
  --      THEN ISNULL(a.ValidTo, '99991231')
  --    ELSE ISNULL(b.ValidTo, '99991231')
  --  END
)

, HierLevel06 AS (
  SELECT
    a.NodeType_L01
    , a.NodeKey_L01
    , a.NodeDescShort_L01
    , a.NodeDescMedium_L01
    , a.NodeDescLong_L01
    , a.NodeSort_L01
    --, a.ValidFrom_L01
    --, a.ValidTo_L01
    , a.NodeType_L02
    , a.NodeKey_L02
    , a.NodeDescShort_L02
    , a.NodeDescMedium_L02
    , a.NodeDescLong_L02
    , a.NodeSort_L02
    --, a.ValidFrom_L02
    --, a.ValidTo_L02
    , a.NodeType_L03
    , a.NodeKey_L03
    , a.NodeDescShort_L03
    , a.NodeDescMedium_L03
    , a.NodeDescLong_L03
    , a.NodeSort_L03
    --, a.ValidFrom_L03
    --, a.ValidTo_L03
    , a.NodeType_L04
    , a.NodeKey_L04
    , a.NodeDescShort_L04
    , a.NodeDescMedium_L04
    , a.NodeDescLong_L04
    , a.NodeSort_L04
    --, a.ValidFrom_L04
    --, a.ValidTo_L04
    , a.NodeType_L05
    , a.NodeKey_L05
    , a.NodeDescShort_L05
    , a.NodeDescMedium_L05
    , a.NodeDescLong_L05
    , a.NodeSort_L05
    --, a.ValidFrom_L05
    --, a.ValidTo_L05
    , CASE WHEN b.NodeID IS NULL THEN a.NodeType_L05 ELSE b.[NodeType_KEY] END AS NodeType_L06
    , CASE WHEN b.NodeID IS NULL THEN a.NodeKey_L05 ELSE b.NodeName END AS NodeKey_L06
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescShort_L05 ELSE b.TextShort END AS NodeDescShort_L06
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescMedium_L05 ELSE b.TextMedium END AS NodeDescMedium_L06
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescLong_L05 ELSE b.TextLong END AS NodeDescLong_L06
    , a.Sort * 1000 + COALESCE(b.Sort, 0) AS Sort
    , a.Sort * 1000 + CASE WHEN b.NodeID IS NULL THEN 0 ELSE b.Sort END AS NodeSort_L06
    , CASE WHEN b.NodeID IS NULL THEN a.isLeaf ELSE b.isLeaf END AS isLeaf
    , CASE WHEN b.NodeID IS NULL THEN CAST(a.HierLevel AS smallint) ELSE CAST(b.HierLevel AS smallint) END AS HierLevel
    , b.NodeID_Join
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidFrom_L05 ELSE b.ValidFrom END AS ValidFrom_L06
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidTo_L05 ELSE b.ValidTo END AS ValidTo_L06
    --, CASE
    --  WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
    --    THEN ISNULL(a.ValidFrom, '10000101')
    --  ELSE ISNULL(b.ValidFrom, '10000101')
    --END AS ValidFrom
    --, CASE
    --  WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
    --    THEN ISNULL(a.ValidTo, '99991231')
    --  ELSE ISNULL(b.ValidTo, '99991231')
    --END AS ValidTo
  FROM HierLevel05 a LEFT OUTER JOIN Hier_HierLevel06 b ON (b.ParentID = a.NodeID_Join)
  --WHERE
  --  CASE
  --    WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
  --      THEN ISNULL(a.ValidFrom, '10000101')
  --    ELSE ISNULL(b.ValidFrom, '10000101')
  --  END
  --  <
  --  CASE
  --    WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
  --      THEN ISNULL(a.ValidTo, '99991231')
  --    ELSE ISNULL(b.ValidTo, '99991231')
  --  END
)

, HierLevel07 AS (
  SELECT
    a.NodeType_L01
    , a.NodeKey_L01
    , a.NodeDescShort_L01
    , a.NodeDescMedium_L01
    , a.NodeDescLong_L01
    , a.NodeSort_L01
    --, a.ValidFrom_L01
    --, a.ValidTo_L01
    , a.NodeType_L02
    , a.NodeKey_L02
    , a.NodeDescShort_L02
    , a.NodeDescMedium_L02
    , a.NodeDescLong_L02
    , a.NodeSort_L02
    --, a.ValidFrom_L02
    --, a.ValidTo_L02
    , a.NodeType_L03
    , a.NodeKey_L03
    , a.NodeDescShort_L03
    , a.NodeDescMedium_L03
    , a.NodeDescLong_L03
    , a.NodeSort_L03
    --, a.ValidFrom_L03
    --, a.ValidTo_L03
    , a.NodeType_L04
    , a.NodeKey_L04
    , a.NodeDescShort_L04
    , a.NodeDescMedium_L04
    , a.NodeDescLong_L04
    , a.NodeSort_L04
    --, a.ValidFrom_L04
    --, a.ValidTo_L04
    , a.NodeType_L05
    , a.NodeKey_L05
    , a.NodeDescShort_L05
    , a.NodeDescMedium_L05
    , a.NodeDescLong_L05
    , a.NodeSort_L05
    --, a.ValidFrom_L05
    --, a.ValidTo_L05
    , a.NodeType_L06
    , a.NodeKey_L06
    , a.NodeDescShort_L06
    , a.NodeDescMedium_L06
    , a.NodeDescLong_L06
    , a.NodeSort_L06
    --, a.ValidFrom_L06
    --, a.ValidTo_L06
    , CASE WHEN b.NodeID IS NULL THEN a.NodeType_L06 ELSE b.[NodeType_KEY] END AS NodeType_L07
    , CASE WHEN b.NodeID IS NULL THEN a.NodeKey_L06 ELSE b.NodeName END AS NodeKey_L07
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescShort_L06 ELSE b.TextShort END AS NodeDescShort_L07
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescMedium_L06 ELSE b.TextMedium END AS NodeDescMedium_L07
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescLong_L06 ELSE b.TextLong END AS NodeDescLong_L07
    , a.Sort * 1000 + COALESCE(b.Sort, 0) AS Sort
    , a.Sort * 1000 + CASE WHEN b.NodeID IS NULL THEN 0 ELSE b.Sort END AS NodeSort_L07
    , CASE WHEN b.NodeID IS NULL THEN a.isLeaf ELSE b.isLeaf END AS isLeaf
    , CASE WHEN b.NodeID IS NULL THEN CAST(a.HierLevel AS smallint) ELSE CAST(b.HierLevel AS smallint) END AS HierLevel
    , b.NodeID_Join
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidFrom_L06 ELSE b.ValidFrom END AS ValidFrom_L07
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidTo_L06 ELSE b.ValidTo END AS ValidTo_L07
    --, CASE
    --  WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
    --    THEN ISNULL(a.ValidFrom, '10000101')
    --  ELSE ISNULL(b.ValidFrom, '10000101')
    --END AS ValidFrom
    --, CASE
    --  WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
    --    THEN ISNULL(a.ValidTo, '99991231')
    --  ELSE ISNULL(b.ValidTo, '99991231')
    --END AS ValidTo
  FROM HierLevel06 a LEFT OUTER JOIN Hier_HierLevel07 b ON (b.ParentID = a.NodeID_Join)
  --WHERE
  --  CASE
  --    WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
  --      THEN ISNULL(a.ValidFrom, '10000101')
  --    ELSE ISNULL(b.ValidFrom, '10000101')
  --  END
  --  <
  --  CASE
  --    WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
  --      THEN ISNULL(a.ValidTo, '99991231')
  --    ELSE ISNULL(b.ValidTo, '99991231')
  --  END
)

, HierLevel08 AS (
  SELECT
    a.NodeType_L01
    , a.NodeKey_L01
    , a.NodeDescShort_L01
    , a.NodeDescMedium_L01
    , a.NodeDescLong_L01
    , a.NodeSort_L01
    --, a.ValidFrom_L01
    --, a.ValidTo_L01
    , a.NodeType_L02
    , a.NodeKey_L02
    , a.NodeDescShort_L02
    , a.NodeDescMedium_L02
    , a.NodeDescLong_L02
    , a.NodeSort_L02
    --, a.ValidFrom_L02
    --, a.ValidTo_L02
    , a.NodeType_L03
    , a.NodeKey_L03
    , a.NodeDescShort_L03
    , a.NodeDescMedium_L03
    , a.NodeDescLong_L03
    , a.NodeSort_L03
    --, a.ValidFrom_L03
    --, a.ValidTo_L03
    , a.NodeType_L04
    , a.NodeKey_L04
    , a.NodeDescShort_L04
    , a.NodeDescMedium_L04
    , a.NodeDescLong_L04
    , a.NodeSort_L04
    --, a.ValidFrom_L04
    --, a.ValidTo_L04
    , a.NodeType_L05
    , a.NodeKey_L05
    , a.NodeDescShort_L05
    , a.NodeDescMedium_L05
    , a.NodeDescLong_L05
    , a.NodeSort_L05
    --, a.ValidFrom_L05
    --, a.ValidTo_L05
    , a.NodeType_L06
    , a.NodeKey_L06
    , a.NodeDescShort_L06
    , a.NodeDescMedium_L06
    , a.NodeDescLong_L06
    , a.NodeSort_L06
    --, a.ValidFrom_L06
    --, a.ValidTo_L06
    , a.NodeType_L07
    , a.NodeKey_L07
    , a.NodeDescShort_L07
    , a.NodeDescMedium_L07
    , a.NodeDescLong_L07
    , a.NodeSort_L07
    --, a.ValidFrom_L07
    --, a.ValidTo_L07
    , CASE WHEN b.NodeID IS NULL THEN a.NodeType_L07 ELSE b.[NodeType_KEY] END AS NodeType_L08
    , CASE WHEN b.NodeID IS NULL THEN a.NodeKey_L07 ELSE b.NodeName END AS NodeKey_L08
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescShort_L07 ELSE b.TextShort END AS NodeDescShort_L08
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescMedium_L07 ELSE b.TextMedium END AS NodeDescMedium_L08
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescLong_L07 ELSE b.TextLong END AS NodeDescLong_L08
    , a.Sort * 1000 + COALESCE(b.Sort, 0) AS Sort
    , a.Sort * 1000 + CASE WHEN b.NodeID IS NULL THEN 0 ELSE b.Sort END AS NodeSort_L08
    , CASE WHEN b.NodeID IS NULL THEN a.isLeaf ELSE b.isLeaf END AS isLeaf
    , CASE WHEN b.NodeID IS NULL THEN CAST(a.HierLevel AS smallint) ELSE CAST(b.HierLevel AS smallint) END AS HierLevel
    , b.NodeID_Join
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidFrom_L07 ELSE b.ValidFrom END AS ValidFrom_L08
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidTo_L07 ELSE b.ValidTo END AS ValidTo_L08
    --, CASE
    --  WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
    --    THEN ISNULL(a.ValidFrom, '10000101')
    --  ELSE ISNULL(b.ValidFrom, '10000101')
    --END AS ValidFrom
    --, CASE
    --  WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
    --    THEN ISNULL(a.ValidTo, '99991231')
    --  ELSE ISNULL(b.ValidTo, '99991231')
    --END AS ValidTo
  FROM HierLevel07 a LEFT OUTER JOIN Hier_HierLevel08 b ON (b.ParentID = a.NodeID_Join)
  --WHERE
  --  CASE
  --    WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
  --      THEN ISNULL(a.ValidFrom, '10000101')
  --    ELSE ISNULL(b.ValidFrom, '10000101')
  --  END
  --  <
  --  CASE
  --    WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
  --      THEN ISNULL(a.ValidTo, '99991231')
  --    ELSE ISNULL(b.ValidTo, '99991231')
  --  END
)

, HierLevel09 AS (
  SELECT
    a.NodeType_L01
    , a.NodeKey_L01
    , a.NodeDescShort_L01
    , a.NodeDescMedium_L01
    , a.NodeDescLong_L01
    , a.NodeSort_L01
    --, a.ValidFrom_L01
    --, a.ValidTo_L01
    , a.NodeType_L02
    , a.NodeKey_L02
    , a.NodeDescShort_L02
    , a.NodeDescMedium_L02
    , a.NodeDescLong_L02
    , a.NodeSort_L02
    --, a.ValidFrom_L02
    --, a.ValidTo_L02
    , a.NodeType_L03
    , a.NodeKey_L03
    , a.NodeDescShort_L03
    , a.NodeDescMedium_L03
    , a.NodeDescLong_L03
    , a.NodeSort_L03
    --, a.ValidFrom_L03
    --, a.ValidTo_L03
    , a.NodeType_L04
    , a.NodeKey_L04
    , a.NodeDescShort_L04
    , a.NodeDescMedium_L04
    , a.NodeDescLong_L04
    , a.NodeSort_L04
    --, a.ValidFrom_L04
    --, a.ValidTo_L04
    , a.NodeType_L05
    , a.NodeKey_L05
    , a.NodeDescShort_L05
    , a.NodeDescMedium_L05
    , a.NodeDescLong_L05
    , a.NodeSort_L05
    --, a.ValidFrom_L05
    --, a.ValidTo_L05
    , a.NodeType_L06
    , a.NodeKey_L06
    , a.NodeDescShort_L06
    , a.NodeDescMedium_L06
    , a.NodeDescLong_L06
    , a.NodeSort_L06
    --, a.ValidFrom_L06
    --, a.ValidTo_L06
    , a.NodeType_L07
    , a.NodeKey_L07
    , a.NodeDescShort_L07
    , a.NodeDescMedium_L07
    , a.NodeDescLong_L07
    , a.NodeSort_L07
    --, a.ValidFrom_L07
    --, a.ValidTo_L07
    , a.NodeType_L08
    , a.NodeKey_L08
    , a.NodeDescShort_L08
    , a.NodeDescMedium_L08
    , a.NodeDescLong_L08
    , a.NodeSort_L08
    --, a.ValidFrom_L08
    --, a.ValidTo_L08
    , CASE WHEN b.NodeID IS NULL THEN a.NodeType_L08 ELSE b.[NodeType_KEY] END AS NodeType_L09
    , CASE WHEN b.NodeID IS NULL THEN a.NodeKey_L08 ELSE b.NodeName END AS NodeKey_L09
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescShort_L08 ELSE b.TextShort END AS NodeDescShort_L09
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescMedium_L08 ELSE b.TextMedium END AS NodeDescMedium_L09
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescLong_L08 ELSE b.TextLong END AS NodeDescLong_L09
    , a.Sort * 1000 + COALESCE(b.Sort, 0) AS Sort
    , a.Sort * 1000 + CASE WHEN b.NodeID IS NULL THEN 0 ELSE b.Sort END AS NodeSort_L09
    , CASE WHEN b.NodeID IS NULL THEN a.isLeaf ELSE b.isLeaf END AS isLeaf
    , CASE WHEN b.NodeID IS NULL THEN CAST(a.HierLevel AS smallint) ELSE CAST(b.HierLevel AS smallint) END AS HierLevel
    , b.NodeID_Join
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidFrom_L08 ELSE b.ValidFrom END AS ValidFrom_L09
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidTo_L08 ELSE b.ValidTo END AS ValidTo_L09
    --, CASE
    --  WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
    --    THEN ISNULL(a.ValidFrom, '10000101')
    --  ELSE ISNULL(b.ValidFrom, '10000101')
    --END AS ValidFrom
    --, CASE
    --  WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
    --    THEN ISNULL(a.ValidTo, '99991231')
    --  ELSE ISNULL(b.ValidTo, '99991231')
    --END AS ValidTo
  FROM HierLevel08 a LEFT OUTER JOIN Hier_HierLevel09 b ON (b.ParentID = a.NodeID_Join)
  --WHERE
  --  CASE
  --    WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
  --      THEN ISNULL(a.ValidFrom, '10000101')
  --    ELSE ISNULL(b.ValidFrom, '10000101')
  --  END
  --  <
  --  CASE
  --    WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
  --      THEN ISNULL(a.ValidTo, '99991231')
  --    ELSE ISNULL(b.ValidTo, '99991231')
  --  END
)

, HierLevel10 AS (
  SELECT
    a.NodeType_L01
    , a.NodeKey_L01
    , a.NodeDescShort_L01
    , a.NodeDescMedium_L01
    , a.NodeDescLong_L01
    , a.NodeSort_L01
    --, a.ValidFrom_L01
    --, a.ValidTo_L01
    , a.NodeType_L02
    , a.NodeKey_L02
    , a.NodeDescShort_L02
    , a.NodeDescMedium_L02
    , a.NodeDescLong_L02
    , a.NodeSort_L02
    --, a.ValidFrom_L02
    --, a.ValidTo_L02
    , a.NodeType_L03
    , a.NodeDescShort_L03
    , a.NodeDescMedium_L03
    , a.NodeDescLong_L03
    , a.NodeKey_L03
    , a.NodeSort_L03
    --, a.ValidFrom_L03
    --, a.ValidTo_L03
    , a.NodeType_L04
    , a.NodeKey_L04
    , a.NodeDescShort_L04
    , a.NodeDescMedium_L04
    , a.NodeDescLong_L04
    , a.NodeSort_L04
    --, a.ValidFrom_L04
    --, a.ValidTo_L04
    , a.NodeType_L05
    , a.NodeKey_L05
    , a.NodeDescShort_L05
    , a.NodeDescMedium_L05
    , a.NodeDescLong_L05
    , a.NodeSort_L05
    --, a.ValidFrom_L05
    --, a.ValidTo_L05
    , a.NodeType_L06
    , a.NodeKey_L06
    , a.NodeDescShort_L06
    , a.NodeDescMedium_L06
    , a.NodeDescLong_L06
    , a.NodeSort_L06
    --, a.ValidFrom_L06
    --, a.ValidTo_L06
    , a.NodeType_L07
    , a.NodeKey_L07
    , a.NodeDescShort_L07
    , a.NodeDescMedium_L07
    , a.NodeDescLong_L07
    , a.NodeSort_L07
    --, a.ValidFrom_L07
    --, a.ValidTo_L07
    , a.NodeType_L08
    , a.NodeKey_L08
    , a.NodeDescShort_L08
    , a.NodeDescMedium_L08
    , a.NodeDescLong_L08
    , a.NodeSort_L08
    --, a.ValidFrom_L08
    --, a.ValidTo_L08
    , a.NodeType_L09
    , a.NodeKey_L09
    , a.NodeDescShort_L09
    , a.NodeDescMedium_L09
    , a.NodeDescLong_L09
    , a.NodeSort_L09
    --, a.ValidFrom_L09
    --, a.ValidTo_L09
    , CASE WHEN b.NodeID IS NULL THEN a.NodeType_L09 ELSE b.[NodeType_KEY] END AS NodeType_L10
    , CASE WHEN b.NodeID IS NULL THEN a.NodeKey_L09 ELSE b.NodeName END AS NodeKey_L10
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescShort_L09 ELSE b.TextShort END AS NodeDescShort_L10
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescMedium_L09 ELSE b.TextMedium END AS NodeDescMedium_L10
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescLong_L09 ELSE b.TextLong END AS NodeDescLong_L10
    , a.Sort * 1000 + COALESCE(b.Sort, 0) AS Sort
    , a.Sort * 1000 + CASE WHEN b.NodeID IS NULL THEN 0 ELSE b.Sort END AS NodeSort_L10
    , CASE WHEN b.NodeID IS NULL THEN a.isLeaf ELSE b.isLeaf END AS isLeaf
    , CASE WHEN b.NodeID IS NULL THEN CAST(a.HierLevel AS smallint) ELSE CAST(b.HierLevel AS smallint) END AS HierLevel
    , b.NodeID_Join
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidFrom_L09 ELSE b.ValidFrom END AS ValidFrom_L10
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidTo_L09 ELSE b.ValidTo END AS ValidTo_L10
    --, CASE
    --  WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
    --    THEN ISNULL(a.ValidFrom, '10000101')
    --  ELSE ISNULL(b.ValidFrom, '10000101')
    --END AS ValidFrom
    --, CASE
    --  WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
    --    THEN ISNULL(a.ValidTo, '99991231')
    --  ELSE ISNULL(b.ValidTo, '99991231')
    --END AS ValidTo
  FROM HierLevel09 a LEFT OUTER JOIN Hier_HierLevel10 b ON (b.ParentID = a.NodeID_Join)
  --WHERE
  --  CASE
  --    WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
  --      THEN ISNULL(a.ValidFrom, '10000101')
  --    ELSE ISNULL(b.ValidFrom, '10000101')
  --  END
  --  <
  --  CASE
  --    WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
  --      THEN ISNULL(a.ValidTo, '99991231')
  --    ELSE ISNULL(b.ValidTo, '99991231')
  --  END
)

, HierLevel11 AS (
  SELECT
    a.NodeType_L01
    , a.NodeKey_L01
    , a.NodeDescShort_L01
    , a.NodeDescMedium_L01
    , a.NodeDescLong_L01
    , a.NodeSort_L01
    --, a.ValidFrom_L01
    --, a.ValidTo_L01
    , a.NodeType_L02
    , a.NodeKey_L02
    , a.NodeDescShort_L02
    , a.NodeDescMedium_L02
    , a.NodeDescLong_L02
    , a.NodeSort_L02
    --, a.ValidFrom_L02
    --, a.ValidTo_L02
    , a.NodeType_L03
    , a.NodeKey_L03
    , a.NodeDescShort_L03
    , a.NodeDescMedium_L03
    , a.NodeDescLong_L03
    , a.NodeSort_L03
    --, a.ValidFrom_L03
    --, a.ValidTo_L03
    , a.NodeType_L04
    , a.NodeKey_L04
    , a.NodeDescShort_L04
    , a.NodeDescMedium_L04
    , a.NodeDescLong_L04
    , a.NodeSort_L04
    --, a.ValidFrom_L04
    --, a.ValidTo_L04
    , a.NodeType_L05
    , a.NodeKey_L05
    , a.NodeDescShort_L05
    , a.NodeDescMedium_L05
    , a.NodeDescLong_L05
    , a.NodeSort_L05
    --, a.ValidFrom_L05
    --, a.ValidTo_L05
    , a.NodeType_L06
    , a.NodeKey_L06
    , a.NodeDescShort_L06
    , a.NodeDescMedium_L06
    , a.NodeDescLong_L06
    , a.NodeSort_L06
    --, a.ValidFrom_L06
    --, a.ValidTo_L06
    , a.NodeType_L07
    , a.NodeKey_L07
    , a.NodeDescShort_L07
    , a.NodeDescMedium_L07
    , a.NodeDescLong_L07
    , a.NodeSort_L07
    --, a.ValidFrom_L07
    --, a.ValidTo_L07
    , a.NodeType_L08
    , a.NodeKey_L08
    , a.NodeDescShort_L08
    , a.NodeDescMedium_L08
    , a.NodeDescLong_L08
    , a.NodeSort_L08
    --, a.ValidFrom_L08
    --, a.ValidTo_L08
    , a.NodeType_L09
    , a.NodeKey_L09
    , a.NodeDescShort_L09
    , a.NodeDescMedium_L09
    , a.NodeDescLong_L09
    , a.NodeSort_L09
    --, a.ValidFrom_L09
    --, a.ValidTo_L09
    , a.NodeType_L10
    , a.NodeKey_L10
    , a.NodeDescShort_L10
    , a.NodeDescMedium_L10
    , a.NodeDescLong_L10
    , a.NodeSort_L10
    --, a.ValidFrom_L10
    --, a.ValidTo_L10
    , CASE WHEN b.NodeID IS NULL THEN a.NodeType_L10 ELSE b.[NodeType_KEY] END AS NodeType_L11
    , CASE WHEN b.NodeID IS NULL THEN a.NodeKey_L10 ELSE b.NodeName END AS NodeKey_L11
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescShort_L10 ELSE b.TextShort END AS NodeDescShort_L11
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescMedium_L10 ELSE b.TextMedium END AS NodeDescMedium_L11
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescLong_L10 ELSE b.TextLong END AS NodeDescLong_L11
    , a.Sort * 1000 + COALESCE(b.Sort, 0) AS Sort
    , a.Sort * 1000 + CASE WHEN b.NodeID IS NULL THEN 0 ELSE b.Sort END AS NodeSort_L11
    , CASE WHEN b.NodeID IS NULL THEN a.isLeaf ELSE b.isLeaf END AS isLeaf
    , CASE WHEN b.NodeID IS NULL THEN CAST(a.HierLevel AS smallint) ELSE CAST(b.HierLevel AS smallint) END AS HierLevel
    , b.NodeID_Join
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidFrom_L10 ELSE b.ValidFrom END AS ValidFrom_L11
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidTo_L10 ELSE b.ValidTo END AS ValidTo_L11
    --, CASE
    --  WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
    --    THEN ISNULL(a.ValidFrom, '10000101')
    --  ELSE ISNULL(b.ValidFrom, '10000101')
    --END AS ValidFrom
    --, CASE
    --  WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
    --    THEN ISNULL(a.ValidTo, '99991231')
    --  ELSE ISNULL(b.ValidTo, '99991231')
    --END AS ValidTo
  FROM HierLevel10 a LEFT OUTER JOIN Hier_HierLevel11 b ON (b.ParentID = a.NodeID_Join)
  --WHERE
  --  CASE
  --    WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
  --      THEN ISNULL(a.ValidFrom, '10000101')
  --    ELSE ISNULL(b.ValidFrom, '10000101')
  --  END
  --  <
  --  CASE
  --    WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
  --      THEN ISNULL(a.ValidTo, '99991231')
  --    ELSE ISNULL(b.ValidTo, '99991231')
  --  END
)

, HierLevel12 AS (
  SELECT
    a.NodeType_L01
    , a.NodeKey_L01
    , a.NodeDescShort_L01
    , a.NodeDescMedium_L01
    , a.NodeDescLong_L01
    , a.NodeSort_L01
    --, a.ValidFrom_L01
    --, a.ValidTo_L01
    , a.NodeType_L02
    , a.NodeKey_L02
    , a.NodeDescShort_L02
    , a.NodeDescMedium_L02
    , a.NodeDescLong_L02
    , a.NodeSort_L02
    --, a.ValidFrom_L02
    --, a.ValidTo_L02
    , a.NodeType_L03
    , a.NodeKey_L03
    , a.NodeDescShort_L03
    , a.NodeDescMedium_L03
    , a.NodeDescLong_L03
    , a.NodeSort_L03
    --, a.ValidFrom_L03
    --, a.ValidTo_L03
    , a.NodeType_L04
    , a.NodeKey_L04
    , a.NodeDescShort_L04
    , a.NodeDescMedium_L04
    , a.NodeDescLong_L04
    , a.NodeSort_L04
    --, a.ValidFrom_L04
    --, a.ValidTo_L04
    , a.NodeType_L05
    , a.NodeKey_L05
    , a.NodeDescShort_L05
    , a.NodeDescMedium_L05
    , a.NodeDescLong_L05
    , a.NodeSort_L05
    --, a.ValidFrom_L05
    --, a.ValidTo_L05
    , a.NodeType_L06
    , a.NodeKey_L06
    , a.NodeDescShort_L06
    , a.NodeDescMedium_L06
    , a.NodeDescLong_L06
    , a.NodeSort_L06
    --, a.ValidFrom_L06
    --, a.ValidTo_L06
    , a.NodeType_L07
    , a.NodeKey_L07
    , a.NodeDescShort_L07
    , a.NodeDescMedium_L07
    , a.NodeDescLong_L07
    , a.NodeSort_L07
    --, a.ValidFrom_L07
    --, a.ValidTo_L07
    , a.NodeType_L08
    , a.NodeKey_L08
    , a.NodeDescShort_L08
    , a.NodeDescMedium_L08
    , a.NodeDescLong_L08
    , a.NodeSort_L08
    --, a.ValidFrom_L08
    --, a.ValidTo_L08
    , a.NodeType_L09
    , a.NodeKey_L09
    , a.NodeDescShort_L09
    , a.NodeDescMedium_L09
    , a.NodeDescLong_L09
    , a.NodeSort_L09
    --, a.ValidFrom_L09
    --, a.ValidTo_L09
    , a.NodeType_L10
    , a.NodeKey_L10
    , a.NodeDescShort_L10
    , a.NodeDescMedium_L10
    , a.NodeDescLong_L10
    , a.NodeSort_L10
    --, a.ValidFrom_L10
    --, a.ValidTo_L10
    , a.NodeType_L11
    , a.NodeKey_L11
    , a.NodeDescShort_L11
    , a.NodeDescMedium_L11
    , a.NodeDescLong_L11
    , a.NodeSort_L11
    --, a.ValidFrom_L11
    --, a.ValidTo_L11
    , CASE WHEN b.NodeID IS NULL THEN a.NodeType_L11 ELSE b.[NodeType_KEY] END AS NodeType_L12
    , CASE WHEN b.NodeID IS NULL THEN a.NodeKey_L11 ELSE b.NodeName END AS NodeKey_L12
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescShort_L11 ELSE b.TextShort END AS NodeDescShort_L12
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescMedium_L11 ELSE b.TextMedium END AS NodeDescMedium_L12
    , CASE WHEN b.NodeID IS NULL THEN a.NodeDescLong_L11 ELSE b.TextLong END AS NodeDescLong_L12
    , a.Sort * 1000 + COALESCE(b.Sort, 0) AS Sort
    , a.Sort * 1000 + CASE WHEN b.NodeID IS NULL THEN 0 ELSE b.Sort END AS NodeSort_L12
    , CASE WHEN b.NodeID IS NULL THEN a.isLeaf ELSE 1 END AS isLeaf
    , CASE WHEN b.NodeID IS NULL THEN CAST(a.HierLevel AS smallint) ELSE CAST(b.HierLevel AS smallint) END AS HierLevel
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidFrom_L11 ELSE b.ValidFrom END AS ValidFrom_L12
    --, CASE WHEN b.NodeID IS NULL THEN a.ValidTo_L11 ELSE b.ValidTo END AS ValidTo_L12
    --, CASE
    --  WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
    --    THEN ISNULL(a.ValidFrom, '10000101')
    --  ELSE ISNULL(b.ValidFrom, '10000101')
    --END AS ValidFrom
    --, CASE
    --  WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
    --    THEN ISNULL(a.ValidTo, '99991231')
    --  ELSE ISNULL(b.ValidTo, '99991231')
    --END AS ValidTo
  FROM HierLevel11 a LEFT OUTER JOIN Hier_HierLevel12 b ON (b.ParentID = a.NodeID_Join)
  --WHERE
  --  CASE
  --    WHEN ISNULL(a.ValidFrom, '10000101') > ISNULL(b.ValidFrom, '10000101')
  --      THEN ISNULL(a.ValidFrom, '10000101')
  --    ELSE ISNULL(b.ValidFrom, '10000101')
  --  END
  --  <
  --  CASE
  --    WHEN ISNULL(a.ValidTo, '99991231') < ISNULL(b.ValidTo, '99991231')
  --      THEN ISNULL(a.ValidTo, '99991231')
  --    ELSE ISNULL(b.ValidTo, '99991231')
  --  END
)

SELECT
  -- nodes in a hierarchy are not necessarily unique. For example in SAP the GL Account hierarchy has a
  -- PLUMI (plus minus indicator). This is used to differentiate between assets and liabilities.
  -- in general we assume those accounts to be positive and thus on the asset side. Thus, we sort by the
  -- sort to always get the first node in a breadth-first search.
  ROW_NUMBER() OVER (PARTITION BY l.[NodeKey_L12], l.[NodeType_L12] ORDER BY l.[NodeSort_L12] ASC) AS [r]
  --, l.[ValidFrom] AS [HIER_GENERIC_ValidFrom]
  --, l.[ValidTo] AS [HIER_GENERIC_ValidTo]
  , l.[NodeKey_L12] AS [HIER_GENERIC_Key]
  , l.[HierLevel] AS [HIER_GENERIC_Level]
  , l.[isLeaf] AS [HIER_GENERIC_IsLeaf]
  , CAST(l.[NodeSort_L12] AS numeric(36, 0)) AS [HIER_GENERIC_Sort]
  , l.[NodeKey_L01] AS [HIER_GENERIC_NodeKey_L01]
  , l.[NodeDescShort_L01] AS [HIER_GENERIC_NodeDescShort_L01]
  , l.[NodeDescMedium_L01] AS [HIER_GENERIC_NodeDescMedium_L01]
  , l.[NodeDescLong_L01] AS [HIER_GENERIC_NodeDescLong_L01]
  , CAST(l.[NodeSort_L01] AS numeric(36, 0)) AS [HIER_GENERIC_NodeSort_L01]
  , l.[NodeKey_L02] AS [HIER_GENERIC_NodeKey_L02]
  , l.[NodeDescShort_L02] AS [HIER_GENERIC_NodeDescShort_L02]
  , l.[NodeDescMedium_L02] AS [HIER_GENERIC_NodeDescMedium_L02]
  , l.[NodeDescLong_L02] AS [HIER_GENERIC_NodeDescLong_L02]
  , CAST(l.[NodeSort_L02] AS numeric(36, 0)) AS [HIER_GENERIC_NodeSort_L02]
  , l.[NodeKey_L03] AS [HIER_GENERIC_NodeKey_L03]
  , l.[NodeDescShort_L03] AS [HIER_GENERIC_NodeDescShort_L03]
  , l.[NodeDescMedium_L03] AS [HIER_GENERIC_NodeDescMedium_L03]
  , l.[NodeDescLong_L03] AS [HIER_GENERIC_NodeDescLong_L03]
  , CAST(l.[NodeSort_L03] AS numeric(36, 0)) AS [HIER_GENERIC_NodeSort_L03]
  , l.[NodeKey_L04] AS [HIER_GENERIC_NodeKey_L04]
  , l.[NodeDescShort_L04] AS [HIER_GENERIC_NodeDescShort_L04]
  , l.[NodeDescMedium_L04] AS [HIER_GENERIC_NodeDescMedium_L04]
  , l.[NodeDescLong_L04] AS [HIER_GENERIC_NodeDescLong_L04]
  , CAST(l.[NodeSort_L04] AS numeric(36, 0)) AS [HIER_GENERIC_NodeSort_L04]
  , l.[NodeKey_L05] AS [HIER_GENERIC_NodeKey_L05]
  , l.[NodeDescShort_L05] AS [HIER_GENERIC_NodeDescShort_L05]
  , l.[NodeDescMedium_L05] AS [HIER_GENERIC_NodeDescMedium_L05]
  , l.[NodeDescLong_L05] AS [HIER_GENERIC_NodeDescLong_L05]
  , CAST(l.[NodeSort_L05] AS numeric(36, 0)) AS [HIER_GENERIC_NodeSort_L05]
  , l.[NodeKey_L06] AS [HIER_GENERIC_NodeKey_L06]
  , l.[NodeDescShort_L06] AS [HIER_GENERIC_NodeDescShort_L06]
  , l.[NodeDescMedium_L06] AS [HIER_GENERIC_NodeDescMedium_L06]
  , l.[NodeDescLong_L06] AS [HIER_GENERIC_NodeDescLong_L06]
  , CAST(l.[NodeSort_L06] AS numeric(36, 0)) AS [HIER_GENERIC_NodeSort_L06]
  , l.[NodeKey_L07] AS [HIER_GENERIC_NodeKey_L07]
  , l.[NodeDescShort_L07] AS [HIER_GENERIC_NodeDescShort_L07]
  , l.[NodeDescMedium_L07] AS [HIER_GENERIC_NodeDescMedium_L07]
  , l.[NodeDescLong_L07] AS [HIER_GENERIC_NodeDescLong_L07]
  , CAST(l.[NodeSort_L07] AS numeric(36, 0)) AS [HIER_GENERIC_NodeSort_L07]
  , l.[NodeKey_L08] AS [HIER_GENERIC_NodeKey_L08]
  , l.[NodeDescShort_L08] AS [HIER_GENERIC_NodeDescShort_L08]
  , l.[NodeDescMedium_L08] AS [HIER_GENERIC_NodeDescMedium_L08]
  , l.[NodeDescLong_L08] AS [HIER_GENERIC_NodeDescLong_L08]
  , CAST(l.[NodeSort_L08] AS numeric(36, 0)) AS [HIER_GENERIC_NodeSort_L08]
  , l.[NodeKey_L09] AS [HIER_GENERIC_NodeKey_L09]
  , l.[NodeDescShort_L09] AS [HIER_GENERIC_NodeDescShort_L09]
  , l.[NodeDescMedium_L09] AS [HIER_GENERIC_NodeDescMedium_L09]
  , l.[NodeDescLong_L09] AS [HIER_GENERIC_NodeDescLong_L09]
  , CAST(l.[NodeSort_L09] AS numeric(36, 0)) AS [HIER_GENERIC_NodeSort_L09]
  , l.[NodeKey_L10] AS [HIER_GENERIC_NodeKey_L10]
  , l.[NodeDescShort_L10] AS [HIER_GENERIC_NodeDescShort_L10]
  , l.[NodeDescMedium_L10] AS [HIER_GENERIC_NodeDescMedium_L10]
  , l.[NodeDescLong_L10] AS [HIER_GENERIC_NodeDescLong_L10]
  , CAST(l.[NodeSort_L10] AS numeric(36, 0)) AS [HIER_GENERIC_NodeSort_L10]
  , l.[NodeKey_L11] AS [HIER_GENERIC_NodeKey_L11]
  , l.[NodeDescShort_L11] AS [HIER_GENERIC_NodeDescShort_L11]
  , l.[NodeDescMedium_L11] AS [HIER_GENERIC_NodeDescMedium_L11]
  , l.[NodeDescLong_L11] AS [HIER_GENERIC_NodeDescLong_L11]
  , CAST(l.[NodeSort_L11] AS numeric(36, 0)) AS [HIER_GENERIC_NodeSort_L11]
  , l.[NodeType_L12] AS [HIER_GENERIC_NodeType_L12]
  , l.[NodeKey_L12] AS [HIER_GENERIC_NodeKey_L12]
  , l.[NodeDescShort_L12] AS [HIER_GENERIC_NodeDescShort_L12]
  , l.[NodeDescMedium_L12] AS [HIER_GENERIC_NodeDescMedium_L12]
  , l.[NodeDescLong_L12] AS [HIER_GENERIC_NodeDescLong_L12]
  , CAST(l.[NodeSort_L12] AS numeric(36, 0)) AS [HIER_GENERIC_NodeSort_L12]
FROM HierLevel12 l
--CROSS JOIN [INTERNAL_LOOKUP].[getKey_Date_Max]() [getKey_Date_Max]
--WHERE
--  -- only current version! (no history)
--  l.[ValidTo] = [getKey_Date_Max].[returnDate]
