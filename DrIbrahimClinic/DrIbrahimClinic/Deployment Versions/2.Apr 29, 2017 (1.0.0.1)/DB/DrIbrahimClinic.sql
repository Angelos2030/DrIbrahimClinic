USE [master]
GO
/****** Object:  Database [DrIbrahimClinic]    Script Date: 4/26/2017 10:41:35 PM ******/
CREATE DATABASE [DrIbrahimClinic]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DrIbrahimClinic', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\DrIbrahimClinic.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DrIbrahimClinic_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\DrIbrahimClinic_log.ldf' , SIZE = 2560KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DrIbrahimClinic].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DrIbrahimClinic] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET ARITHABORT OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [DrIbrahimClinic] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DrIbrahimClinic] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DrIbrahimClinic] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DrIbrahimClinic] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DrIbrahimClinic] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET RECOVERY FULL 
GO
ALTER DATABASE [DrIbrahimClinic] SET  MULTI_USER 
GO
ALTER DATABASE [DrIbrahimClinic] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DrIbrahimClinic] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DrIbrahimClinic] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DrIbrahimClinic] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
USE [DrIbrahimClinic]
GO
/****** Object:  StoredProcedure [dbo].[ResetDB]    Script Date: 4/26/2017 10:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ResetDB]
AS
BEGIN
	--delete all records
	--use truncate instead (ry7 dma8k ;) :D )
	--reset identity
	DBCC CHECKIDENT('Examinations', RESEED, 0);
	DBCC CHECKIDENT('ExaminationSign', RESEED, 0);
	DBCC CHECKIDENT('ExaminationSymptom', RESEED, 0);
	DBCC CHECKIDENT('ExaminationTreatment', RESEED, 0);
	DBCC CHECKIDENT('Patients', RESEED, 0);
	DBCC CHECKIDENT('Signs', RESEED, 0);
	DBCC CHECKIDENT('Symptoms', RESEED, 0);
	DBCC CHECKIDENT('Treatments', RESEED, 0);
END

GO
/****** Object:  Table [dbo].[Diagnosis]    Script Date: 4/26/2017 10:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Diagnosis](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Signs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExaminationDiagnosis]    Script Date: 4/26/2017 10:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExaminationDiagnosis](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExaminationId] [int] NOT NULL,
	[DisgnosisId] [int] NOT NULL,
 CONSTRAINT [PK_ExaminationSign] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Examinations]    Script Date: 4/26/2017 10:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Examinations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[ExaminationType] [tinyint] NOT NULL,
	[Complaint] [nvarchar](max) NOT NULL,
	[PatientLength] [float] NOT NULL,
	[PatientWeight] [float] NOT NULL,
	[PatientHeadCircumference] [float] NOT NULL,
 CONSTRAINT [PK_Examination] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExaminationTreatment]    Script Date: 4/26/2017 10:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExaminationTreatment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExaminationId] [int] NOT NULL,
	[TreatmentId] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_ExaminationMedication] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inoculations]    Script Date: 4/26/2017 10:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inoculations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Date] [date] NULL,
 CONSTRAINT [PK_Inoculations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MedicalHistory]    Script Date: 4/26/2017 10:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicalHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_MedicalHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Patients]    Script Date: 4/26/2017 10:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Patients](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Birthdate] [date] NULL,
	[Gender] [char](1) NOT NULL,
	[Address] [nvarchar](50) NULL,
	[Phone] [nvarchar](11) NULL,
	[BirthType] [tinyint] NOT NULL,
	[SucklingType] [tinyint] NOT NULL,
 CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Treatments]    Script Date: 4/26/2017 10:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Treatments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Medications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TreatmentsDescription]    Script Date: 4/26/2017 10:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TreatmentsDescription](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TreatmentsDescription] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Diagnosis] ON 

INSERT [dbo].[Diagnosis] ([Id], [Name]) VALUES (1, N'Koha')
INSERT [dbo].[Diagnosis] ([Id], [Name]) VALUES (2, N'diagnooosiii')
INSERT [dbo].[Diagnosis] ([Id], [Name]) VALUES (3, N'يبسييس')
INSERT [dbo].[Diagnosis] ([Id], [Name]) VALUES (1002, N'Diagnisos 1')
INSERT [dbo].[Diagnosis] ([Id], [Name]) VALUES (1003, N'Diagnisos 2')
INSERT [dbo].[Diagnosis] ([Id], [Name]) VALUES (1004, N'Diagnisos 3')
INSERT [dbo].[Diagnosis] ([Id], [Name]) VALUES (1005, N'A')
INSERT [dbo].[Diagnosis] ([Id], [Name]) VALUES (1006, N'none')
INSERT [dbo].[Diagnosis] ([Id], [Name]) VALUES (1007, N'asd')
INSERT [dbo].[Diagnosis] ([Id], [Name]) VALUES (1008, N'Dia')
INSERT [dbo].[Diagnosis] ([Id], [Name]) VALUES (1009, N'headache')
INSERT [dbo].[Diagnosis] ([Id], [Name]) VALUES (1010, N'tea')
INSERT [dbo].[Diagnosis] ([Id], [Name]) VALUES (1011, N'batch')
SET IDENTITY_INSERT [dbo].[Diagnosis] OFF
SET IDENTITY_INSERT [dbo].[ExaminationDiagnosis] ON 

INSERT [dbo].[ExaminationDiagnosis] ([Id], [ExaminationId], [DisgnosisId]) VALUES (0, 1, 1)
INSERT [dbo].[ExaminationDiagnosis] ([Id], [ExaminationId], [DisgnosisId]) VALUES (1, 2, 2)
INSERT [dbo].[ExaminationDiagnosis] ([Id], [ExaminationId], [DisgnosisId]) VALUES (2, 1004, 1003)
INSERT [dbo].[ExaminationDiagnosis] ([Id], [ExaminationId], [DisgnosisId]) VALUES (3, 1004, 1002)
INSERT [dbo].[ExaminationDiagnosis] ([Id], [ExaminationId], [DisgnosisId]) VALUES (4, 1006, 2)
INSERT [dbo].[ExaminationDiagnosis] ([Id], [ExaminationId], [DisgnosisId]) VALUES (5, 1006, 1003)
INSERT [dbo].[ExaminationDiagnosis] ([Id], [ExaminationId], [DisgnosisId]) VALUES (6, 1007, 1006)
INSERT [dbo].[ExaminationDiagnosis] ([Id], [ExaminationId], [DisgnosisId]) VALUES (7, 1008, 1007)
INSERT [dbo].[ExaminationDiagnosis] ([Id], [ExaminationId], [DisgnosisId]) VALUES (8, 1009, 1008)
INSERT [dbo].[ExaminationDiagnosis] ([Id], [ExaminationId], [DisgnosisId]) VALUES (9, 1010, 1009)
INSERT [dbo].[ExaminationDiagnosis] ([Id], [ExaminationId], [DisgnosisId]) VALUES (10, 1010, 1010)
INSERT [dbo].[ExaminationDiagnosis] ([Id], [ExaminationId], [DisgnosisId]) VALUES (11, 1011, 1011)
SET IDENTITY_INSERT [dbo].[ExaminationDiagnosis] OFF
SET IDENTITY_INSERT [dbo].[Examinations] ON 

INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (1, 8, CAST(0x773C0B00 AS Date), 1, N'ko7a, s5ona, and eshaal', 76, 20, 70)
INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (2, 8, CAST(0x773C0B00 AS Date), 2, N'complaint', 5, 5, 5)
INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (1002, 1, CAST(0x783C0B00 AS Date), 1, N'', -1, -1, -1)
INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (1003, 1, CAST(0x783C0B00 AS Date), 1, N'', -1, -1, -1)
INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (1004, 1007, CAST(0x7A3C0B00 AS Date), 1, N'', 120, 120, 120)
INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (1005, 1, CAST(0x7B3C0B00 AS Date), 1, N'', -1, -1, -1)
INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (1006, 1, CAST(0x823C0B00 AS Date), 2, N'Complaint,...', 200, 200, 200)
INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (1007, 5, CAST(0x823C0B00 AS Date), 1, N'none', 1, 2, 3)
INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (1008, 2, CAST(0x823C0B00 AS Date), 1, N'asd', 170, 75, 86)
INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (1009, 6, CAST(0x823C0B00 AS Date), 1, N'com', 140, 55, 60)
INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (1010, 3, CAST(0x833C0B00 AS Date), 1, N'boaser', 190, 85, 25)
INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (1011, 1008, CAST(0x833C0B00 AS Date), 1, N'بيفكر ب ...............', 50, 50, 50)
INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (1012, 4, CAST(0x853C0B00 AS Date), 1, N'', -1, -1, -1)
INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (1013, 6, CAST(0x853C0B00 AS Date), 1, N'', -1, -1, -1)
INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (1014, 3, CAST(0xB93C0B00 AS Date), 1, N'me', 160, 80, 45)
INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (1015, 1008, CAST(0xB93C0B00 AS Date), 1, N'', -1, -1, -1)
INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (1016, 1008, CAST(0xBA3C0B00 AS Date), 1, N'', -1, -1, -1)
INSERT [dbo].[Examinations] ([Id], [PatientId], [Date], [ExaminationType], [Complaint], [PatientLength], [PatientWeight], [PatientHeadCircumference]) VALUES (1017, 1010, CAST(0xBB3C0B00 AS Date), 1, N'', 160, 60, 50)
SET IDENTITY_INSERT [dbo].[Examinations] OFF
SET IDENTITY_INSERT [dbo].[ExaminationTreatment] ON 

INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (1, 2, 8, N'15مرة')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (2, 1002, 1007, N'')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (3, 1002, 1008, N'')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (4, 1002, 8, N'15 مرة')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (5, 1003, 1, N'ggg')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (6, 1004, 1, N'3 مرات ف اليوم')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (7, 1004, 7, N'مرة ف اليوم')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (8, 1005, 1008, N'')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (9, 1006, 1, N'3 مرات بعد الاكل')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (10, 1006, 7, N'مرة كل صبح')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (11, 1007, 1009, N'-_-')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (12, 1007, 3, N'4 مرات قبل الاكل')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (13, 1007, 1, N'مرة كل صبح')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (14, 1008, 8, N'4 مرات ف اليوم')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (15, 1008, 7, N'مرتين يوميا')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (16, 1009, 1010, N'مرة كل يومين')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (17, 1009, 1011, N'5 مرات كل يوم')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (18, 1010, 7, N'')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (19, 1010, 1010, N'')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (20, 1011, 1010, N'30 مرة قبل وبعد ......')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (21, 1012, 1, N'مرة ف اليوم')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (22, 1012, 7, N'4 مرات')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (23, 1013, 1007, N'مرتين')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (24, 1014, 1, N'مرتين يوميا')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (25, 1014, 3, N'3 مرات بعد الاكل')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (26, 1015, 6, N'خمس مرات يوميا')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (27, 1016, 1, N'3 مرات بعد اللاكل')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (28, 1016, 3, N'مرتين يبح وليل')
INSERT [dbo].[ExaminationTreatment] ([Id], [ExaminationId], [TreatmentId], [Description]) VALUES (29, 1017, 3, N'15 مرة كل صبح')
SET IDENTITY_INSERT [dbo].[ExaminationTreatment] OFF
SET IDENTITY_INSERT [dbo].[Inoculations] ON 

INSERT [dbo].[Inoculations] ([Id], [PatientId], [Name], [Date]) VALUES (1, 2, N'شلل الأطفال', CAST(0x07240B00 AS Date))
INSERT [dbo].[Inoculations] ([Id], [PatientId], [Name], [Date]) VALUES (3, 1, N'الحصبة', CAST(0x6A3C0B00 AS Date))
INSERT [dbo].[Inoculations] ([Id], [PatientId], [Name], [Date]) VALUES (7, 2, N'الحصبة', CAST(0x773C0B00 AS Date))
INSERT [dbo].[Inoculations] ([Id], [PatientId], [Name], [Date]) VALUES (14, 4, N'ىستن', NULL)
INSERT [dbo].[Inoculations] ([Id], [PatientId], [Name], [Date]) VALUES (15, 3, N'حصبة', CAST(0x99A10B00 AS Date))
INSERT [dbo].[Inoculations] ([Id], [PatientId], [Name], [Date]) VALUES (1005, 1007, N'انفلونزا', CAST(0x793C0B00 AS Date))
INSERT [dbo].[Inoculations] ([Id], [PatientId], [Name], [Date]) VALUES (1006, 1008, N'antibrain', NULL)
SET IDENTITY_INSERT [dbo].[Inoculations] OFF
SET IDENTITY_INSERT [dbo].[MedicalHistory] ON 

INSERT [dbo].[MedicalHistory] ([Id], [PatientId], [Description]) VALUES (3, 3, N'asdf')
INSERT [dbo].[MedicalHistory] ([Id], [PatientId], [Description]) VALUES (6, 4, N'ةيشسن')
INSERT [dbo].[MedicalHistory] ([Id], [PatientId], [Description]) VALUES (1004, 2, N'historicalll ...')
INSERT [dbo].[MedicalHistory] ([Id], [PatientId], [Description]) VALUES (1005, 1, N'f')
SET IDENTITY_INSERT [dbo].[MedicalHistory] OFF
SET IDENTITY_INSERT [dbo].[Patients] ON 

INSERT [dbo].[Patients] ([Id], [Name], [Birthdate], [Gender], [Address], [Phone], [BirthType], [SucklingType]) VALUES (1, N'انجيلوس مدحت رضا', CAST(0x1D1A0B00 AS Date), N'M', N'مير', N'01271003409', 1, 1)
INSERT [dbo].[Patients] ([Id], [Name], [Birthdate], [Gender], [Address], [Phone], [BirthType], [SucklingType]) VALUES (2, N'سيد', CAST(0x211A0B00 AS Date), N'M', N'مير - القوصية - أسيوط', N'', 2, 1)
INSERT [dbo].[Patients] ([Id], [Name], [Birthdate], [Gender], [Address], [Phone], [BirthType], [SucklingType]) VALUES (3, N'بيشوي خيري دانيال', CAST(0x30170B00 AS Date), N'M', N'عايش ف الشارع', N'0', 1, 1)
INSERT [dbo].[Patients] ([Id], [Name], [Birthdate], [Gender], [Address], [Phone], [BirthType], [SucklingType]) VALUES (4, N'علي', NULL, N'M', N'عنوان علي', N'9999', 1, 1)
INSERT [dbo].[Patients] ([Id], [Name], [Birthdate], [Gender], [Address], [Phone], [BirthType], [SucklingType]) VALUES (5, N'حسن', NULL, N'M', N'البيتgwer', N'', 1, 1)
INSERT [dbo].[Patients] ([Id], [Name], [Birthdate], [Gender], [Address], [Phone], [BirthType], [SucklingType]) VALUES (6, N'عباس مخيمر فتح الله', CAST(0x63350B00 AS Date), N'F', N'ف الأحداث', N'00000000', 2, 2)
INSERT [dbo].[Patients] ([Id], [Name], [Birthdate], [Gender], [Address], [Phone], [BirthType], [SucklingType]) VALUES (7, N'عتريس فوزي سعدالله', CAST(0x27350B00 AS Date), N'M', N'مش من هنا', N'0125362541', 1, 2)
INSERT [dbo].[Patients] ([Id], [Name], [Birthdate], [Gender], [Address], [Phone], [BirthType], [SucklingType]) VALUES (8, N'بهانة محمدين فوزي', CAST(0x67700A00 AS Date), N'F', N'المقابر', N'132220', 2, 2)
INSERT [dbo].[Patients] ([Id], [Name], [Birthdate], [Gender], [Address], [Phone], [BirthType], [SucklingType]) VALUES (1007, N'مريم بيمن معتمد', CAST(0x58390B00 AS Date), N'F', N'الزيتون', N'0124569866', 1, 1)
INSERT [dbo].[Patients] ([Id], [Name], [Birthdate], [Gender], [Address], [Phone], [BirthType], [SucklingType]) VALUES (1008, N'امير يوحنا', CAST(0xC7180B00 AS Date), N'M', N'غمرة - القاهرة', N'01200000820', 1, 1)
INSERT [dbo].[Patients] ([Id], [Name], [Birthdate], [Gender], [Address], [Phone], [BirthType], [SucklingType]) VALUES (1009, N'شسي', NULL, N'M', N'', N'', 1, 1)
INSERT [dbo].[Patients] ([Id], [Name], [Birthdate], [Gender], [Address], [Phone], [BirthType], [SucklingType]) VALUES (1010, N'امجد وجية فوزي', CAST(0xC2190B00 AS Date), N'M', N'مع ابوة', N'', 1, 1)
SET IDENTITY_INSERT [dbo].[Patients] OFF
SET IDENTITY_INSERT [dbo].[Treatments] ON 

INSERT [dbo].[Treatments] ([Id], [Name]) VALUES (1, N'Tri-B')
INSERT [dbo].[Treatments] ([Id], [Name]) VALUES (2, N'Rivo')
INSERT [dbo].[Treatments] ([Id], [Name]) VALUES (3, N'Nova C')
INSERT [dbo].[Treatments] ([Id], [Name]) VALUES (4, N'123')
INSERT [dbo].[Treatments] ([Id], [Name]) VALUES (6, N'Cataphast')
INSERT [dbo].[Treatments] ([Id], [Name]) VALUES (7, N'antinal')
INSERT [dbo].[Treatments] ([Id], [Name]) VALUES (8, N'asd')
INSERT [dbo].[Treatments] ([Id], [Name]) VALUES (1006, N'Markofeen')
INSERT [dbo].[Treatments] ([Id], [Name]) VALUES (1007, N'Treatment 1')
INSERT [dbo].[Treatments] ([Id], [Name]) VALUES (1008, N'Treatment 2')
INSERT [dbo].[Treatments] ([Id], [Name]) VALUES (1009, N'none')
INSERT [dbo].[Treatments] ([Id], [Name]) VALUES (1010, N'hhh')
INSERT [dbo].[Treatments] ([Id], [Name]) VALUES (1011, N'Strobtoken')
INSERT [dbo].[Treatments] ([Id], [Name]) VALUES (1012, N'Emox')
INSERT [dbo].[Treatments] ([Id], [Name]) VALUES (1014, N'tre')
INSERT [dbo].[Treatments] ([Id], [Name]) VALUES (1015, N'tttttttt')
SET IDENTITY_INSERT [dbo].[Treatments] OFF
ALTER TABLE [dbo].[ExaminationDiagnosis]  WITH CHECK ADD  CONSTRAINT [FK_ExaminationSign_Examinations] FOREIGN KEY([ExaminationId])
REFERENCES [dbo].[Examinations] ([Id])
GO
ALTER TABLE [dbo].[ExaminationDiagnosis] CHECK CONSTRAINT [FK_ExaminationSign_Examinations]
GO
ALTER TABLE [dbo].[ExaminationDiagnosis]  WITH CHECK ADD  CONSTRAINT [FK_ExaminationSign_Signs] FOREIGN KEY([DisgnosisId])
REFERENCES [dbo].[Diagnosis] ([Id])
GO
ALTER TABLE [dbo].[ExaminationDiagnosis] CHECK CONSTRAINT [FK_ExaminationSign_Signs]
GO
ALTER TABLE [dbo].[Examinations]  WITH CHECK ADD  CONSTRAINT [FK_Examinations_Patients] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patients] ([Id])
GO
ALTER TABLE [dbo].[Examinations] CHECK CONSTRAINT [FK_Examinations_Patients]
GO
ALTER TABLE [dbo].[ExaminationTreatment]  WITH CHECK ADD  CONSTRAINT [FK_ExaminationMedication_Examinations] FOREIGN KEY([ExaminationId])
REFERENCES [dbo].[Examinations] ([Id])
GO
ALTER TABLE [dbo].[ExaminationTreatment] CHECK CONSTRAINT [FK_ExaminationMedication_Examinations]
GO
ALTER TABLE [dbo].[ExaminationTreatment]  WITH CHECK ADD  CONSTRAINT [FK_ExaminationMedication_Medications] FOREIGN KEY([TreatmentId])
REFERENCES [dbo].[Treatments] ([Id])
GO
ALTER TABLE [dbo].[ExaminationTreatment] CHECK CONSTRAINT [FK_ExaminationMedication_Medications]
GO
ALTER TABLE [dbo].[Inoculations]  WITH CHECK ADD  CONSTRAINT [FK_Inoculations_Patients] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patients] ([Id])
GO
ALTER TABLE [dbo].[Inoculations] CHECK CONSTRAINT [FK_Inoculations_Patients]
GO
ALTER TABLE [dbo].[MedicalHistory]  WITH CHECK ADD  CONSTRAINT [FK_MedicalHistory_Patients] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patients] ([Id])
GO
ALTER TABLE [dbo].[MedicalHistory] CHECK CONSTRAINT [FK_MedicalHistory_Patients]
GO
USE [master]
GO
ALTER DATABASE [DrIbrahimClinic] SET  READ_WRITE 
GO
