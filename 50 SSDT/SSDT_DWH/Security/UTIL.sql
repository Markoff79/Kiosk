CREATE SCHEMA [UTIL]
AUTHORIZATION [dbo];






GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Schema is used for internal infrastructure', @level0type = N'SCHEMA', @level0name = N'UTIL';
