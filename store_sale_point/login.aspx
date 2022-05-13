<%@ Page Title="" Language="C#" MasterPageFile="~/admin_Login.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="store_sale_point.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="login" style="text-align: right; direction: rtl;font-family:tahoma">
        <div class="form-signin">
            <h3 class="glyphicons unlock form-signin-heading"><i></i>Sign in</h3>
            <div class="uniformjs">
                <input id="txtUserName" runat="server" type="text" class="input-block-level" placeholder="اسم المستخدم">
                <input id="txtPassword" runat="server" type="password" class="input-block-level" placeholder="كلمة المرور">
                <label class="checkbox">
                    <input type="checkbox" value="remember-me"> تذكرنى </label>
            </div>
            <div style="text-align:left;direction:ltr">
                <asp:LinkButton class="btn btn-large btn-primary" ID="btnLogin" OnClick="btnLogin_Click" runat="server">دخول</asp:LinkButton>
            </div>
        </div>
    </div>

</asp:Content>
