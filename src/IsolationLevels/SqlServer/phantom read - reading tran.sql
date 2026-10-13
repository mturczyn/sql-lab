-- Assumed model

--CREATE TABLE [dbo].[TestEntities](
--	[Id] [uniqueidentifier] NOT NULL,
--	[Name] [nvarchar](max) NOT NULL,
-- CONSTRAINT [PK_TestEntities] PRIMARY KEY CLUSTERED 
--(
--	[Id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
--) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

--ALTER DATABASE TestDb
--SET ALLOW_SNAPSHOT_ISOLATION OFF

--ALTER DATABASE TestDb
--SET READ_COMMITTED_SNAPSHOT ON

/* PHANTOM READS */
/* solution: change to SERIALIZABLE, REPEATABLE READ won't prevent this  */
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

declare @tokenToSearchBy nvarchar(max) = 'phantom reads !@#!@#'

begin tran 

select * from TestEntities where charindex(@tokenToSearchBy, name) > 0

-- somewhere here update to records should happen in order to present issue
waitfor delay '00:00:05'

select * from TestEntities where charindex(@tokenToSearchBy, name) > 0

commit tran 

