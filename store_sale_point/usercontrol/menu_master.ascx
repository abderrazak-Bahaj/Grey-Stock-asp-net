<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="menu_master.ascx.cs" Inherits="store_sale_point.usercontrol.menu_master" %>
<span class="profile">
    <a class="img" href="my_account.html?lang=en">
        <img src="http://www.placehold.it/74x74/232323&amp;text=photo" alt="Mr. Awesome" /></a>
    <span>
        <strong>
            <asp:Label ID="Label1" runat="server"></asp:Label>


        </strong>
        <%--<a href="my_account.html?lang=en">edit account</a>--%>
    </span>
</span>

<ul>
    <li class="glyphicons home"><a href="../admin/home.aspx"><i></i><span>الصفحة الرئيسية</span></a></li>
    <li class="hasSubmenu glyphicons cogwheel">
        <a data-toggle="collapse" href="#menu_index" style="font-family: 'Times New Roman'; font-weight: bold"><i></i><span>الاعدادات</span></a>
        <ul class="collapse" id="menu_index">
            <%--<li class=""><a href="../file_managers.html?lang=en"><span>Dashboard v1</span></a></li>--%>
            <li class=""><a href="../admin/setting_general.aspx">الاعدادات العامه</a></li>
            <li class=""><a href="../admin/setting_branch.aspx" style="font-family: Tahoma;"><span>الفــروع</span></a></li>
            <li class=""><a href="../admin/setting_store.aspx" style="font-family: Tahoma;"><span>المخـازن</span></a></li>
            <li class=""><a href="../admin/setting_unit.aspx" style="font-family: Tahoma;"><span>الـوحدات</span></a></li>
            <li class=""><a href="../admin/setting_user_kind.aspx" style="font-family: Tahoma;">نوع المستخدمين</a></li>
            <li class=""><a href="../admin/setting_order_kind.aspx" style="font-family: Tahoma;">نوع الطلب</a></li>
            <li class=""><a href="../admin/setting_box_kind.aspx" style="font-family: Tahoma;">نوع الصندوق</a></li>
            <li class=""><a href="../admin/setting_box_account.aspx" style="font-family: Tahoma;">نوع الحسابات</a></li>
            <li class=""><a href="../admin/setting_category.aspx" style="font-family: Tahoma;">الاقســام</a></li>
            <li class=""><a href="../admin/setting_method_pay.aspx" style="font-family: Tahoma;">انـواع الـدفع</a></li>
        </ul>
        <span class="count">11</span>
    </li>

    <li class="hasSubmenu glyphicons folder_flag">
        <a data-toggle="collapse" href="#menu_components" style="font-family: 'Times New Roman'; font-weight: bold"><i></i><span>المخازن</span></a>
        <ul class="collapse" id="menu_components">
            <li class=""><a href="../admin/product_view.aspx" style="font-family: Tahoma;"><span>المنتجات</span></a></li>
            <li class=""><a href="../admin/product_add.aspx" style="font-family: Tahoma;"><span>اضافة منتج جديد</span></a></li>
            <li class=""><a href="../admin/product_historyPrice.aspx" style="font-family: Tahoma;"><span>ارشيف اسعار المنتجات</span></a></li>

        </ul>
        <span class="count">3</span>
    </li>

    <li class="hasSubmenu">
        <a data-toggle="collapse" class="glyphicons show_thumbnails_with_lines" href="#Ul1"><i></i><span>المبيعات والمشتريات</span></a>
        <ul class="collapse" id="Ul1">
            <li class=""><a href="../admin/POS.aspx" style="font-family: Tahoma;"><span>فاتورة مبيعات</span></a></li>
            <li class=""><a href="../admin/PO_Purchase.aspx" style="font-family: Tahoma;"><span>فاتورة مشتريات</span></a></li>
            <li class=""><a href="../admin/PO_Transfare.aspx" style="font-family: Tahoma;"><span>التحويلات بين الفروع</span></a></li>
            <li class=""><a href="../admin/POS_Back.aspx" style="font-family: Tahoma;"><span>فاتورة مرتجع مبيعات</span></a></li>
            <li class=""><a href="../admin/PO_Purchase_Back.aspx" style="font-family: Tahoma;"><span>فاتورة مرتجع مشتريات</span></a></li>

        </ul>
        <span class="count">5</span>
    </li>


    <li class="hasSubmenu">
        <a data-toggle="collapse" class="glyphicons show_thumbnails_with_lines" href="#menu_forms"><i></i><span>العملاء والمودرين</span></a>
        <ul class="collapse" id="menu_forms">
            <li class=""><a href="c_s_customer.aspx" style="font-family: Tahoma;"><span>العمـلاء </span></a></li>
            <li class=""><a href="c_s_supplier.aspx" style="font-family: Tahoma;"><span>المـوردين </span></a></li>
        </ul>
        <span class="count">2</span>
    </li>

    <li class="hasSubmenu">
        <a data-toggle="collapse" class="glyphicons show_thumbnails_with_lines" href="#Ul2"><i></i><span>التقارير</span></a>
        <ul class="collapse" id="Ul2">
            <li class=""><a href="../admin/rep_product.aspx" style="font-family: Tahoma;"><span>تقرير المنتجات </span></a></li>
            <li class=""><a href="../admin/rep_sales.aspx" style="font-family: Tahoma;"><span>تقرير تفصيلى للمبيعات </span></a></li>
            <li class=""><a href="../admin/rep_sales_Total.aspx" style="font-family: Tahoma;"><span>تقرير اجمالى للمبيعات </span></a></li>
            <li class=""><a href="../admin/rep_Dialy_sales.aspx" style="font-family: Tahoma;"><span>تقرير اليوميات </span></a></li>
        </ul>
        <span class="count">4</span>
    </li>
    <li class="hasSubmenu">
        <a data-toggle="collapse" class="glyphicons show_thumbnails_with_lines" href="#Ul3"><i></i><span>الصندوق</span></a>
        <ul class="collapse" id="Ul3">
            <li class=""><a href="../admin/box.aspx" style="font-family: Tahoma;"><span>حساب الصندوق</span></a></li>
        </ul>
        <span class="count">1</span>
    </li>
    <li class="hasSubmenu">
        <a data-toggle="collapse" class="glyphicons show_thumbnails_with_lines" href="#Ul4"><i></i><span>المستخدمين</span></a>
        <ul class="collapse" id="Ul4">
            <li class=""><a href="../admin/setting_permission_users.aspx" style="font-family: Tahoma;"><span>المسـتخدمين</span></a></li>
            <li class=""><a href="../admin/setting_permission_Activation_users.aspx" style="font-family: Tahoma;"><span>تنشيط المستخدمين</span></a></li>
            <li class=""><a href="../admin/setting_permission_pages.aspx" style="font-family: Tahoma;"><span>صفحات البرنامج</span></a></li>
            <li class=""><a href="../admin/setting_permission_group.aspx" style="font-family: Tahoma;">مجموعات المـستخدمين</a></li>
            <li class=""><a href="../admin/setting_permission_pagesInGroup.aspx" style="font-family: Tahoma;">ربط الصفحات بالمجموعات</a></li>
            <li class=""><a href="../admin/setting_permission_UserInGroup.aspx" style="font-family: Tahoma;">صلاحيات المجموعات</a></li>
        </ul>
        <span class="count">5</span>
    </li>
    <li class="glyphicons calendar"><a href="../admin/historyInOut_User.aspx"><i></i><span>ارشيف دخول المستخدم</span></a></li>
    <li style="padding-left: 60px" class=""><i></i><span>
        <asp:LinkButton ID="BtnExit" OnClick="BtnExit_Click" runat="server">خروج</asp:LinkButton></span></li>
    <%--    <li class="hasSubmenu">
        <a data-toggle="collapse" class="glyphicons shopping_cart" href="#menu_ecommerce"><i></i><span>Online Shop</span></a>
        <ul class="collapse" id="menu_ecommerce">
            <li class=""><a href="products.html?lang=en"><span>Products</span></a></li>
            <li class=""><a href="product_edit.html?lang=en"><span>Add product</span></a></li>
        </ul>
        <span class="count">2</span>
    </li>--%>
    <%--    <li class="hasSubmenu glyphicons gift">
        <a data-toggle="collapse" href="#menu_extra"><i></i><span>Extra</span></a>
        <ul class="collapse" id="menu_extra">
            <li class=""><a href="login.html?lang=en"><span>Login</span></a></li>
            <li class=""><a href="my_account.html?lang=en"><span>My Account</span></a></li>
            <li class=""><a href="bookings.html?lang=en"><span>Bookings</span></a></li>
            <li class=""><a href="finances.html?lang=en"><span>Finances</span></a></li>
            <li class=""><a href="pages.html?lang=en"><span>Site Pages</span></a></li>
        </ul>
        <span class="count">5</span>
    </li>--%>
</ul>



<div class="clearfix" style="clear: both"></div>
