<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="rep_sales.aspx.cs" Inherits="store_sale_point.admin.rep_sales" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .displayprint {
            display: none !important;
            width: 100%;
            height: 377px;
        }
    </style>

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
        <asp:Label ID="lblheadertxt" runat="server" Text=" تقرير تفصيلى للمبيعات  - Detailed Sales Report " Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
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
                <td>كود المنتج</td>
                <td>
                    <asp:TextBox ID="txtCode_Product" runat="server"></asp:TextBox></td>
                <td></td>
            </tr>
            <tr>
                <td>من تاريخ</td>
                <td>
                    <asp:TextBox ID="txtDateFrom" runat="server" AutoCompleteType="Disabled" />
                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtDateFrom"></cc1:CalendarExtender>
                    <%--                    <div class="control-group">
                        <div class="controls">
                            <input type="text" id="txtDateFrom" value="" />
                        </div>
                    </div>--%>

                </td>

                <td></td>
            </tr>
            <tr>
                <td>الى تاريخ</td>
                <td>
                    <asp:TextBox ID="txtDateTo" runat="server" AutoCompleteType="Disabled" />
                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDateTo"></cc1:CalendarExtender>
                    <%--                    <div class="control-group">
                        <div class="controls">
                            <input type="text" id="txtDateTo" value="" />
                        </div>
                    </div>--%>
                </td>
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
        </table>
    </div>
    <hr />
    <br />

    <div id="divPrint" runat="server">
        <div id="div1">
            <table style="width: 100%">
                <tr>
                    <td style="text-align: right">
                        <asp:Label ID="lblCompanyName" CssClass="displayprint" runat="server" Style="font-weight: 700"></asp:Label></td>
                    <td>
                        <div>
                            <asp:Label ID="lblDateNow" CssClass="displayprint" runat="server" Style="font-weight: 700"></asp:Label>
                        </div>
                    </td>
                    <td style="text-align: left">
                        <asp:Image CssClass=" img-responsive displayprint" Width="100px" Height="50px" ImageUrl="~/img/Acess_Denied.jpg" ID="Image1" runat="server" />
                </tr>
                <tr>
                    <td></td>
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
                            <asp:TemplateField HeaderText="كود المنتج">
                                <ItemTemplate>
                                    <asp:Label ID="lblproduct_code" runat="server" Text='<%# Eval("product_code") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="المنتج">
                                <ItemTemplate>
                                    <asp:Label ID="lblproduct_name" runat="server" Text='<%# Eval("product_name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText=" كود الفاتورة المباع بها المنتج">
                                <ItemTemplate>
                                    <asp:Label ID="lblorder_master_code" runat="server" Text='<%# Eval("order_master_code") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText=" الوحدة">
                                <ItemTemplate>
                                    <asp:Label ID="lblunit_name" runat="server" Text='<%# Eval("unit_name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText=" الكمية">
                                <ItemTemplate>
                                    <asp:Label ID="lblorder_details_quantity" runat="server" Text='<%# Eval("order_details_quantity") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="السعر">
                                <ItemTemplate>
                                    <asp:Label ID="lblorder_details_product_price" runat="server" Text='<%# Eval("order_details_product_price") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="الاجمالى">
                                <ItemTemplate>
                                    <asp:Label ID="lblorder_details_total_price" runat="server" Text='<%# Eval("order_details_total_price") %>'></asp:Label>
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
        <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="PrintElem('#div1')">طبـاعة</asp:LinkButton>
    </div>


    <script type="text/javascript">
        function PrintElem(elem) {
            Popup($(elem).html());
        }

        function Popup(data) {
            var mywindow = window.open('', '_blank', 'width=750%,height=600%,location=no');
            mywindow.document.write('<html><head><title>طباعه</title>');
            /*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
            mywindow.document.write('</head><body dir="rtl">');
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
