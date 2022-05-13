<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test6.aspx.cs" Inherits="Test6" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        Search Customer:
        <asp:TextBox ID="txtSearch" runat="server" OnTextChanged="Search" AutoCompleteType="Disabled"></asp:TextBox>
        <hr />
        <%--        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>--%>



        <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="false" AllowPaging="true" OnPageIndexChanging="OnPaging" PageSize="5" AllowSorting="true" OnSorting="gvCustomers_Sorting">
            <Columns>
                <asp:TemplateField HeaderText="ContactName" SortExpression="ContactName">
<%--                    <HeaderTemplate>
                        <asp:Label ID="lblContactName" Text="ContactName" runat="server" />:
                    <asp:DropDownList ID="ddlContactName" CssClass="form-control" runat="server" OnSelectedIndexChanged="DropDownChange"
                        AutoPostBack="true">
                    </asp:DropDownList>
                    </HeaderTemplate>--%>
                    <ItemTemplate>
                        <asp:HiddenField ID="hfContactName" runat="server" Value='<%# Eval("ContactName") %>' />
                        <%# Eval("ContactName") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="City" SortExpression="City">
<%--                    <HeaderTemplate>
                        <asp:Label ID="lblCity" Text="City" runat="server" />:
                    <asp:DropDownList ID="ddlCity" runat="server" OnSelectedIndexChanged="DropDownChange"
                        AutoPostBack="true">
                    </asp:DropDownList>
                    </HeaderTemplate>--%>
                    <ItemTemplate>
                        <%# Eval("City") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:Label ID="lblCountry" Text="Country" runat="server" />:
                    <asp:DropDownList ID="ddlCountry" runat="server" OnSelectedIndexChanged="DropDownChange"
                        AutoPostBack="true">
                    </asp:DropDownList>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <%# Eval("Country") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:Label ID="lblPostalCode" Text="PostalCode" runat="server" />:
                    <asp:DropDownList ID="ddlPostalCode" runat="server" OnSelectedIndexChanged="DropDownChange"
                        AutoPostBack="true">
                    </asp:DropDownList>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <%# Eval("PostalCode")%>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#808080" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>
        <table id="emptyTable" runat="server" visible="false">
            <tr>
                <td colspan="4">No Records Found!
                </td>
            </tr>
        </table>
        <%--            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="txtSearch" EventName="TextChanged" />
            </Triggers>
        </asp:UpdatePanel>--%>
    </form>
</body>
</html>
