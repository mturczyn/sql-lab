-- Assumed model

--CREATE TABLE [dbo].[TestEntities](
--	[Id] [uniqueidentifier] NOT NULL,
--	[Name] [nvarchar](max) NOT NULL,
-- CONSTRAINT [PK_TestEntities] PRIMARY KEY CLUSTERED 
--(
--	[Id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
--) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/* NONREPEATABLE READS */

declare @tokenToSearchBy nvarchar(max) = '' -- must allow unique identification by other transaction

begin tran updateTransaction

update top (1) TestEntities set 
	[name] = cast(SYSDATETIME() as nvarchar(max)) + @tokenToSearchBy

commit tran 
