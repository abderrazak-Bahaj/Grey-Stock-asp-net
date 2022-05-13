<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="historyInOut_User.aspx.cs" Inherits="store_sale_point.admin.historyInOut_User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="widget-head">
        <asp:Label ID="lblheadertxt" runat="server" Text=" ارشيف دخول المستخدم للبرنامج - History Time Enter User" Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
    </div>
    <div style="margin:20px">
        <asp:GridView ID="grdhistoryInOut_User" AllowPaging="true" AutoGenerateColumns="false" PageSize="15" runat="server"
            CssClass="table-hover cdynamicTable table table-striped table-bordered table-condensed dataTable"
            OnPageIndexChanging="grdhistoryInOut_User_PageIndexChanging" Width="75%">
            <Columns>
                <asp:TemplateField HeaderText="مسلسل">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="وقت الدخول">
                    <ItemTemplate>
                        <asp:Label ID="lblhistory_DateTimeIn" runat="server" Text='<%# Eval("history_DateTimeIn") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="وقت الخروج">
                    <ItemTemplate>
                        <asp:Label ID="lblhistory_DateTimeOut" runat="server" Text='<%# Eval("history_DateTimeOut") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ip Address">
                    <ItemTemplate>
                        <asp:Label ID="lblhistory_getIpClient" runat="server" Text='<%# Eval("history_getIpClient") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="اسم الجهاز">
                    <ItemTemplate>
                        <asp:Label ID="lblhistory_getNameClient" runat="server" Text='<%# Eval("history_getNameClient") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>
