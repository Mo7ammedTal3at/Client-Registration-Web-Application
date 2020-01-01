
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 12/31/2019 01:40:30
-- Generated from EDMX file: E:\mohamed\Projects\asp projects\WebApplication1\Domain\RegisterationdataModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [ClientRegistrationDB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[NG_User].[FK__Confirms__UserId__3D2915A8]', 'F') IS NOT NULL
    ALTER TABLE [NG_User].[Confirms] DROP CONSTRAINT [FK__Confirms__UserId__3D2915A8];
GO
IF OBJECT_ID(N'[NG_User].[FK_Users_Countries]', 'F') IS NOT NULL
    ALTER TABLE [NG_User].[Users] DROP CONSTRAINT [FK_Users_Countries];
GO
IF OBJECT_ID(N'[NG_User].[FK_Users_Jobs]', 'F') IS NOT NULL
    ALTER TABLE [NG_User].[Users] DROP CONSTRAINT [FK_Users_Jobs];
GO
IF OBJECT_ID(N'[NG_User].[FK_Users_Nationalities]', 'F') IS NOT NULL
    ALTER TABLE [NG_User].[Users] DROP CONSTRAINT [FK_Users_Nationalities];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[NG_User].[Bookings]', 'U') IS NOT NULL
    DROP TABLE [NG_User].[Bookings];
GO
IF OBJECT_ID(N'[NG_User].[Confirms]', 'U') IS NOT NULL
    DROP TABLE [NG_User].[Confirms];
GO
IF OBJECT_ID(N'[NG_User].[Countries]', 'U') IS NOT NULL
    DROP TABLE [NG_User].[Countries];
GO
IF OBJECT_ID(N'[NG_User].[Jobs]', 'U') IS NOT NULL
    DROP TABLE [NG_User].[Jobs];
GO
IF OBJECT_ID(N'[NG_User].[Nationalities]', 'U') IS NOT NULL
    DROP TABLE [NG_User].[Nationalities];
GO
IF OBJECT_ID(N'[NG_User].[Users]', 'U') IS NOT NULL
    DROP TABLE [NG_User].[Users];
GO
IF OBJECT_ID(N'[NativeGuestModelStoreContainer].[API]', 'U') IS NOT NULL
    DROP TABLE [NativeGuestModelStoreContainer].[API];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Bookings'
CREATE TABLE [dbo].[Bookings] (
    [RSN] int IDENTITY(1,1) NOT NULL,
    [UserID] int  NOT NULL,
    [GuestID] int  NULL,
    [BookingDTime] datetime  NOT NULL,
    [GuestDTime] nvarchar(50)  NOT NULL,
    [Token] varchar(max)  NOT NULL,
    [SessionTitle] varchar(50)  NOT NULL,
    [SessionID] varchar(200)  NULL,
    [Live] char(1)  NOT NULL,
    [isDone] char(1)  NOT NULL
);
GO

-- Creating table 'Confirms'
CREATE TABLE [dbo].[Confirms] (
    [Id] int  NOT NULL,
    [UserId] int  NOT NULL,
    [code] varchar(15)  NOT NULL,
    [confirmed] bit  NULL
);
GO

-- Creating table 'Countries'
CREATE TABLE [dbo].[Countries] (
    [CountryID] int IDENTITY(1,1) NOT NULL,
    [Country1] varchar(50)  NOT NULL,
    [FlagURL] varchar(150)  NULL
);
GO

-- Creating table 'Jobs'
CREATE TABLE [dbo].[Jobs] (
    [JobCode] int  NOT NULL,
    [JobTitle] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'Nationalities'
CREATE TABLE [dbo].[Nationalities] (
    [NationalityID] int IDENTITY(1,1) NOT NULL,
    [Nationality1] varchar(50)  NOT NULL
);
GO

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [UserID] int IDENTITY(1,1) NOT NULL,
    [FName] nvarchar(50)  NOT NULL,
    [LName] nvarchar(50)  NOT NULL,
    [Username] varchar(20)  NOT NULL,
    [Password] varchar(10)  NOT NULL,
    [Email] varchar(100)  NOT NULL,
    [Phone] char(12)  NOT NULL,
    [CountryID] int  NOT NULL,
    [DOB] datetime  NULL,
    [NationalityID] int  NOT NULL,
    [Gender] char(1)  NULL,
    [JobCode] int  NOT NULL,
    [isAdmin] char(1)  NOT NULL,
    [isGuest] char(1)  NULL,
    [SchoolName] nvarchar(50)  NULL,
    [TimeZone] varchar(150)  NULL,
    [DeviceToken] varchar(500)  NULL
);
GO

-- Creating table 'APIs'
CREATE TABLE [dbo].[APIs] (
    [API_Pass] nvarchar(50)  NOT NULL,
    [API_Key] varchar(10)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [RSN] in table 'Bookings'
ALTER TABLE [dbo].[Bookings]
ADD CONSTRAINT [PK_Bookings]
    PRIMARY KEY CLUSTERED ([RSN] ASC);
GO

-- Creating primary key on [Id] in table 'Confirms'
ALTER TABLE [dbo].[Confirms]
ADD CONSTRAINT [PK_Confirms]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [CountryID] in table 'Countries'
ALTER TABLE [dbo].[Countries]
ADD CONSTRAINT [PK_Countries]
    PRIMARY KEY CLUSTERED ([CountryID] ASC);
GO

-- Creating primary key on [JobCode] in table 'Jobs'
ALTER TABLE [dbo].[Jobs]
ADD CONSTRAINT [PK_Jobs]
    PRIMARY KEY CLUSTERED ([JobCode] ASC);
GO

-- Creating primary key on [NationalityID] in table 'Nationalities'
ALTER TABLE [dbo].[Nationalities]
ADD CONSTRAINT [PK_Nationalities]
    PRIMARY KEY CLUSTERED ([NationalityID] ASC);
GO

-- Creating primary key on [UserID] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([UserID] ASC);
GO

-- Creating primary key on [API_Pass], [API_Key] in table 'APIs'
ALTER TABLE [dbo].[APIs]
ADD CONSTRAINT [PK_APIs]
    PRIMARY KEY CLUSTERED ([API_Pass], [API_Key] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [UserId] in table 'Confirms'
ALTER TABLE [dbo].[Confirms]
ADD CONSTRAINT [FK__Confirms__UserId__3D2915A8]
    FOREIGN KEY ([UserId])
    REFERENCES [dbo].[Users]
        ([UserID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__Confirms__UserId__3D2915A8'
CREATE INDEX [IX_FK__Confirms__UserId__3D2915A8]
ON [dbo].[Confirms]
    ([UserId]);
GO

-- Creating foreign key on [CountryID] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [FK_Users_Countries]
    FOREIGN KEY ([CountryID])
    REFERENCES [dbo].[Countries]
        ([CountryID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Users_Countries'
CREATE INDEX [IX_FK_Users_Countries]
ON [dbo].[Users]
    ([CountryID]);
GO

-- Creating foreign key on [JobCode] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [FK_Users_Jobs]
    FOREIGN KEY ([JobCode])
    REFERENCES [dbo].[Jobs]
        ([JobCode])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Users_Jobs'
CREATE INDEX [IX_FK_Users_Jobs]
ON [dbo].[Users]
    ([JobCode]);
GO

-- Creating foreign key on [NationalityID] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [FK_Users_Nationalities]
    FOREIGN KEY ([NationalityID])
    REFERENCES [dbo].[Nationalities]
        ([NationalityID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Users_Nationalities'
CREATE INDEX [IX_FK_Users_Nationalities]
ON [dbo].[Users]
    ([NationalityID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------