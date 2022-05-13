<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="store_sale_point.admin.Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript" src="../quicksearch.js"></script>


</head>
<body>
    <form id="form1" runat="server">
        <div>

            <div>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                    PageSize="5" OnPageIndexChanging="OnPaging" OnDataBound="GridView1_DataBound">
                    <Columns>

                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="lblContactName" Text="ContactName" runat="server" />:
                    <asp:DropDownList ID="ddlContactName" CssClass="form-control" runat="server" OnSelectedIndexChanged="DropDownChange"
                        AutoPostBack="true">
                    </asp:DropDownList>

                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:HiddenField ID="hfContactName" runat="server" Value='<%# Eval("ContactName") %>' />
                                <%# Eval("ContactName") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="lblCity" Text="City" runat="server" />:
                    <asp:DropDownList ID="ddlCity" runat="server" OnSelectedIndexChanged="DropDownChange"
                        AutoPostBack="true">
                    </asp:DropDownList>

                            </HeaderTemplate>
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
                </asp:GridView>
                <table id="emptyTable" runat="server" visible="false">
                    <tr>
                        <td colspan="4">No Records Found!
                        </td>
                    </tr>
                </table>
            </div>

        </div>
    </form>


    <script type="text/javascript">
        $(function () {
            $('.search_textbox').each(function (i) {
                $(this).quicksearch("[id*=GridView1] tr:not(:has(th))", {
                    'testQuery': function (query, txt, row) {
                        return $(row).children(":eq(" + i + ")").text().toLowerCase().indexOf(query[0].toLowerCase()) != -1;
                    }
                });
            });
        });
    </script>

</body>
</html>
