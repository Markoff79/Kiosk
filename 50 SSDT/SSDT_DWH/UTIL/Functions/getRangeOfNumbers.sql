-- =============================================
-- Author:        Felix Möller
-- Create date: <Create Date, ,>
-- Description:    Returns a table with integer values from @start up to @end
-- =============================================
CREATE FUNCTION [UTIL].[getRangeOfNumbers]
(
  -- Add the parameters for the function here
  @start INT = 0
  , @end INT = 0
)
RETURNS TABLE
AS
RETURN (
  WITH t AS (
    SELECT *
    FROM (
      VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9)
    ) t(d)
  )

  SELECT CAST(r AS INT) AS n
  FROM (
    SELECT ROW_NUMBER() OVER (PARTITION BY NULL ORDER BY t.d) + @start - 1 AS r
    FROM t
        , t t1
        , t t2
        , t t3
        , t t4
        , t t5
    ) i
  WHERE
    r BETWEEN @start AND @end
)
