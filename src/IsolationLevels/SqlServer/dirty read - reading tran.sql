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

/* DIRTY READS EXAMPLE */
/* change to READ COMMITTED to fix this isue */
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

declare @tokenToSearchBy nvarchar(max) = 'dirtyReadToken##!@'

begin tran dirtyReadTransaction

select * from TestEntities where charindex(@tokenToSearchBy, name) > 0

-- here should happen update of some records to present the issue
waitfor delay '00:00:05'

select * from TestEntities where charindex(@tokenToSearchBy, name) > 0

commit tran 

