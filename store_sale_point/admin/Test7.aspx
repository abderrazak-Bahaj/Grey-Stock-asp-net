<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test7.aspx.cs" Inherits="store_sale_point.admin.Test7" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" AllowPaging="true" PageSize="4" OnPageIndexChanging="GridView1_PageIndexChanging" OnSelectedIndexChanging="GridView1_SelectedIndexChanging">
                <Columns>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblId" runat="server" Text="Label"></asp:Label>
                            <asp:DropDownList ID="drpId" runat="server" AutoPostBack="true" OnSelectedIndexChanged="drpId_SelectedIndexChanged"></asp:DropDownList>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <%# Eval("id") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblContactName" runat="server" Text="Label"></asp:Label>
                            <asp:DropDownList ID="drpContactName" runat="server" AutoPostBack="true"></asp:DropDownList>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <%# Eval("ContactName") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblCity" runat="server" Text="Label"></asp:Label>
                            <asp:DropDownList ID="drpCity" runat="server" AutoPostBack="true"></asp:DropDownList>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <%# Eval("City") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
