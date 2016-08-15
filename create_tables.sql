USE [rent]
GO

/****** Object:  Table [dbo].[apts]    Script Date: 8/13/2016 1:23:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

select * from apts

drop table cost
drop table rooms
drop table apts
drop table companies

CREATE TABLE [dbo].[companies](
	[id] [uniqueidentifier] NOT NULL DEFAULT (NEWID()),
	[company] [nvarchar](512) NOT NULL,
	[url] [nvarchar](MAX) NOT NULL,
	CONSTRAINT [PK_companies] PRIMARY KEY CLUSTERED ([id]),
)


CREATE TABLE [dbo].[apts](
	[id] [uniqueidentifier] NOT NULL DEFAULT (NEWID()),
	[company_id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](512) NOT NULL,
	[address] [nvarchar](1024) NULL,
	[city] [nvarchar](512) NULL,
	[zipcode] [nchar](10) NULL,
	[date_created] [datetime2] NOT NULL DEFAULT(GETUTCDATE()),
	[url] [nvarchar](MAX) NOT NULL,
	CONSTRAINT [PK_apts] PRIMARY KEY CLUSTERED ([id]),
	CONSTRAINT [FK_companies] FOREIGN KEY ([company_id]) REFERENCES [dbo].[companies] ([id]),
)


CREATE TABLE [dbo].[rooms](
	[id] [uniqueidentifier] NOT NULL DEFAULT (NEWID()),
	[apt_id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](512) NOT NULL,
	[unit_code] [nvarchar](512) NULL,
	[unit_type_floor_plan_name] [nvarchar](512) NULL,
	[floor_plan_code] [nvarchar](512) NULL,
	[make_ready_date] [nvarchar](512) NULL,
	[beds] [int] NOT NULL,
	[bath] [float] NOT NULL,
	[square_feet] [int] NOT NULL,
	[date_created] [datetime2] NOT NULL DEFAULT(GETUTCDATE()),
	[amenities] [nvarchar](MAX) NULL,
	CONSTRAINT [PK_rooms] PRIMARY KEY CLUSTERED ([id]),
	CONSTRAINT [FK_apt_id] FOREIGN KEY ([apt_id]) REFERENCES [dbo].[apts] ([id]),
)

GO



CREATE TABLE [dbo].[cost](
	[id] [uniqueidentifier] NOT NULL DEFAULT (NEWID()),
	[room_id] [uniqueidentifier] NOT NULL,
	[cost] [money] NOT NULL,
	[cost_sq_ft] [money] NOT NULL,
	[available_date] [datetime2] NOT NULL,
	[date_created] [datetime2] NOT NULL DEFAULT(GETUTCDATE()),
	[amenities] [nvarchar](MAX) NULL,
	CONSTRAINT [PK_cost] PRIMARY KEY CLUSTERED ([id]),
	CONSTRAINT [FK_cost_id] FOREIGN KEY ([room_id]) REFERENCES [dbo].[cost] ([id]),
)

GO


USE [rent]
GO

INSERT INTO [dbo].[companies]
           (
		   [company]
           ,[url])
     VALUES
           ('essex',
           'http://www.essexapartmenthomes.com/washington/seattle-area-apartments/')
GO



ALTER TABLE [dbo].[apts] ADD  CONSTRAINT [DF_apts_id]  DEFAULT (newid()) FOR [id]
GO


    [next_successor]                            INT                 NOT NULL DEFAULT 0,
    [create_time]                               DATETIME2 (7)       DEFAULT (getutcdate()) NOT NULL,
    [last_update_time]                          DATETIME2 (7)       DEFAULT (getutcdate()) NOT NULL,
    [last_state_change_time]                    DATETIME2 (7)       DEFAULT (getutcdate()) NOT NULL,
    [concurrency_token]                         BIGINT              NOT NULL,
    [last_exception]                            XML                 NULL,
    [is_stable_state]                           BIT                 NULL,
    [is_error_state]                            BIT                 NULL,
    [fsm_extension_data]                        XML                 NULL,
    [fsm_version]                               INT                 NULL,
    [fsm_instance_id]                           UNIQUEIDENTIFIER    NOT NULL DEFAULT(NEWID()),
    [fsm_context_instance_name]                 NVARCHAR(64)        NULL,
    [fsm_timer_event_version]                   INT                 NULL,
    CONSTRAINT [PK_external_custom_secrets] PRIMARY KEY CLUSTERED ([logical_server_name], [logical_database_id], [secret_type], [external_custom_secret_details_id]),
    CONSTRAINT [FK_external_custom_secrets_details] FOREIGN KEY ([external_custom_secret_details_id]) REFERENCES [dbo].[tbl_external_custom_secret_details] ([external_custom_secret_details_id]),