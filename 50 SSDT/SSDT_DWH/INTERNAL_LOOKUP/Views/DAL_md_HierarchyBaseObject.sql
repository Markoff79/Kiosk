CREATE VIEW [INTERNAL_LOOKUP].[DAL_md_HierarchyBaseObject] AS
/*

    Author:           noventum consulting GmbH

    Description:      add all hierarchy bases here

    Parameters:       (none)

    Execution Sample:
                      SELECT * FROM [INTERNAL_LOOKUP].[DAL_md_HierarchyBaseObject]

*/
SELECT * FROM [INTERNAL_LOOKUP].[DAL_SAP_md_0GL_ACCOUNT_T011_HIER_INT] -- noqa: AM04
