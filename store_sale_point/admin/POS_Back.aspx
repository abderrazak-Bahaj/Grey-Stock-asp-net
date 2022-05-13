<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="POS_Back.aspx.cs" Inherits="store_sale_point.admin.POS_Back" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .s
        {
            margin-top: 10px;
        }
    </style>

    <script type="text/javascript">
        function confirm() {
            $('#confirmPrint').modal('close');
        }
    </script>

        <script type="text/javascript">
            function PrintElem(elem) {
                Popup($(elem).html());
            }

            function Popup(data) {
                var mywindow = window.open('', 'div1', 'height=400,width=600');
                mywindow.document.write('<html><head><title></title>');
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="widget-head" style="margin-bottom: 20px;">
        <asp:Label ID="lblheadertxt" runat="server" Text=" مرتجع مبيعات  - Sales Return " Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
    </div>
    <div style="width: 98%; margin: 20px auto">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">

            <ContentTemplate>
                <div style="width: 50%; float: right; text-align: center; margin-top: 20px">
                    <div class="input-append">
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtSerachId" runat="server" Width="230px" placeholder="من فضلك ادخل الفاتورة"></asp:TextBox></td>
                                <td>
                                    <asp:LinkButton ID="btnSearch" runat="server" class="btn" OnClick="btnSearch_Click">
                    <i class="icon-search"></i>
                                    </asp:LinkButton></td>
                            </tr>
                        </table>
                    </div>
                    <%--<div style="text-align: right; margin: 10px; width: 100%">--%>

                    <asp:GridView Width="95%" DataKeyNames="product_id" ID="grdCartItem" runat="server" AutoGenerateColumns="False"
                        CssClass="table-hover cdynamicTable table table-striped table-bordered table-condensed dataTable" EmptyDataText="لا يتوجد بيانات للفاتورة">
                        <Columns>

                            <asp:TemplateField HeaderText="مسلسل">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex +1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="رقم المنتج" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblproduct_id" runat="server" Text='<%# Eval("product_id") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="اسم المنتج">
                                <ItemTemplate>
                                    <asp:Label ID="lblproduct_name" runat="server" Text='<%# Eval("product_name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="الكمية">
                                <ItemTemplate>
                                    <%--<asp:Label ID="lblproduct_quantity" runat="server" Text='<%# Eval("order_details_quantity") %>'></asp:Label>--%>
                                    <asp:TextBox ID="lblproduct_quantity" runat="server" Text='<%# Eval("order_details_quantity") %>' Width="15px" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="الوحدة">
                                <ItemTemplate>
                                    <asp:Label ID="lblunit_id" runat="server" Text='<%# Eval("unit_id") %>' Visible="false"></asp:Label>
                                    <asp:Label ID="lblunit_name" runat="server" Text='<%# Eval("unit_name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderTemplate>السعر</HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblproduct_price" runat="server" Text='<%# Eval("order_details_product_price") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="الاجمالى">
                                <ItemTemplate>
                                    <asp:Label ID="lblTotal" runat="server" Text='<%# Eval("order_details_total_price") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="اختار">
                                <ItemTemplate>
                                    <asp:CheckBox ID="ChkSelect" runat="server" AutoPostBack="false" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <div style="text-align: left; margin: 10px">
                        <asp:LinkButton ID="btnReturn" runat="server" CssClass="btn btn-danger" OnClick="btnReturn_Click">استرجاع</asp:LinkButton>
                    </div>
                    <div>
                        <table id="tblMasterOrder" runat="server" style="width: 100%; font-family: tahoma; font-size: 13px">
                            <tr>
                                <td style="text-align: left; padding: 15px 0px">رقم الفاتورة</td>
                                <td style="text-align: center; padding: 15px 0px">
                                    <asp:Label ID="lbl1" runat="server" /></td>
                                <td style="text-align: left; padding: 15px 0px">تاريخ الفاتورة</td>
                                <td style="text-align: center; padding: 15px 0px">
                                    <asp:Label ID="lbl2" runat="server" /></td>
                            </tr>
                            <tr>
                                <td style="text-align: left; padding: 7px 0px">اسم العميل</td>
                                <td style="text-align: center; padding: 7px 0px">
                                    <asp:Label ID="lbl6" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left;">رقم الفرع</td>
                                <td style="text-align: right;">
                                    <asp:DropDownList ID="drpBranchId" runat="server" Width="150px" Enabled="false"></asp:DropDownList></td>
                                <td style="text-align: left;">رقم المخزن
                                </td>
                                <td style="text-align: right;">
                                    <asp:DropDownList ID="drpStoreId" runat="server" Width="150px" Enabled="false"></asp:DropDownList></td>
                            </tr>

                            <tr>
                                <td style="text-align: left; padding: 7px 0px">الضريبه</td>
                                <td style="text-align: center; padding: 7px 0px">
                                    <asp:Label ID="lbl3" runat="server" /></td>
                                <td style="text-align: left; padding: 7px 0px">الخصم
                                </td>
                                <td style="text-align: center; padding: 7px 0px">
                                    <asp:Label ID="lbl4" runat="server" /></td>
                            </tr>
                            <tr>
                                <td style="text-align: left">السداد</td>
                                <td style="text-align: right">
                                    <asp:DropDownList ID="drpMethodPay" runat="server" Width="150px" Enabled="false"></asp:DropDownList></td>
                                <td style="text-align: left">الاجمالى
                                </td>
                                <td style="text-align: center">
                                    <asp:Label ID="lbl5" runat="server" /></td>
                            </tr>
                            <tr>
                                <td style="text-align: left">موظف البيع</td>
                                <td colspan="2" style="text-align: right">
                                    <asp:DropDownList ID="drpEmpId" runat="server" Width="250px"></asp:DropDownList></td>

                            </tr>
                        </table>
                    </div>
                    <%--</div>--%>
                </div>

                <div style="width: 50%; float: left;">
                    <div id="Show" runat="server">
                        <div style="font-size: 20px; font-weight: bold; text-decoration: underline">
                            بند المرتجـعات
                        </div>
                        <div style="margin: 10px; font-family: 16px; font-weight: bold">
                            <table>
                                <tr>
                                    <td>رقم فاتورة المرتجع</td>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" /></td>
                                </tr>
                            </table>
                        </div>
                        <div>
                            <asp:GridView Width="95%" DataKeyNames="product_id" ID="grdItemReturn" runat="server" AutoGenerateColumns="False"
                                CssClass="table-hover cdynamicTable table table-striped table-bordered table-condensed dataTable" OnRowDeleting="grdItemReturn_RowDeleting" ShowFooter="True">
                                <Columns>

                                    <asp:TemplateField HeaderText="مسلسل">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex +1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="رقم المنتج" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblproduct_id" runat="server" Text='<%# Eval("product_id") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="اسم المنتج">
                                        <ItemTemplate>
                                            <asp:Label ID="lblproduct_name" runat="server" Text='<%# Eval("product_name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="الكمية">
                                        <ItemTemplate>
                                            <%--<asp:Label ID="lblproduct_quantity" runat="server" Text='<%# Eval("quantity") %>'></asp:Label>--%>
                                            <asp:TextBox ID="lblproduct_quantity" runat="server" Text='<%# Eval("quantity") %>' Width="15px" />

                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="الوحدة">
                                        <ItemTemplate>
                                            <asp:Label ID="lblunit_id" runat="server" Text='<%# Eval("unit_id") %>' Visible="false"></asp:Label>
                                            <asp:Label ID="lblunit_name" runat="server" Text='<%# Eval("unit_name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField>
                                        <HeaderTemplate>السعر</HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblproduct_price" runat="server" Text='<%# Eval("order_details_product_price") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="الاجمالى">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTotal" runat="server" Text='<%# Eval("order_details_total_price") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="تراجع">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnDelete" CommandName="Delete" runat="server">
<img src="../img/Delete.png" />
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                        <div style="margin: 20px;">
                            <table style="font-family: tahoma; font-size: 13px">
                                <tr>

                                    <td style="text-align: left">الفرع</td>
                                    <td colspan="2" style="text-align: right">
                                        <asp:DropDownList ID="DrpreturnBranch_id" runat="server" Enabled="false"></asp:DropDownList></td>
                                </tr>
                                <tr>

                                    <td style="text-align: left">المخزن</td>
                                    <td colspan="2" style="text-align: right">
                                        <asp:DropDownList ID="DrpreturnStore_id" runat="server"></asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:LinkButton ID="btnSave" runat="server" OnClick="btnSave_Click" CssClass="btn btn-success">حفظ فاتورة المرتجع</asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>


                <div>
                    <div class="modal fade" id="confirmPrint" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel"> فاتورة مرتجع المبيعات </h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div id="div1">
                                        <asp:GridView Width="95%" DataKeyNames="product_id" ID="grdPrint" runat="server" AutoGenerateColumns="False"
                                            CssClass="table-hover cdynamicTable table table-striped table-bordered table-condensed dataTable">
                                            <Columns>
                                                <asp:TemplateField HeaderText="مسلسل">
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex +1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="اسم المنتج">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblproduct_name" runat="server" Text='<%# Eval("product_name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="الكمية">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblproduct_quantity" runat="server" Text='<%# Eval("order_details_quantity") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="الوحدة">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblunit_name" runat="server" Text='<%# Eval("unit_name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>السعر</HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblproduct_price" runat="server" Text='<%# Eval("order_details_product_price") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="الاجمالى">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTotal" runat="server" Text='<%# Eval("order_details_total_price") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <%--<button type="button" class="btn btn-primary">Save changes</button>--%>
                                    <asp:LinkButton ID="btnPrintreturn" runat="server" OnClientClick="PrintElem('#div1')" OnClick="btnPrintreturn_Click" CssClass="btn btn-primary">طباعة فاتورة المرتجع</asp:LinkButton>


                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>

        </asp:UpdatePanel>

    </div>

    <div class="clearfix"></div>
</asp:Content>
