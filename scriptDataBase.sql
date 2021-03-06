USE [store_sale_point]
GO
/****** Object:  Table [dbo].[permission_page]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[permission_page](
	[page_id] [int] IDENTITY(1,1) NOT NULL,
	[page_name] [nvarchar](100) NULL,
	[page_url] [nvarchar](300) NULL,
 CONSTRAINT [PK_permission_name] PRIMARY KEY CLUSTERED 
(
	[page_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[permission_page] DISABLE CHANGE_TRACKING
GO
SET IDENTITY_INSERT [dbo].[permission_page] ON
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (1, N'الاعدادات العامة', N'/admin/setting_general.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (2, N'الفروع', N'/admin/setting_branch.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (3, N'المخازن', N'/admin/setting_store.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (4, N'الوحدات', N'/admin/setting_unit.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (5, N'الرئيسية', N'/admin/home.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (6, N'النوع', N'/admin/setting_user_kind.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (7, N'نوع الطلبات', N'/admin/setting_order_kind.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (8, N'نوع الصندوق', N'/admin/setting_box_kind.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (9, N'نوع الحساب', N'/admin/setting_box_account.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (10, N'الاقسام', N'/admin/setting_category.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (11, N'نوع الدفع', N'/admin/setting_method_pay.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (12, N'المنتجات', N'/admin/product_view.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (13, N'اضافة منتج', N'/admin/product_add.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (14, N'ارشيف اسعار المنتجات', N'/admin/product_historyPrice.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (15, N'فاتورة مبيعات', N'/admin/POS.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (16, N'فاتورة مشتريات', N'/admin/PO_Purchase.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (17, N'التحويلات بين الفروع', N'/admin/PO_Transfare.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (18, N'مرتجع مبيعات', N'/admin/POS_Back.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (19, N'مرتجع مشتريات', N'/admin/PO_Purchase_Back.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (20, N'العملاء', N'/admin/c_s_customer.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (21, N'الموردين', N'/admin/c_s_supplier.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (22, N'الصندوق', N'/admin/box.aspx')
INSERT [dbo].[permission_page] ([page_id], [page_name], [page_url]) VALUES (23, N'ارشيف دخول المستخدم', N'/admin/historyInOut_User.aspx')
SET IDENTITY_INSERT [dbo].[permission_page] OFF
/****** Object:  Table [dbo].[permission_group_page]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[permission_group_page](
	[no] [int] IDENTITY(1,1) NOT NULL,
	[page_id] [int] NULL,
	[group_id] [int] NULL,
 CONSTRAINT [PK_permission_group_page] PRIMARY KEY CLUSTERED 
(
	[no] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[permission_group_page] DISABLE CHANGE_TRACKING
GO
SET IDENTITY_INSERT [dbo].[permission_group_page] ON
INSERT [dbo].[permission_group_page] ([no], [page_id], [group_id]) VALUES (13, 2, 3)
INSERT [dbo].[permission_group_page] ([no], [page_id], [group_id]) VALUES (14, 4, 3)
INSERT [dbo].[permission_group_page] ([no], [page_id], [group_id]) VALUES (96, 5, 2)
INSERT [dbo].[permission_group_page] ([no], [page_id], [group_id]) VALUES (97, 12, 2)
INSERT [dbo].[permission_group_page] ([no], [page_id], [group_id]) VALUES (98, 13, 2)
INSERT [dbo].[permission_group_page] ([no], [page_id], [group_id]) VALUES (99, 14, 2)
INSERT [dbo].[permission_group_page] ([no], [page_id], [group_id]) VALUES (100, 15, 2)
INSERT [dbo].[permission_group_page] ([no], [page_id], [group_id]) VALUES (101, 23, 2)
SET IDENTITY_INSERT [dbo].[permission_group_page] OFF
/****** Object:  Table [dbo].[permission_group]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[permission_group](
	[group_id] [int] IDENTITY(1,1) NOT NULL,
	[group_name] [nvarchar](50) NULL,
	[group_notes] [nvarchar](150) NULL,
 CONSTRAINT [PK_permission_group] PRIMARY KEY CLUSTERED 
(
	[group_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[permission_group] DISABLE CHANGE_TRACKING
GO
SET IDENTITY_INSERT [dbo].[permission_group] ON
INSERT [dbo].[permission_group] ([group_id], [group_name], [group_notes]) VALUES (1, N'مبيعات', N'None')
INSERT [dbo].[permission_group] ([group_id], [group_name], [group_notes]) VALUES (2, N'حسابات', N'')
SET IDENTITY_INSERT [dbo].[permission_group] OFF
/****** Object:  Table [dbo].[order_master]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_master](
	[order_master_id] [int] IDENTITY(1,1) NOT NULL,
	[order_master_code] [nvarchar](100) NULL,
	[branch_id] [int] NULL,
	[store_id] [int] NULL,
	[order_master_datecreation] [datetime] NULL,
	[order_master_dicount] [float] NULL,
	[order_master_tax] [float] NULL,
	[order_master_houre] [int] NULL,
	[user_id] [int] NULL,
	[emp_id] [int] NULL,
	[order_master_total_price] [float] NULL,
	[payment_id] [int] NULL,
	[order_kind_id] [int] NULL,
 CONSTRAINT [PK_order_master] PRIMARY KEY CLUSTERED 
(
	[order_master_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[order_master] DISABLE CHANGE_TRACKING
GO
SET IDENTITY_INSERT [dbo].[order_master] ON
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (81, N'OS-183312442020gsorl', 5, 10, CAST(0x0000AB910132527E AS DateTime), 0, 0, 18, 1, 1, 13.5, 1, 1)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (82, N'OP-18378442020yn736', 5, 10, CAST(0x0000AB9301334D71 AS DateTime), 0, 0, 18, 13, 1, 135, 1, 2)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (83, N'SB-183955442020tyo93', 5, 10, CAST(0x0000AB9301346538 AS DateTime), 0, 0, 18, 0, 1, 0, 1, 3)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (84, N'PB-184327442020j5thi', 5, 10, CAST(0x0000AB930134D6E4 AS DateTime), 0, 0, 18, 0, 1, 0, 1, 4)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (85, N'OS-202838442020xv995', 5, 1, CAST(0x0000AB930151BA0E AS DateTime), 0, 0, 20, 1, 1, 9.5, 1, 1)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (86, N'OP-203259442020olbmn', 5, 1, CAST(0x0000AB930152CACD AS DateTime), 0, 0, 20, 1, 1, 9.5, 1, 2)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (87, N'OP-203412442020ktccr', 5, 10, CAST(0x0000AB9301530D27 AS DateTime), 0, 0, 20, 10, 1, 9.5, 1, 2)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (88, N'OS-1835256420204udxj', 1, 5, CAST(0x0000AB980132B0F2 AS DateTime), 0, 0, 18, 25, 1, 11, 1, 1)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (89, N'OS-184954642020pr48v', 5, 10, CAST(0x0000AB9801367746 AS DateTime), 0, 0, 18, 10, 1, 6, 1, 1)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (90, N'OS-18512642020m8adw', 5, 10, CAST(0x0000AB980136C8F5 AS DateTime), 0, 0, 18, 12, 1, 6, 1, 1)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (91, N'OS-18523642020ikcuv', 5, 10, CAST(0x0000AB9801370698 AS DateTime), 0, 0, 18, 11, 1, 2.5, 1, 1)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (92, N'OS-24571142020bkhli', 5, 1, CAST(0x0000AB9A0022B7E3 AS DateTime), 0, 5, 2, 1, 1, 5.7750000953674316, 2, 1)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (93, N'OP-09311442020xncuf', 5, 1, CAST(0x0000AB9D0002D8AC AS DateTime), 0, 0, 0, 1, 1, 290, 1, 2)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (94, N'OS-011151442020nmhlu', 5, 10, CAST(0x0000AB9D0003442C AS DateTime), 0, 0, 0, 12, 1, 3.5, 1, 1)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (104, N'SB-1652251442020rwh6g', 5, 2, CAST(0x0000AB9D01162EFC AS DateTime), 0, 0, 16, 0, 1, 0, 1, 3)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (107, N'PB-1656341442020nubx4', 5, 2, CAST(0x0000AB9D01175E9E AS DateTime), 0, 0, 16, 0, 1, 0, 1, 4)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (108, N'OS-1658431442020ykij7', 5, 1, CAST(0x0000AB9D01180C8F AS DateTime), 0, 0, 16, 92, 1, 11.5, 1, 1)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (109, N'OS-1702014420204jyde', 5, 1, CAST(0x0000AB9D011867BA AS DateTime), 0, 0, 17, 14, 1, 5, 1, 1)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (110, N'OS-17171442020vq91g', 5, 10, CAST(0x0000AB9D01189A7C AS DateTime), 0, 0, 17, 10, 1, 5, 1, 1)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (111, N'OP-178531442020ueb8b', 5, 10, CAST(0x0000AB9D011B3BB8 AS DateTime), 0, 5, 17, 11, 1, 1260, 1, 2)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (112, N'OS-1719561442020ffamg', 5, 10, CAST(0x0000AB9D011E22EA AS DateTime), 0, 0, 17, 11, 1, 10, 1, 1)
INSERT [dbo].[order_master] ([order_master_id], [order_master_code], [branch_id], [store_id], [order_master_datecreation], [order_master_dicount], [order_master_tax], [order_master_houre], [user_id], [emp_id], [order_master_total_price], [payment_id], [order_kind_id]) VALUES (113, N'OS-1341292520208px9k', 5, 1, CAST(0x0000ABAF00E1CC54 AS DateTime), 0, 0, 13, 1, 1, 15, 2, 1)
SET IDENTITY_INSERT [dbo].[order_master] OFF
/****** Object:  Table [dbo].[order_kind]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_kind](
	[order_kind_id] [int] NOT NULL,
	[order_kind_name] [nvarchar](50) NULL,
	[order_kind_notes] [nvarchar](150) NULL,
 CONSTRAINT [PK_order_kind] PRIMARY KEY CLUSTERED 
(
	[order_kind_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[order_kind] DISABLE CHANGE_TRACKING
GO
INSERT [dbo].[order_kind] ([order_kind_id], [order_kind_name], [order_kind_notes]) VALUES (1, N'فاتورة مبيعات', NULL)
INSERT [dbo].[order_kind] ([order_kind_id], [order_kind_name], [order_kind_notes]) VALUES (2, N'فاتورة مشتريات', NULL)
INSERT [dbo].[order_kind] ([order_kind_id], [order_kind_name], [order_kind_notes]) VALUES (3, N'فاتورة مرتجع مبيعات', NULL)
INSERT [dbo].[order_kind] ([order_kind_id], [order_kind_name], [order_kind_notes]) VALUES (4, N'فاتورة مرتجع مشتريات', NULL)
/****** Object:  Table [dbo].[order_details]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_details](
	[order_details_id] [int] IDENTITY(1,1) NOT NULL,
	[order_master_code] [nvarchar](100) NULL,
	[product_id] [int] NULL,
	[order_details_quantity] [int] NULL,
	[unit_id] [int] NULL,
	[order_details_product_price] [float] NULL,
	[order_details_total_price] [float] NULL,
 CONSTRAINT [PK_order_details] PRIMARY KEY CLUSTERED 
(
	[order_details_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[order_details] DISABLE CHANGE_TRACKING
GO
SET IDENTITY_INSERT [dbo].[order_details] ON
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (147, N'OS-183312442020gsorl', 5, 5, 1, 9.5, 47.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (148, N'OS-183312442020gsorl', 6, 5, 1, 4, 20)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (149, N'OP-18378442020yn736', 5, 10, 1, 9.5, 95)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (150, N'OP-18378442020yn736', 6, 10, 1, 4, 40)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (151, N'SB-183955442020tyo93', 5, 2, 1, 9.5, 47.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (152, N'SB-183955442020tyo93', 6, 2, 1, 4, 20)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (153, N'PB-184327442020j5thi', 5, 2, 1, 9.5, 95)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (154, N'PB-184327442020j5thi', 6, 2, 1, 4, 40)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (155, N'OS-202838442020xv995', 5, 1, 1, 9.5, 9.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (156, N'OP-203259442020olbmn', 5, 1, 1, 9.5, 9.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (157, N'OP-203412442020ktccr', 5, 1, 1, 9.5, 9.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (158, N'OS-1835256420204udxj', 9, 1, 4, 3.5, 3.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (159, N'OS-1835256420204udxj', 15, 1, 5, 5, 5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (160, N'OS-1835256420204udxj', 7, 1, 4, 2.5, 2.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (161, N'OS-184954642020pr48v', 7, 1, 4, 2.5, 2.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (162, N'OS-184954642020pr48v', 9, 1, 4, 3.5, 3.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (163, N'OS-18512642020m8adw', 7, 1, 4, 2.5, 2.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (164, N'OS-18512642020m8adw', 9, 1, 4, 3.5, 3.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (165, N'OS-18523642020ikcuv', 7, 1, 4, 2.5, 2.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (166, N'OS-24571142020bkhli', 25, 1, 5, 3, 3)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (167, N'OS-24571142020bkhli', 7, 1, 4, 2.5, 2.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (168, N'OP-09311442020xncuf', 7, 10, 4, 2.5, 25)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (169, N'OP-09311442020xncuf', 5, 10, 1, 9.5, 95)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (170, N'OP-09311442020xncuf', 6, 10, 1, 4, 40)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (171, N'OP-09311442020xncuf', 14, 10, 4, 5.5, 55)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (172, N'OP-09311442020xncuf', 15, 10, 5, 5, 50)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (173, N'OP-09311442020xncuf', 26, 10, 5, 2.5, 25)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (174, N'OS-011151442020nmhlu', 9, 1, 4, 3.5, 3.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (175, N'SB-1652251442020rwh6g', 9, 1, 4, 3.5, 3.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (176, N'PB-1656341442020nubx4', 15, 10, 5, 5, 50)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (177, N'PB-1656341442020nubx4', 26, 10, 5, 2.5, 25)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (178, N'OS-1658431442020ykij7', 15, 1, 5, 5, 5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (179, N'OS-1658431442020ykij7', 25, 1, 5, 3, 3)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (180, N'OS-1658431442020ykij7', 9, 1, 4, 3.5, 3.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (181, N'OS-1702014420204jyde', 15, 1, 5, 5, 5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (182, N'OS-17171442020vq91g', 15, 1, 5, 5, 5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (183, N'OP-178531442020ueb8b', 27, 100, 2, 12, 1200)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (184, N'OS-1719561442020ffamg', 27, 10, 2, 10, 100)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (185, N'OS-1341292520208px9k', 7, 1, 4, 2.5, 2.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (186, N'OS-1341292520208px9k', 26, 1, 5, 2.5, 2.5)
INSERT [dbo].[order_details] ([order_details_id], [order_master_code], [product_id], [order_details_quantity], [unit_id], [order_details_product_price], [order_details_total_price]) VALUES (187, N'OS-1341292520208px9k', 27, 1, 2, 10, 10)
SET IDENTITY_INSERT [dbo].[order_details] OFF
/****** Object:  Table [dbo].[method_pay]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[method_pay](
	[payment_id] [int] NOT NULL,
	[payment_name] [nvarchar](100) NULL,
	[payment_note] [nvarchar](150) NULL,
 CONSTRAINT [PK_method_pay] PRIMARY KEY CLUSTERED 
(
	[payment_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[method_pay] DISABLE CHANGE_TRACKING
GO
INSERT [dbo].[method_pay] ([payment_id], [payment_name], [payment_note]) VALUES (1, N'نقدى', NULL)
INSERT [dbo].[method_pay] ([payment_id], [payment_name], [payment_note]) VALUES (2, N'نقاط بيع', NULL)
INSERT [dbo].[method_pay] ([payment_id], [payment_name], [payment_note]) VALUES (3, N'شيك', NULL)
INSERT [dbo].[method_pay] ([payment_id], [payment_name], [payment_note]) VALUES (4, N'تحويل', NULL)
INSERT [dbo].[method_pay] ([payment_id], [payment_name], [payment_note]) VALUES (5, N'آجل', NULL)
/****** Object:  Table [dbo].[historyInOut_User]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[historyInOut_User](
	[history_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[history_DateTimeIn] [datetime] NULL,
	[history_DateTimeOut] [datetime] NULL,
	[history_getIpClient] [nvarchar](50) NULL,
	[history_getNameClient] [nvarchar](50) NULL,
 CONSTRAINT [PK_historyInOut_User] PRIMARY KEY CLUSTERED 
(
	[history_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[historyInOut_User] DISABLE CHANGE_TRACKING
GO
/****** Object:  Table [dbo].[general_setting]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[general_setting](
	[setting_id] [int] IDENTITY(1,1) NOT NULL,
	[setting_title] [nvarchar](100) NULL,
	[setting_logo] [nvarchar](100) NULL,
	[setting_phone] [nvarchar](50) NULL,
	[user_id] [int] NULL,
	[setting_date_creation] [datetime] NULL,
	[setting_notes] [nvarchar](max) NULL,
	[setting_about] [nvarchar](3000) NULL,
	[setting_homepage] [nvarchar](max) NULL,
 CONSTRAINT [PK_general_setting] PRIMARY KEY CLUSTERED 
(
	[setting_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[general_setting] DISABLE CHANGE_TRACKING
GO
SET IDENTITY_INSERT [dbo].[general_setting] ON
INSERT [dbo].[general_setting] ([setting_id], [setting_title], [setting_logo], [setting_phone], [user_id], [setting_date_creation], [setting_notes], [setting_about], [setting_homepage]) VALUES (3, N'الشركة العربية', N'Penguins.jpg', N'43543543', 1, CAST(0x0000AB6800000000 AS DateTime), N'لاتوجد ملاحظات', NULL, NULL)
SET IDENTITY_INSERT [dbo].[general_setting] OFF
/****** Object:  Table [dbo].[category]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](100) NULL,
	[category_notes] [nvarchar](300) NULL,
 CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[category] DISABLE CHANGE_TRACKING
GO
SET IDENTITY_INSERT [dbo].[category] ON
INSERT [dbo].[category] ([category_id], [category_name], [category_notes]) VALUES (7, N'كيك وخبوزات', NULL)
INSERT [dbo].[category] ([category_id], [category_name], [category_notes]) VALUES (8, N'جبن والبان وزبادى', NULL)
INSERT [dbo].[category] ([category_id], [category_name], [category_notes]) VALUES (9, N'حلويات مايفيه وكنافه وبسبوسه', N'')
INSERT [dbo].[category] ([category_id], [category_name], [category_notes]) VALUES (10, N'مشروبات', NULL)
INSERT [dbo].[category] ([category_id], [category_name], [category_notes]) VALUES (11, N'زيوت', NULL)
INSERT [dbo].[category] ([category_id], [category_name], [category_notes]) VALUES (12, N'سكر', NULL)
SET IDENTITY_INSERT [dbo].[category] OFF
/****** Object:  Table [dbo].[branch]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[branch](
	[branch_id] [int] IDENTITY(1,1) NOT NULL,
	[branch_name] [nvarchar](50) NULL,
	[branch_tel] [nvarchar](50) NULL,
	[branch_address] [nvarchar](50) NULL,
	[branch_notes] [nvarchar](300) NULL,
 CONSTRAINT [PK_branch] PRIMARY KEY CLUSTERED 
(
	[branch_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[branch] DISABLE CHANGE_TRACKING
GO
SET IDENTITY_INSERT [dbo].[branch] ON
INSERT [dbo].[branch] ([branch_id], [branch_name], [branch_tel], [branch_address], [branch_notes]) VALUES (1, N'الجيزة', N'543543', N'فيصل - الجيزة', N'none')
INSERT [dbo].[branch] ([branch_id], [branch_name], [branch_tel], [branch_address], [branch_notes]) VALUES (5, N'القاهرة', N'54354354354', N'وسط البلد - القاهرة', N'لايوجــد')
SET IDENTITY_INSERT [dbo].[branch] OFF
/****** Object:  Table [dbo].[box_kind]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[box_kind](
	[box_kind_id] [int] NOT NULL,
	[box_kind_name] [nvarchar](100) NULL,
	[box_kind_notes] [nvarchar](150) NULL,
 CONSTRAINT [PK_box_kind] PRIMARY KEY CLUSTERED 
(
	[box_kind_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[box_kind] DISABLE CHANGE_TRACKING
GO
INSERT [dbo].[box_kind] ([box_kind_id], [box_kind_name], [box_kind_notes]) VALUES (1, N'سند قبض', NULL)
INSERT [dbo].[box_kind] ([box_kind_id], [box_kind_name], [box_kind_notes]) VALUES (2, N'سند صرف', NULL)
/****** Object:  Table [dbo].[box_account]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[box_account](
	[box_account_id] [int] NOT NULL,
	[box_account_name] [nvarchar](50) NULL,
	[box_account_notes] [nvarchar](150) NULL,
 CONSTRAINT [PK_box_account] PRIMARY KEY CLUSTERED 
(
	[box_account_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[box_account] DISABLE CHANGE_TRACKING
GO
INSERT [dbo].[box_account] ([box_account_id], [box_account_name], [box_account_notes]) VALUES (1, N'حساب الصندوق', NULL)
INSERT [dbo].[box_account] ([box_account_id], [box_account_name], [box_account_notes]) VALUES (2, N'حساب الموردين', NULL)
INSERT [dbo].[box_account] ([box_account_id], [box_account_name], [box_account_notes]) VALUES (3, N'حساب المصروفات', NULL)
INSERT [dbo].[box_account] ([box_account_id], [box_account_name], [box_account_notes]) VALUES (4, N'حساب الايرادات', NULL)
INSERT [dbo].[box_account] ([box_account_id], [box_account_name], [box_account_notes]) VALUES (5, N'حساب العملاء', NULL)
/****** Object:  Table [dbo].[box]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[box](
	[box_id] [int] IDENTITY(1,1) NOT NULL,
	[branch_id] [int] NULL,
	[box_kind_id] [int] NULL,
	[box_account_id] [int] NULL,
	[box_datecreation] [datetime] NULL,
	[box_value] [float] NULL,
	[box_cheknumber] [nvarchar](100) NULL,
	[box_chekplace] [nvarchar](100) NULL,
	[box_notes] [nvarchar](300) NULL,
	[box_file] [nvarchar](100) NULL,
 CONSTRAINT [PK_box] PRIMARY KEY CLUSTERED 
(
	[box_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[box] DISABLE CHANGE_TRACKING
GO
SET IDENTITY_INSERT [dbo].[box] ON
INSERT [dbo].[box] ([box_id], [branch_id], [box_kind_id], [box_account_id], [box_datecreation], [box_value], [box_cheknumber], [box_chekplace], [box_notes], [box_file]) VALUES (1, 1, 1, 1, CAST(0x0000AC4A016805A0 AS DateTime), 2000, N'', N'', N'', N'')
INSERT [dbo].[box] ([box_id], [branch_id], [box_kind_id], [box_account_id], [box_datecreation], [box_value], [box_cheknumber], [box_chekplace], [box_notes], [box_file]) VALUES (2, 5, 2, 1, CAST(0x0000AB9A000E0885 AS DateTime), 2200, N'123123123', N'البنك الاهلى', N'لا توجد', N'')
INSERT [dbo].[box] ([box_id], [branch_id], [box_kind_id], [box_account_id], [box_datecreation], [box_value], [box_cheknumber], [box_chekplace], [box_notes], [box_file]) VALUES (3, 1, 1, 1, CAST(0x0000AC4A016A0B98 AS DateTime), 1200, N'', N'', N'', N'')
INSERT [dbo].[box] ([box_id], [branch_id], [box_kind_id], [box_account_id], [box_datecreation], [box_value], [box_cheknumber], [box_chekplace], [box_notes], [box_file]) VALUES (5, 5, 2, 1, CAST(0x0000AC69000E2E78 AS DateTime), 3500, N'', N'', N'', N'')
INSERT [dbo].[box] ([box_id], [branch_id], [box_kind_id], [box_account_id], [box_datecreation], [box_value], [box_cheknumber], [box_chekplace], [box_notes], [box_file]) VALUES (6, 5, 2, 1, CAST(0x0000AB9A00134F57 AS DateTime), 3000, N'لا يوجد', N'لا يوجد', N'لا يوجد', N'')
INSERT [dbo].[box] ([box_id], [branch_id], [box_kind_id], [box_account_id], [box_datecreation], [box_value], [box_cheknumber], [box_chekplace], [box_notes], [box_file]) VALUES (7, 1, 1, 1, CAST(0x0000AC6900187428 AS DateTime), 3000, N'', N'', N'', N'')
SET IDENTITY_INSERT [dbo].[box] OFF
/****** Object:  Table [dbo].[all_users]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[all_users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[user_fullname] [nvarchar](100) NULL,
	[user_phone] [nvarchar](50) NULL,
	[user_email] [nvarchar](100) NULL,
	[user_code] [nvarchar](100) NULL,
	[user_datecreation] [datetime] NULL,
	[user_address] [nvarchar](100) NULL,
	[user_active_or_no] [nvarchar](10) NULL,
	[user_name] [nvarchar](100) NULL,
	[user_password] [nvarchar](100) NULL,
	[group_id] [int] NULL,
	[user_kind_id] [int] NULL,
	[branch_id] [int] NULL,
 CONSTRAINT [PK_all_users] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[all_users] DISABLE CHANGE_TRACKING
GO
SET IDENTITY_INSERT [dbo].[all_users] ON
INSERT [dbo].[all_users] ([user_id], [user_fullname], [user_phone], [user_email], [user_code], [user_datecreation], [user_address], [user_active_or_no], [user_name], [user_password], [group_id], [user_kind_id], [branch_id]) VALUES (1, N'sasa', N'0556337065', N'ra_bedo11@yahoo.com', N'123', NULL, N'tanta', N'نشط', N'admin', N'123', NULL, 2, 1)
INSERT [dbo].[all_users] ([user_id], [user_fullname], [user_phone], [user_email], [user_code], [user_datecreation], [user_address], [user_active_or_no], [user_name], [user_password], [group_id], [user_kind_id], [branch_id]) VALUES (93, N'adel mohamed', N'789', N'adel mohamed@yahoo.com', NULL, NULL, N'cairo', NULL, NULL, NULL, NULL, 3, NULL)
INSERT [dbo].[all_users] ([user_id], [user_fullname], [user_phone], [user_email], [user_code], [user_datecreation], [user_address], [user_active_or_no], [user_name], [user_password], [group_id], [user_kind_id], [branch_id]) VALUES (97, N'mido', N'dsa', N'dsa', NULL, CAST(0x0000ABA8017EFF44 AS DateTime), N'dsa', NULL, NULL, NULL, NULL, 3, NULL)
SET IDENTITY_INSERT [dbo].[all_users] OFF
/****** Object:  Table [dbo].[user_kind]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_kind](
	[user_kind_id] [int] NOT NULL,
	[user_kind_name] [nvarchar](50) NULL,
	[user_kind_notes] [nvarchar](150) NULL,
 CONSTRAINT [PK_user_kind] PRIMARY KEY CLUSTERED 
(
	[user_kind_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[user_kind] DISABLE CHANGE_TRACKING
GO
INSERT [dbo].[user_kind] ([user_kind_id], [user_kind_name], [user_kind_notes]) VALUES (1, N'الموردين', NULL)
INSERT [dbo].[user_kind] ([user_kind_id], [user_kind_name], [user_kind_notes]) VALUES (2, N'المستخدمين', NULL)
INSERT [dbo].[user_kind] ([user_kind_id], [user_kind_name], [user_kind_notes]) VALUES (3, N'العملاء', NULL)
/****** Object:  Table [dbo].[unit]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[unit](
	[unit_id] [int] IDENTITY(1,1) NOT NULL,
	[unit_name] [nvarchar](100) NULL,
	[unit_notes] [nvarchar](300) NULL,
 CONSTRAINT [PK_unit] PRIMARY KEY CLUSTERED 
(
	[unit_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[unit] DISABLE CHANGE_TRACKING
GO
SET IDENTITY_INSERT [dbo].[unit] ON
INSERT [dbo].[unit] ([unit_id], [unit_name], [unit_notes]) VALUES (1, N'كيلو', N'None')
INSERT [dbo].[unit] ([unit_id], [unit_name], [unit_notes]) VALUES (2, N'جرام', N'لا يوجد')
INSERT [dbo].[unit] ([unit_id], [unit_name], [unit_notes]) VALUES (4, N'كمية', N'None')
INSERT [dbo].[unit] ([unit_id], [unit_name], [unit_notes]) VALUES (5, N'قطعة', N'')
SET IDENTITY_INSERT [dbo].[unit] OFF
/****** Object:  Table [dbo].[transfer_master]    Script Date: 05/28/2020 00:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transfer_master](
	[transfer_master_id] [int] IDENTITY(1,1) NOT NULL,
	[transfer_master_code] [nvarchar](100) NULL,
	[store_from] [int] NULL,
	[store_to] [int] NULL,
	[transfer_master_datecreation] [datetime] NULL,
	[user_id] [int] NULL,
 CONSTRAINT [PK_transfer_master] PRIMARY KEY CLUSTERED 
(
	[transfer_master_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[transfer_master] DISABLE CHANGE_TRACKING
GO
/****** Object:  Table [dbo].[transfer_details]    Script Date: 05/28/2020 00:16:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transfer_details](
	[transfer_details_id] [int] IDENTITY(1,1) NOT NULL,
	[transfer_master_code] [nvarchar](100) NULL,
	[product_id] [int] NULL,
	[unit_id] [int] NULL,
	[transfer_details_product_count] [int] NULL,
 CONSTRAINT [PK_transfer_details] PRIMARY KEY CLUSTERED 
(
	[transfer_details_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[transfer_details] DISABLE CHANGE_TRACKING
GO
/****** Object:  Table [dbo].[TestCustomer]    Script Date: 05/28/2020 00:16:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestCustomer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ContactName] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[PostalCode] [nvarchar](50) NULL,
 CONSTRAINT [PK_TestCustomer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestCustomer] DISABLE CHANGE_TRACKING
GO
SET IDENTITY_INSERT [dbo].[TestCustomer] ON
INSERT [dbo].[TestCustomer] ([id], [ContactName], [City], [Country], [PostalCode]) VALUES (1, N'ليس', N'tanta', N'Egypt', N'11211')
INSERT [dbo].[TestCustomer] ([id], [ContactName], [City], [Country], [PostalCode]) VALUES (2, N'لبي', N'cairo', N'Egypt', N'11211')
INSERT [dbo].[TestCustomer] ([id], [ContactName], [City], [Country], [PostalCode]) VALUES (3, N'ليبل', N'assiout', N'Egypt', N'11211')
INSERT [dbo].[TestCustomer] ([id], [ContactName], [City], [Country], [PostalCode]) VALUES (4, N'يبلبيس', N'alex', N'Egypt', N'11211')
INSERT [dbo].[TestCustomer] ([id], [ContactName], [City], [Country], [PostalCode]) VALUES (5, N'لبيسل', N'tanta', N'KSA', N'11211')
INSERT [dbo].[TestCustomer] ([id], [ContactName], [City], [Country], [PostalCode]) VALUES (6, N'يبليبلبيس', N'santa', N'KSA', N'11211')
INSERT [dbo].[TestCustomer] ([id], [ContactName], [City], [Country], [PostalCode]) VALUES (7, N'ققثفقثس', N'santa', N'KSA', N'11211')
INSERT [dbo].[TestCustomer] ([id], [ContactName], [City], [Country], [PostalCode]) VALUES (8, N'ف', N'tanta', N'KSA', N'11211')
INSERT [dbo].[TestCustomer] ([id], [ContactName], [City], [Country], [PostalCode]) VALUES (9, N'fdsfadsaf', N'cairo', N'KSA', N'11211')
INSERT [dbo].[TestCustomer] ([id], [ContactName], [City], [Country], [PostalCode]) VALUES (10, N'dsafdsa', N'giza', N'UAE', N'11211')
INSERT [dbo].[TestCustomer] ([id], [ContactName], [City], [Country], [PostalCode]) VALUES (11, N'sasa', N'cairo', N'UAE', N'11211')
INSERT [dbo].[TestCustomer] ([id], [ContactName], [City], [Country], [PostalCode]) VALUES (12, N'fdsafdsafds', N'giza', N'UAE', N'11211')
INSERT [dbo].[TestCustomer] ([id], [ContactName], [City], [Country], [PostalCode]) VALUES (13, N'fdsafd', N'alex', N'UAE', N'11211')
INSERT [dbo].[TestCustomer] ([id], [ContactName], [City], [Country], [PostalCode]) VALUES (14, N'safdsaffds', N'assiout', N'Egypt', NULL)
INSERT [dbo].[TestCustomer] ([id], [ContactName], [City], [Country], [PostalCode]) VALUES (15, NULL, NULL, NULL, N'11211')
SET IDENTITY_INSERT [dbo].[TestCustomer] OFF
/****** Object:  Table [dbo].[store]    Script Date: 05/28/2020 00:16:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[store](
	[store_id] [int] IDENTITY(1,1) NOT NULL,
	[store_name] [nvarchar](50) NULL,
	[branch_id] [int] NULL,
	[store_notes] [nvarchar](300) NULL,
 CONSTRAINT [PK_store] PRIMARY KEY CLUSTERED 
(
	[store_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[store] DISABLE CHANGE_TRACKING
GO
SET IDENTITY_INSERT [dbo].[store] ON
INSERT [dbo].[store] ([store_id], [store_name], [branch_id], [store_notes]) VALUES (1, N'فيصل', 5, N'لايوجد')
INSERT [dbo].[store] ([store_id], [store_name], [branch_id], [store_notes]) VALUES (2, N'وسط البلد', 1, N'None')
INSERT [dbo].[store] ([store_id], [store_name], [branch_id], [store_notes]) VALUES (5, N'شبرا', 1, N'None')
INSERT [dbo].[store] ([store_id], [store_name], [branch_id], [store_notes]) VALUES (10, N'الهرم', 5, NULL)
SET IDENTITY_INSERT [dbo].[store] OFF
/****** Object:  Table [dbo].[recentPrice]    Script Date: 05/28/2020 00:16:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[recentPrice](
	[recentPrice_id] [int] IDENTITY(1,1) NOT NULL,
	[recentPrice_productId] [int] NULL,
	[recentPrice_ProductCode] [nvarchar](100) NULL,
	[recentPrice_productPriceOld] [float] NULL,
	[recentPrice_productPriceNew] [float] NULL,
	[recentPrice_productDateEdit] [datetime] NULL,
	[recentPrice_productNotes] [nvarchar](100) NULL,
 CONSTRAINT [PK_recentPrice] PRIMARY KEY CLUSTERED 
(
	[recentPrice_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[recentPrice] DISABLE CHANGE_TRACKING
GO
SET IDENTITY_INSERT [dbo].[recentPrice] ON
INSERT [dbo].[recentPrice] ([recentPrice_id], [recentPrice_productId], [recentPrice_ProductCode], [recentPrice_productPriceOld], [recentPrice_productPriceNew], [recentPrice_productDateEdit], [recentPrice_productNotes]) VALUES (2, 6, N'12', 5, 4, CAST(0x0000AB8A014F3B51 AS DateTime), N'يوجد')
INSERT [dbo].[recentPrice] ([recentPrice_id], [recentPrice_productId], [recentPrice_ProductCode], [recentPrice_productPriceOld], [recentPrice_productPriceNew], [recentPrice_productDateEdit], [recentPrice_productNotes]) VALUES (3, 7, N'123', 1.5, 2.5, CAST(0x0000AB8A015D94AB AS DateTime), N'لايوجد')
INSERT [dbo].[recentPrice] ([recentPrice_id], [recentPrice_productId], [recentPrice_ProductCode], [recentPrice_productPriceOld], [recentPrice_productPriceNew], [recentPrice_productDateEdit], [recentPrice_productNotes]) VALUES (5, 5, N'1', 7, 7.5, CAST(0x0000AB8B00067A6E AS DateTime), NULL)
INSERT [dbo].[recentPrice] ([recentPrice_id], [recentPrice_productId], [recentPrice_ProductCode], [recentPrice_productPriceOld], [recentPrice_productPriceNew], [recentPrice_productDateEdit], [recentPrice_productNotes]) VALUES (6, 5, N'1', 7.5, 8.5, CAST(0x0000AB8B0006836A AS DateTime), N'لا يوجد')
INSERT [dbo].[recentPrice] ([recentPrice_id], [recentPrice_productId], [recentPrice_ProductCode], [recentPrice_productPriceOld], [recentPrice_productPriceNew], [recentPrice_productDateEdit], [recentPrice_productNotes]) VALUES (7, 5, N'1', 8.5, 9.5, CAST(0x0000AB8B00068DC9 AS DateTime), NULL)
INSERT [dbo].[recentPrice] ([recentPrice_id], [recentPrice_productId], [recentPrice_ProductCode], [recentPrice_productPriceOld], [recentPrice_productPriceNew], [recentPrice_productDateEdit], [recentPrice_productNotes]) VALUES (8, 17, N'22222', 22222, 6.5, CAST(0x0000AB93011754F6 AS DateTime), NULL)
INSERT [dbo].[recentPrice] ([recentPrice_id], [recentPrice_productId], [recentPrice_ProductCode], [recentPrice_productPriceOld], [recentPrice_productPriceNew], [recentPrice_productDateEdit], [recentPrice_productNotes]) VALUES (9, 25, N'123456789', 123, 3, CAST(0x0000AB9301187E99 AS DateTime), NULL)
INSERT [dbo].[recentPrice] ([recentPrice_id], [recentPrice_productId], [recentPrice_ProductCode], [recentPrice_productPriceOld], [recentPrice_productPriceNew], [recentPrice_productDateEdit], [recentPrice_productNotes]) VALUES (10, 27, N'0987654321', NULL, 10, CAST(0x0000AB9D011A62E5 AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[recentPrice] OFF
/****** Object:  Table [dbo].[product]    Script Date: 05/28/2020 00:16:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[product_name] [nvarchar](100) NULL,
	[product_code] [nvarchar](100) NULL,
	[product_barcode] [nvarchar](100) NULL,
	[product_dateadd] [datetime] NULL,
	[product_img] [nvarchar](100) NULL,
	[product_price] [float] NULL,
	[product_quantity] [int] NULL,
	[product_quantity_alert] [int] NULL,
	[product_desc] [nvarchar](3000) NULL,
	[unit_id] [int] NULL,
	[user_id] [int] NULL,
	[store_id] [int] NULL,
	[category_id] [int] NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[product] DISABLE CHANGE_TRACKING
GO
SET IDENTITY_INSERT [dbo].[product] ON
INSERT [dbo].[product] ([product_id], [product_name], [product_code], [product_barcode], [product_dateadd], [product_img], [product_price], [product_quantity], [product_quantity_alert], [product_desc], [unit_id], [user_id], [store_id], [category_id]) VALUES (5, N'حليب', N'111111111', N'123', CAST(0x0000AB71017AA01A AS DateTime), N'Chrysanthemum.jpg', 9.5, 100, 10, N'', 1, 1, 1, 8)
INSERT [dbo].[product] ([product_id], [product_name], [product_code], [product_barcode], [product_dateadd], [product_img], [product_price], [product_quantity], [product_quantity_alert], [product_desc], [unit_id], [user_id], [store_id], [category_id]) VALUES (6, N'لبن رايب', N'222222222', N'1234', CAST(0x0000AB71017AA01A AS DateTime), N'Desert.jpg', 4, 100, 10, N'', 1, 1, 1, 8)
INSERT [dbo].[product] ([product_id], [product_name], [product_code], [product_barcode], [product_dateadd], [product_img], [product_price], [product_quantity], [product_quantity_alert], [product_desc], [unit_id], [user_id], [store_id], [category_id]) VALUES (7, N'كيك', N'333333333', N'12345', CAST(0x0000AB72017AA01A AS DateTime), N'Hydrangeas.jpg', 2.5, 200, 10, N'', 4, 1, 2, 7)
INSERT [dbo].[product] ([product_id], [product_name], [product_code], [product_barcode], [product_dateadd], [product_img], [product_price], [product_quantity], [product_quantity_alert], [product_desc], [unit_id], [user_id], [store_id], [category_id]) VALUES (8, N'سكر', N'444444444', N'123456', CAST(0x0000AB71017AA01A AS DateTime), N'Jellyfish.jpg', 5, 100, 10, N'', 1, 1, 1, 9)
INSERT [dbo].[product] ([product_id], [product_name], [product_code], [product_barcode], [product_dateadd], [product_img], [product_price], [product_quantity], [product_quantity_alert], [product_desc], [unit_id], [user_id], [store_id], [category_id]) VALUES (9, N'شيكولاته', N'555555555', N'1234567', CAST(0x0000AB73017AA01A AS DateTime), N'Koala.jpg', 3.5, 150, 10, N'', 4, 1, 2, 9)
INSERT [dbo].[product] ([product_id], [product_name], [product_code], [product_barcode], [product_dateadd], [product_img], [product_price], [product_quantity], [product_quantity_alert], [product_desc], [unit_id], [user_id], [store_id], [category_id]) VALUES (14, N'زبادى', N'666666666', N'12345678', CAST(0x0000AB74017AA01A AS DateTime), N'Lighthouse.jpg', 5.5, 200, 10, N'', 4, 1, 1, 8)
INSERT [dbo].[product] ([product_id], [product_name], [product_code], [product_barcode], [product_dateadd], [product_img], [product_price], [product_quantity], [product_quantity_alert], [product_desc], [unit_id], [user_id], [store_id], [category_id]) VALUES (15, N'بسكويت', N'777777777', N'123456789', CAST(0x0000AB74017AA01A AS DateTime), N'Tulips.jpg', 5, 150, 10, N'', 5, 1, 5, 8)
INSERT [dbo].[product] ([product_id], [product_name], [product_code], [product_barcode], [product_dateadd], [product_img], [product_price], [product_quantity], [product_quantity_alert], [product_desc], [unit_id], [user_id], [store_id], [category_id]) VALUES (17, N'لب سورى', N'888888888', N'12334567890', CAST(0x0000AB73017AA01A AS DateTime), NULL, 6.5, 100, 10, N'', 5, 1, 5, 0)
INSERT [dbo].[product] ([product_id], [product_name], [product_code], [product_barcode], [product_dateadd], [product_img], [product_price], [product_quantity], [product_quantity_alert], [product_desc], [unit_id], [user_id], [store_id], [category_id]) VALUES (25, N'لب مصرى', N'999999999', N'0123456789', CAST(0x0000AB75017AA01A AS DateTime), N'Lighthouse.jpg', 3, 200, 10, N'', 5, 1, 2, 10)
INSERT [dbo].[product] ([product_id], [product_name], [product_code], [product_barcode], [product_dateadd], [product_img], [product_price], [product_quantity], [product_quantity_alert], [product_desc], [unit_id], [user_id], [store_id], [category_id]) VALUES (26, N'بيبسى', N'000000000', N'1023456789', CAST(0x0000AB7501694DF6 AS DateTime), N'Desert.jpg', 2.5, 100, 10, N'', 5, 1, 1, 10)
INSERT [dbo].[product] ([product_id], [product_name], [product_code], [product_barcode], [product_dateadd], [product_img], [product_price], [product_quantity], [product_quantity_alert], [product_desc], [unit_id], [user_id], [store_id], [category_id]) VALUES (27, N'سكر نبات', N'0987654321', N'', CAST(0x0000AB9D011A62E1 AS DateTime), N'Penguins.jpg', 10, 100, 5, N'', 2, 1, 10, 12)
SET IDENTITY_INSERT [dbo].[product] OFF
/****** Object:  View [dbo].[View_order_POS_Back]    Script Date: 05/28/2020 00:16:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_order_POS_Back]
AS
SELECT     dbo.order_master.order_master_code, dbo.order_master.branch_id, dbo.order_master.store_id, dbo.order_master.order_master_datecreation, 
                      dbo.order_master.order_master_dicount, dbo.order_master.order_master_tax, dbo.order_master.order_master_houre, dbo.order_master.user_id, 
                      dbo.order_master.emp_id, dbo.order_master.order_master_total_price, dbo.order_master.payment_id, dbo.order_details.product_id, 
                      dbo.order_details.order_details_quantity, dbo.order_details.unit_id, dbo.order_details.order_details_product_price, dbo.order_details.order_details_total_price, 
                      dbo.product.product_name, dbo.all_users.user_fullname, dbo.unit.unit_name, dbo.all_users.user_name, dbo.branch.branch_name, dbo.store.store_name, 
                      dbo.method_pay.payment_name
FROM         dbo.order_details INNER JOIN
                      dbo.product ON dbo.order_details.product_id = dbo.product.product_id INNER JOIN
                      dbo.all_users ON dbo.product.user_id = dbo.all_users.user_id INNER JOIN
                      dbo.order_master ON dbo.order_details.order_master_code = dbo.order_master.order_master_code INNER JOIN
                      dbo.unit ON dbo.order_details.unit_id = dbo.unit.unit_id INNER JOIN
                      dbo.store ON dbo.product.store_id = dbo.store.store_id INNER JOIN
                      dbo.branch ON dbo.all_users.branch_id = dbo.branch.branch_id INNER JOIN
                      dbo.method_pay ON dbo.order_master.payment_id = dbo.method_pay.payment_id
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[54] 4[6] 2[8] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "order_details"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 253
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "product"
            Begin Extent = 
               Top = 175
               Left = 625
               Bottom = 283
               Right = 816
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "all_users"
            Begin Extent = 
               Top = 10
               Left = 677
               Bottom = 118
               Right = 847
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "order_master"
            Begin Extent = 
               Top = 7
               Left = 381
               Bottom = 115
               Right = 593
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "unit"
            Begin Extent = 
               Top = 226
               Left = 396
               Bottom = 319
               Right = 547
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "store"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "branch"
            Begin Extent = 
               Top = 222
               Left = 38
               Bottom = 330
               Right = 195
            End
            DisplayFlags = ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_order_POS_Back'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'280
            TopColumn = 0
         End
         Begin Table = "method_pay"
            Begin Extent = 
               Top = 214
               Left = 220
               Bottom = 307
               Right = 374
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 24
         Width = 284
         Width = 2910
         Width = 1500
         Width = 1500
         Width = 2745
         Width = 2295
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3150
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2250
         Width = 1500
         Width = 1875
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_order_POS_Back'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_order_POS_Back'
GO
/****** Object:  View [dbo].[View_1]    Script Date: 05/28/2020 00:16:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_1]
AS
SELECT     dbo.order_master.order_kind_id, dbo.branch.branch_name, dbo.store.store_name, dbo.order_master.order_master_code, dbo.product.product_name, 
                      dbo.order_master.order_master_datecreation, dbo.order_details.order_details_quantity, dbo.order_details.order_details_product_price, dbo.unit.unit_name, 
                      dbo.order_details.order_details_total_price, dbo.product.product_code
FROM         dbo.order_details INNER JOIN
                      dbo.order_master INNER JOIN
                      dbo.branch ON dbo.order_master.branch_id = dbo.branch.branch_id INNER JOIN
                      dbo.store ON dbo.order_master.store_id = dbo.store.store_id ON dbo.order_details.order_master_code = dbo.order_master.order_master_code INNER JOIN
                      dbo.product ON dbo.order_details.product_id = dbo.product.product_id INNER JOIN
                      dbo.unit ON dbo.order_details.unit_id = dbo.unit.unit_id
WHERE     (dbo.order_master.order_kind_id = '1')
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "order_details"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 253
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "order_master"
            Begin Extent = 
               Top = 6
               Left = 291
               Bottom = 114
               Right = 503
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "branch"
            Begin Extent = 
               Top = 6
               Left = 541
               Bottom = 114
               Right = 698
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "store"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "product"
            Begin Extent = 
               Top = 114
               Left = 227
               Bottom = 222
               Right = 418
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "unit"
            Begin Extent = 
               Top = 114
               Left = 456
               Bottom = 207
               Right = 607
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'        Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
/****** Object:  Trigger [trg_Product_Price]    Script Date: 05/28/2020 00:16:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_Product_Price]
ON [dbo].[product] after UPDATE,Insert
AS
BEGIN
	IF UPDATE (product_price) OR UPDATE (product_desc)

BEGIN
    INSERT INTO recentPrice(
        recentPrice_productId,
        recentPrice_ProductCode,
        recentPrice_productPriceOld,
        recentPrice_productPriceNew,
        recentPrice_productDateEdit
        )
    SELECT 
        i.product_id,
        i.product_code,
        d.product_price,
        i.product_price,
        GETDATE()
    FROM inserted i
    LEFT JOIN deleted d
        ON i.product_id = d.product_id
    WHERE i.product_price != ISNULL(d.product_price, -1)
END 
END
GO
