<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="store_sale_point.admin.home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .w-i
        {
            margin-bottom: 5px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="center">
        <div dir="rtl" style="width: 90%; font-family: tahoma; font-weight: bold">
            <div class="row w-i">
                <div class="span2" style="width: 15%">
                    <a href="setting_general.aspx" class="widget-stats">
                        <span class="glyphicons cogwheel"><i></i></span>
                        <span class="txt">الاعدادات</span>
                        <div class="clearfix"></div>
                    </a>
                </div>
                <div class="span2" style="width: 15%">
                    <a href="product_view.aspx" class="widget-stats">
                        <span class="glyphicons folder_flag"><i></i></span>
                        <span class="txt">المخازن</span>
                        <div class="clearfix"></div>
                    </a>
                </div>
                <div class="span2" style="width: 15%">
                    <a href="setting_permission_users.aspx" class="widget-stats">
                        <span class="glyphicons group"><i></i></span>
                        <span class="txt">المستخدمين</span>
                        <div class="clearfix"></div>
                    </a>
                </div>
                <div class="span2" style="width: 15%">
                    <a href="c_s_supplier.aspx" class="widget-stats">
                        <span class="glyphicons parents"><i></i></span>
                        <span class="txt">الموردين</span>
                        <div class="clearfix"></div>
                    </a>
                </div>
                <div class="span2" style="width: 15%">
                    <a href="c_s_customer.aspx" class="widget-stats">
                        <span class="glyphicons user"><i></i></span>
                        <span class="txt">العملاء</span>
                        <div class="clearfix"></div>
                    </a>
                </div>
            </div>
            <div class="row w-i">
                <div class="span2" style="width: 15%">
                    <a href="POS_Back.aspx" class="widget-stats">
                        <span class="glyphicons repeat"><i></i></span>
                        <span class="txt">مرتجع المبيعات</span>
                        <div class="clearfix"></div>
                    </a>
                </div>
                <div class="span2" style="width: 15%">
                    <a href="PO_Purchase_Back.aspx" class="widget-stats">
                        <span class="glyphicons retweet"><i></i></span>
                        <span class="txt">مرتجع المشتريات</span>
                        <div class="clearfix"></div>
                    </a>
                </div>
                <div class="span2" style="width: 15%">
                    <a href="PO_Transfare.aspx" class="widget-stats">
                        <span class="glyphicons roundabout"><i></i></span>
                        <span class="txt">التحويلات بين الفروع</span>
                        <div class="clearfix"></div>
                    </a>
                </div>
                <div class="span2" style="width: 15%">
                    <a href="POS.aspx" class="widget-stats">
                        <span class="glyphicons cart_out"><i></i></span>
                        <span class="txt">المبيعات</span>
                        <div class="clearfix"></div>
                    </a>
                </div>
                <div class="span2" style="width: 15%">
                    <a href="PO_Purchase.aspx" class="widget-stats">
                        <span class="glyphicons cart_in"><i></i></span>
                        <span class="txt">المشتريات</span>
                        <div class="clearfix"></div>
                    </a>
                </div>
            </div>
            <div class="row w-i">
<%--                <div class="span2" style="width: 15%">
                    <a href="" class="widget-stats">
                        <span class="glyphicons cogwheel"><i></i></span>
                        <span class="txt">الاعدادات</span>
                        <div class="clearfix"></div>
                    </a>
                </div>--%>
<%--                <div class="span2" style="width: 15%">
                    <a href="" class="widget-stats">
                        <span class="glyphicons sort"><i></i></span>
                        <span class="txt">التقارير</span>
                        <div class="clearfix"></div>
                    </a>
                </div>--%>
                <div class="span2" style="width: 15%">
                    <a href="box.aspx" class="widget-stats">
                        <span class="glyphicons folder_open"><i></i></span>
                        <span class="txt">الصندوق</span>
                        <div class="clearfix"></div>
                    </a>
                </div>
                <div class="span2" style="width: 15%">
                    <a href="product_historyPrice.aspx" class="widget-stats">
                        <span class="glyphicons book_open"><i></i></span>
                        <span class="txt">ارشيف اسعار المنتجات</span>
                        <div class="clearfix"></div>
                    </a>
                </div>
                <div class="span2" style="width: 15%">
                    <a href="product_view.aspx" class="widget-stats">
                        <span class="glyphicons shopping_bag"><i></i></span>
                        <span class="txt">المنتجات</span>
                        <div class="clearfix"></div>
                    </a>
                </div>
            </div>
            <div class="row w-i">
                <div class="span2" style="width: 15%">
                    <a href="" class="widget-stats">
                        <span class="glyphicons sort"><i></i></span>
                        <span class="txt"></span>
                        <div class="clearfix"></div>
                    </a>
                </div>
                <div class="span2" style="width: 15%">
                    <a href="" class="widget-stats">
                        <span class="glyphicons sort"><i></i></span>
                        <span class="txt"></span>
                        <div class="clearfix"></div>
                    </a>
                </div>
                <div class="span2" style="width: 15%">
                    <a href="" class="widget-stats">
                        <span class="glyphicons sort"><i></i></span>
                        <span class="txt"></span>
                        <div class="clearfix"></div>
                    </a>
                </div>
                <div class="span2" style="width: 15%">
                    <a href="" class="widget-stats">
                        <span class="glyphicons sort"><i></i></span>
                        <span class="txt"></span>
                        <div class="clearfix"></div>
                    </a>
                </div>
                <div class="span2" style="width: 15%">
                    <a href="" class="widget-stats">
                        <span class="glyphicons sort"><i></i></span>
                        <span class="txt"></span>
                        <div class="clearfix"></div>
                    </a>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
