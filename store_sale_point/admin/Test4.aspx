<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test4.aspx.cs" Inherits="store_sale_point.admin.Test4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>

        </div>
        <div>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <br />
                    <asp:Button ID="Button1" runat="server" Text="FillData" OnClick="Button1_Click" />
                    <br />
                    <div>
                        <asp:HiddenField ID="hfClassApplied" runat="server" />
                        <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                            PageSize="5" OnPageIndexChanging="gvCustomers_PageIndexChanging" OnRowDataBound="RowDataBound">
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblCustomerID" Text="CustomerID" runat="server" />
                                        <asp:TextBox ID="txtCustomerID" runat="server" AutoPostBack="true" OnTextChanged="TextChanged" />
                                        <asp:LinkButton ID="lnkCustomerID" runat="server" OnClick="Sort" CssClass="glyphicon glyphicon-arrow-up"></asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" Text='<%# Eval("id") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblCompanyName" Text="CompanyName" runat="server" />
                                        <asp:TextBox ID="txtCompanyName" runat="server" AutoPostBack="true" OnTextChanged="TextChanged" />
                                        <asp:LinkButton ID="lnkCompanyName" runat="server" OnClick="Sort" CssClass="glyphicon glyphicon-arrow-up"></asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" Text='<%# Eval("ContactName") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblContactName" Text="ContactName" runat="server" />
                                        <asp:TextBox ID="txtContactName" runat="server" AutoPostBack="true" OnTextChanged="TextChanged" />
                                        <asp:LinkButton ID="lnkContactName" runat="server" OnClick="Sort" CssClass="glyphicon glyphicon-arrow-up"></asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" Text='<%# Eval("City") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblCity" Text="City" runat="server" />
                                        <asp:TextBox ID="txtCity" runat="server" AutoPostBack="true" OnTextChanged="TextChanged" />
                                        <asp:LinkButton ID="lnkCity" runat="server" OnClick="Sort" CssClass="glyphicon glyphicon-arrow-up"></asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" Text='<%# Eval("Country") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblCountry" Text="Country" runat="server" />
                                        <asp:TextBox ID="txtCountry" runat="server" AutoPostBack="true" OnTextChanged="TextChanged" />
                                        <asp:LinkButton ID="lnkCountry" runat="server" OnClick="Sort" CssClass="glyphicon glyphicon-arrow-up"></asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label4" Text='<%# Eval("PostalCode") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>

        </div>
    </form>
</body>
</html>
