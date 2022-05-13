<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test1.aspx.cs" Inherits="store_sale_point.admin.Test1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>

                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>

            </div>
            <div>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                            PageSize="5" OnPageIndexChanging="OnPaging">
                            <Columns>

                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblContactName" Text="ContactName" runat="server" />:
                                      <asp:TextBox runat="server" ID="txtSearch" AutoPostBack="true"
                                          OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hfContactName" runat="server" Value='<%# Eval("ContactName") %>' />
                                        <%# Eval("ContactName") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblCity" Text="City" runat="server" />:
                                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>

                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%# Eval("City") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblCountry" Text="Country" runat="server" />:
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%# Eval("Country") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblPostalCode" Text="PostalCode" runat="server" />:
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%# Eval("PostalCode")%>
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>

                    </ContentTemplate>
<%--                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtSearch" EventName="TextChanged"/>
                    </Triggers>--%>
                </asp:UpdatePanel>
                <table id="emptyTable" runat="server" visible="false">
                    <tr>
                        <td colspan="4">No Records Found!
                        </td>
                    </tr>
                </table>
            </div>

        </div>
    </form>
</body>
</html>
