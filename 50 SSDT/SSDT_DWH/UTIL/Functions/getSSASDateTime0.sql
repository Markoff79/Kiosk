CREATE FUNCTION [UTIL].[getSSASDateTime0]
(
  -- Add the parameters for the function here
  @DateTime7 datetime2(7)
)
RETURNS TABLE
WITH SCHEMABINDING
AS
/*

    Author:                     Daniel Christoph
    Create date:                2020-09-10
    Revision History:           yyyy-mm-dd Revisor
                                    DescriptionOfChanges

    Description:                Some front end tools can't interpret milliseconds of data type DateTime correctly (i.e. '2019-06-05 23:59:59.9900000' will be formatted and displayed as '2019-07-01 00:00:00' in some cases).
                                This function cuts off the milliseconds in order to avoid the automatic rounding of miliseconds resulting in wrong dates being displayed in front end tools.

    Execution Sample:
                                SELECT [UTIL].[getSSASDateTime0]([UTIL].[getEndOfDayDateTime7](GETDATE()))

*/
RETURN
SELECT CAST(DATEADD(MILLISECOND, -DATEPART(MILLISECOND, @DateTime7), @DateTime7) AS datetime2(0))
  AS returnValue
