<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="rep_Dialy_sales.aspx.cs" Inherits="store_sale_point.admin.rep_Dialy_sales" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

    <script>
        $(function () {
            $("#txtDateFrom").datepicker({
                defaultDate: "+1w",
                changeMonth: true,
                onClose: function (selectedDate) {
                    $("#txtDateFrom").datepicker("option", "minDate", selectedDate);
                }
            });

            $("#txtDateTo").datepicker({
                defaultDate: "+1w",
                changeMonth: true,
                onClose: function (selectedDate) {
                    $("#txtDateTo").datepicker("option", "maxDate", selectedDate);
                }

            });
        })
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="widget-head">
        <asp:Label ID="lblheadertxt" runat="server" Text=" تقرير اليوميات للمبيعات  - Dialy Sales Report " Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
    </div>
    <br />
    <div style="font-family: tahoma">
        <table>
            <tr>
                <td>الفرع</td>
                <td>
                    <asp:DropDownList ID="drpBranch_id" runat="server" AutoPostBack="true" OnSelectedIndexChanged="drpBranch_id_SelectedIndexChanged"></asp:DropDownList></td>
                <td></td>
            </tr>
            <tr>
                <td>المخزن</td>
                <td>
                    <asp:DropDownList ID="drpStore_id" runat="server"></asp:DropDownList></td>
                <td></td>
            </tr>
            <tr>
                <td>من تاريخ</td>
                <td>
                    <asp:TextBox ID="txtDateFrom" runat="server" AutoCompleteType="Disabled" />
                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtDateFrom"></cc1:CalendarExtender>

                </td>

                <td></td>
            </tr>
            <tr>
                <td>الى تاريخ</td>
                <td>
                    <asp:TextBox ID="txtDateTo" runat="server" AutoCompleteType="Disabled" />
                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDateTo"></cc1:CalendarExtender>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>السداد</td>
                <td>
                    <asp:DropDownList ID="drppayment_id" runat="server"></asp:DropDownList></td>
                <td></td>
            </tr>
            <tr>
                <td>رقم الفاتورة</td>
                <td>
                    <asp:TextBox ID="txtInvoiceSales" runat="server"></asp:TextBox></td>
                <td></td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:Button ID="btnSearch" CssClass="btn btn-default" runat="server" Text="بحـث" OnClick="btnSearch_Click" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="PrintElem('#div1')">طبـاعة</asp:LinkButton></td>
            </tr>
        </table>
    </div>
    <hr />
    <br />

    <div id="divPrint" runat="server">
        <div id="div1">
            <table style="width: 100%">
                <tr>
                    <td style="text-align: right">
                        <asp:Label ID="lblCompanyName" runat="server" Style="font-weight: 700"></asp:Label></td>
                    <td style="text-align: left">
                        <asp:Label ID="lblDateNow" runat="server" Style="font-weight: 700"></asp:Label></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
            </table>
            <hr />

            <table style="width: 100%">
                <tr>
                    <asp:GridView ID="grdSales" runat="server" AutoGenerateColumns="false" Width="95%"
                        CssClass="dynamicTable table table-striped table-bordered table-condensed dataTable table-hover" ShowFooter="true">
                        <Columns>
                            <asp:TemplateField HeaderText="مسلسل">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="رقم الفاتورة">
                                <ItemTemplate>
                                    <asp:Label ID="lblorder_master_code" runat="server" Text='<%# Eval("order_master_code") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="تاريخ الفاتورة">
                                <ItemTemplate>
                                    <asp:Label ID="lblorder_master_datecreation" runat="server" Text='<%# Eval("order_master_datecreation") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="اجمالى مبلغ الفاتورة">
                                <ItemTemplate>
                                    <asp:Label ID="lblorder_master_total_price" runat="server" Text='<%# Eval("order_master_total_price") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="السداد">
                                <ItemTemplate>
                                    <asp:Label ID="lblpayment_name" runat="server" Text='<%# Eval("payment_name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="الفرع">
                                <ItemTemplate>
                                    <asp:Label ID="lblbranch_name" runat="server" Text='<%# Eval("branch_name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="المخزن">
                                <ItemTemplate>
                                    <asp:Label ID="lblstore_name" runat="server" Text='<%# Eval("store_name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </tr>
                <tfoot>
                    <tr style="background-color: #0000FF; color: #FFFFFF">
                        <td>
                            <asp:Label ID="lbltxt" runat="server"></asp:Label></td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>


    <script type="text/javascript">
        function PrintElem(elem) {
            Popup($(elem).html());
        }

        function Popup(data) {
            var mywindow = window.open('', 'div1', 'height=400,width=600');
            mywindow.document.write('<html><head><title>طباعه</title>');
            /*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
            mywindow.document.write('</head><body >');
            mywindow.document.write(data);
            mywindow.document.write('</body></html>');

            mywindow.document.close(); // necessary for IE >= 10
            mywindow.focus(); // necessary for IE >= 10

            mywindow.print();
            mywindow.close();

            return true;
        }
    </script>




</asp:Content>
