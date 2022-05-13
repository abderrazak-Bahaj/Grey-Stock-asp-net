<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test3.aspx.cs" Inherits="store_sale_point.admin.Test3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <%--<script type="text/javascript" src="quicksearch.js"></script>--%>
    <script src="../quicksearch.js"></script>
    <%--        <script type="text/javascript">
        $(function () {
            $('.textbox').each(function (i) {
                $(this).quicksearch("[id*=gvCustomers] tr:not(:has(th))", {
                    'testQuery': function (query, txt, row) {
                        return $(row).children(":eq(" + i + ")").text().toLowerCase().indexOf(query[0].toLowerCase()) != -1;
                    }
                });
            });
        });
    </script>--%>
    <%--    <script>
        function SearchGrid(textbox, gvCustomers) {
            if ($("[id *=" + textbox + " ]").val() != "") {
                $("[id *=" + gvCustomers + " ]").children
                    ('tbody').children('tr').each(function () {
                        $(this).show();
                    });
                $("[id *=" + gvCustomers + " ]").children
                    ('tbody').children('tr').each(function () {
                        var match = false;
                        $(this).children('td').each(function () {
                            if ($(this).text().toUpperCase().indexOf($("[id *=" +
                                textbox + " ]").val().toUpperCase()) > -1) {
                                match = true;
                                return false;
                            }
                        });
                        if (match) {
                            $(this).show();
                            $(this).children('th').show();
                        }
                        else {
                            $(this).hide();
                            $(this).children('th').show();
                        }
                    });


                $("[id *=" + gvCustomers + " ]").children('tbody').
                    children('tr').each(function (index) {
                        if (index == 0)
                            $(this).show();
                    });
            }
            else {
                $("[id *=" + gvCustomers + " ]").children('tbody').
                    children('tr').each(function () {
                        $(this).show();
                    });
            }
        }
    </script>--%>

    <%--<script type="text/javascript">

        $(document).ready(function () {

            $('.textbox').keyup(function () {

                searchTable($(this).val());

            });

        });

        function searchTable(inputVal) {

            var table = $('#gvCustomers');

            table.find('tr').each(function (index, row) {

                var allCells = $(row).find('td');

                if (allCells.length > 0) {

                    var found = false;

                    allCells.each(function (index, td) {

                        var regExp = new RegExp(inputVal, 'i');

                        if (regExp.test($(td).text())) {

                            found = true;

                            return false;

                        }

                    });

                    if (found == true) $(row).show(); else $(row).hide();

                }

            });

        }

    </script>--%>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
        </div> 
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Font-Size="Small" EmptyDataText="No Record Display" CssClass="table" OnDataBound="gvCustomers_DataBound" PageSize="5" AllowPaging="True" OnPageIndexChanged="gvCustomers_PageIndexChanged" OnPageIndexChanging="gvCustomers_PageIndexChanging">
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
                            </HeaderTemplate>
                        </asp:TemplateField>



                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>

                        <br />
                <asp:Button ID="Button1" Text="SHOW ALL" OnClick="Button1_Click" runat="server" />
    </form>
</body>
</html>
