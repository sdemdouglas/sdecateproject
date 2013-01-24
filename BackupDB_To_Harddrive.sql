
declare @title varchar(255)

select @title='\\lowryxpmis\backuptemp$\Sctcs_epms_Database'+ convert(varchar, GETDATE(), 112)+ '.bak' 

BACKUP DATABASE [sctcs_epms] to disk = @title


declare @title1 varchar(255)

select @title1='\\lowryxpmis\backuptemp$\aspnetdb_Database'+ convert(varchar, GETDATE(), 112)+ '.bak' 

BACKUP DATABASE aspnetdb to disk = @title1



declare @title2 varchar(255)

select @title2='\\lowryxpmis\backuptemp$\sctcs_eleave_Database'+ convert(varchar, GETDATE(), 112)+ '.bak' 

BACKUP DATABASE sctcs_eleave to disk = @title2




declare @title3 varchar(255)

select @title3='\\lowryxpmis\backuptemp$\sctcs_perkins_dev'+ convert(varchar, GETDATE(), 112)+ '.bak' 

BACKUP DATABASE [sctcs_perkins_dev] TO  DISK = @title3



declare @title4 varchar(255)

select @title4='\\lowryxpmis\backuptemp$\cert_approval'+ convert(varchar, GETDATE(), 112)+ '.bak' 

BACKUP DATABASE [cert_approval] TO  DISK = @title4