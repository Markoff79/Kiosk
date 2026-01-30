CREATE VIEW [INTERNAL_LOOKUP].[DIL_md_HierarchyInfoObject] AS
/*

    Author:           noventum consulting GmbH

    Description:      add all hierarchy descriptions here

    Parameters:       (none)

    Execution Sample:
                      SELECT * FROM [INTERNAL_LOOKUP].[DIL_md_HierarchyInfoObject]

*/
SELECT * FROM [INTERNAL_LOOKUP].[DIL_md_GLAccountHierarchy] -- noqa: AM04
