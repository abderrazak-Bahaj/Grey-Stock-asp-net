<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test2.aspx.cs" Inherits="store_sale_point.admin.Test2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <div>
  <%--              <asp:GridView ID="gvCustomers" AutoGenerateColumns="true" runat="server" EmptyDataText="No Records Found" OnDataBound="gvCustomers_DataBound" />--%>
                <br />
                <asp:Button ID="Button1" Text="SHOW ALL" OnClick="onclick" runat="server" />
            </div>

        </div>

        <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Font-Size="Small" EmptyDataText="No Record Display" CssClass="table" OnDataBound="gvCustomers_DataBound">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>

                <asp:BoundField DataField="ContactName" HeaderText="ContactName" />
                <asp:TemplateField>
                    <HeaderTemplate>
<%--                        <asp:TextBox ID="txtnik" runat="server" placeholder="Filter Nik" AutoPostBack="true" Width="100px" OnTextChanged="txtnik_TextChanged"></asp:TextBox>--%>
                    </HeaderTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="City" HeaderText="City" />
                <asp:TemplateField>
                    <HeaderTemplate>
<%--                        <asp:TextBox ID="txtnama" runat="server" placeholder="Filter Nama" AutoPostBack="true" Width="100px"></asp:TextBox>--%>
                    </HeaderTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="Country" HeaderText="Country" />
                <asp:TemplateField>
                    <HeaderTemplate>
<%--                        <asp:TextBox ID="txtfakultas" runat="server" placeholder="Filter Fakultas" AutoPostBack="true" Width="100px"></asp:TextBox>--%>
                    </HeaderTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
