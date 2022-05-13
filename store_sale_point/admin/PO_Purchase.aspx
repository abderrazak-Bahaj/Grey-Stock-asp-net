<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="PO_Purchase.aspx.cs" Inherits="store_sale_point.admin.PO_Purchase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .listCat
        {
            margin-top: 10px;
            margin-left: 5px;
            background-color: #e4e1e1;
            padding: 5px;
            width: 90px;
            height: 45px;
            text-wrap: none;
            text-align: center;
            line-height: 40px;
            overflow-wrap: break-word;
            overflow: hidden;
            border-radius: 8px;
            border: 1px solid #f8f8f8;
            font-size: 15px;
        }

            .listCat:hover
            {
                border-radius: 0px;
                background-color: black;
                cursor: pointer;
                color: white;
            }

        .listProduct:hover
        {
            border-radius: 0px;
            cursor: pointer;
            color: #1586f3;
        }

        .table-bordered tbody tr th
        {
            text-align: center;
            color: red;
            vertical-align: middle;
        }

        .table-bordered tbody tr, .table-bordered tbody tr td
        {
            text-align: center;
            vertical-align: middle;
        }

            .table-bordered tbody tr td input[type="text"]
            {
                text-align: center;
                vertical-align: middle;
                align-items: center;
                border: 1px solid #ccc;
                border-radius: 4px;
                -moz-border-radius: 4px;
                -webkit-border-radius: 4px;
                margin-bottom: 0px;
            }

        .txtDiscount
        {
            float: right;
        }
    </style>

    <script type="text/javascript">
        function confirm() {
            $('#confirmSupplier').modal('close');
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
    <div class="widget-head">
        <asp:Label ID="lblheadertxt" runat="server" Text=" فاتورة مشتريات -   Purchases Bill" Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
    </div>
    <div style="width: 100%;">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>

                <div style="width: 60%; float: right;">

                    <%-- Btn new Order Purchase --%>
                    <div style="float: right; margin: 5px 5px 0px; display: block; width: 100%">
                        <asp:LinkButton ID="btnNewOrder" runat="server" OnClick="btnNewOrder_Click" Font-Underline="false" Font-Bold="true">طلب شراء جديد</asp:LinkButton>
                    </div>

                    <%-- Show Table Category --%>
                    <div>
                        <asp:Panel ID="pnlcategory" runat="server">

                            <asp:DataList DataKeyField="category_id" ID="dtcategory" runat="server" RepeatDirection="Horizontal" RepeatColumns="5" OnItemCommand="dtcategory_ItemCommand">
                                <ItemTemplate>
                                    <asp:Label Visible="false" ID="lblcategory_id" runat="server" Text='<%#Eval("category_id") %>' />
                                    <asp:LinkButton CssClass="btnCategorya" ID="btnCategory" runat="server" Font-Underline="false" Font-Bold="true"><div class="listCat"><%# Eval("category_name") %></div></asp:LinkButton>

                                </ItemTemplate>
                            </asp:DataList>

                        </asp:Panel>
                    </div>

                    <%-- Show Table Product --%>
                    <div>
                        <asp:Panel ID="pnlProduct" runat="server">
                            <asp:DataList DataKeyField="product_id" ID="dtproduct" runat="server" RepeatDirection="Horizontal" RepeatColumns="7" OnItemCommand="dtproduct_ItemCommand">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnProduct" Font-Underline="false" Font-Bold="true" runat="server">

                                        <div class="listProduct" style="padding: 5px 10px; margin: 10px; border: 1px solid #f6f6f6; font-size: 15px; background-color: #f8f8f8">
                                            <img src='<%# "/Upload/Product/" + Eval("product_img") %>' width="70" height="80" style="border-radius: 10px" />
                                            <hr style="margin-bottom: 0px;" />
                                            <asp:Label ID="lblproduct_name" runat="server" Text='<%# Eval("product_name") %>' />
                                            <asp:Label Visible="false" ID="lblproduct_id" runat="server" Text='<%# Eval("product_id") %>' />
                                        </div>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:DataList>
                        </asp:Panel>
                    </div>

                </div>

                <div style="width: 40%; float: left;">

                    <%-- label No of Order --%>
                    <div style="float: left; margin: 10px 5px;">
                        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                    </div>

                    <%-- table Order Details --%>
                    <div style="width: 100%; max-height: 230px; overflow: auto; overflow-x: hidden">
                        <asp:GridView ID="grdCart" DataKeyNames="product_id" AutoGenerateColumns="False"
                            runat="server" OnRowDataBound="grdCart_RowDataBound"
                            CssClass="dynamicTable table table-striped table-bordered table-condensed dataTable table-hover" OnRowDeleting="grdCart_RowDeleting" ShowFooter="True">
                            <Columns>
                                <asp:TemplateField HeaderText="مسلسل">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="product_id">
                                    <ItemTemplate>
                                        <asp:Label ID="lblproduct_id" runat="server" Text='<%# Eval("product_id") %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="اسـم المنتج">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("product_name") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="سـعر الشراء">
                                    <ItemTemplate>
                                        <asp:TextBox Width="25px" Height="15px" ID="txtproduct_price" AutoPostBack="true" OnTextChanged="txtproduct_price_TextChanged" runat="server" Text='<%# Eval("product_price") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText=" الكـمية ">
                                    <ItemTemplate>
                                        <asp:TextBox Width="25px" Height="15px" AutoPostBack="true" OnTextChanged="txtproduct_quantity_TextChanged" ID="txtproduct_quantity" runat="server" Text='<%# Eval("product_quantity") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="الاجمالى">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTotal" runat="server" Text='<%# Eval("total_price") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText=" عمليات ">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDel" runat="server" CommandName="Delete">
<img src="../img/Delete.png" />
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="headerStyle" />
                            <EmptyDataTemplate>لايوجد منتجات بهذا البحـث</EmptyDataTemplate>
                        </asp:GridView>

                    </div>

                    <%-- table Order Master --%>
                    <div style="width: 100%;">


                        <table id="TblMatser" runat="server">
                            <tr>
                                <td colspan="4">
                                    <hr style="margin-top: 5px; margin-bottom: 5px" />
                                </td>
                            </tr>
                            <tr>

                                <td>اسم المورد
                                </td>
                                <td colspan="3">
                                    <div class="input-append">
                                        <asp:TextBox ID="txtuser_id" runat="server" Width="60px" ReadOnly="true"></asp:TextBox>
                                        <asp:TextBox ID="txtSupplierName" runat="server" Width="200px" AutoCompleteType="Disabled"></asp:TextBox>

                                        <button style="margin-bottom: 10px" class="btn" type="button" data-toggle="modal" data-target="#confirmSupplier" data-whatever="@mdo">
                                            <i class="icon-search"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>الفرع
                                </td>
                                <td>
                                    <asp:DropDownList ID="Drpbranch_id" runat="server" Width="100px"></asp:DropDownList>
                                </td>
                                <td>المستودع
                                </td>
                                <td>
                                    <asp:DropDownList ID="Drpstore_id" runat="server" Width="150px"></asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>اسم المستخدم
                                </td>
                                <td colspan="3">
                                    <asp:DropDownList ID="Drpemp_id" runat="server" Width="95%" CssClass="txtDiscount"></asp:DropDownList>
                                </td>

                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td>الخصم</td>
                                <td>
                                    <asp:TextBox ID="txtorder_master_dicount" runat="server" Width="100px" OnTextChanged="txtorder_master_dicount_TextChanged" AutoPostBack="true" AutoCompleteType="Disabled" CssClass="txtDiscount"></asp:TextBox>
                                    <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="true" OnCheckedChanged="CheckBox1_CheckedChanged" />
                                    %
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td>الضريبه</td>
                                <td>
                                    <asp:TextBox ID="txtorder_master_tax" runat="server" AutoPostBack="true" OnTextChanged="txtorder_master_tax_TextChanged" Width="100%" AutoCompleteType="Disabled"></asp:TextBox>

                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td>الاجمالى</td>
                                <td>
                                    <asp:TextBox ID="txtorder_master_total_price" runat="server" Width="100%" AutoCompleteType="Disabled"></asp:TextBox>

                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td>السداد</td>
                                <td>
                                    <asp:DropDownList ID="Drppayment_id" runat="server" Width="110%"></asp:DropDownList>

                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <asp:LinkButton ID="btnSave" runat="server" OnClick="btnSave_Click">Save<img src="../img/save.png" /></asp:LinkButton>
                                    <asp:LinkButton ID="btnPrint" runat="server" OnClientClick="PrintElem('#div1')">Print</asp:LinkButton>

                                </td>
                            </tr>
                        </table>

                    </div>
                </div>


                <div id="div1" style="float: left">

                    <table id="tblPrint" runat="server">
                        <tr>
                            <td>Order No :
                    <asp:Label ID="lblorder_master_code" runat="server" /></td>
                            <td>Time:
                    <asp:Label ID="lblorder_master_houre" runat="server" /></td>
                            <td>Date :
                    <asp:Label ID="lblorder_master_datecreation" runat="server" /></td>
                            <td>Supplier :
                    <asp:Label ID="lbluser_fullname" runat="server" /></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="6">

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

                            </td>
                        </tr>
                        <tr>
                            <td>Tax :
                    <asp:Label ID="lblorder_master_tax" runat="server" /></td>
                            <td>Discount :
                    <asp:Label ID="lblorder_master_dicount" runat="server" /></td>
                            <td>Total Price :
                    <asp:Label ID="lblorder_master_total_price" runat="server" /></td>
                            <td>Casheer Name :
                    <asp:Label ID="lbluser_name" runat="server" /></td>
                            <td>|| Branch Name :
                    <asp:Label ID="lblbranch_name" runat="server" /></td>
                            <td>|| Store Name :
                            <asp:Label ID="lblstorename" runat="server" /></td>
                        </tr>
                    </table>

                </div>

            </ContentTemplate>

            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="grdSupplier" EventName="SelectedIndexChanged" />
            </Triggers>

        </asp:UpdatePanel>

        <%--serch Supplier --%>
        <div style="display:none" class="modal fade" id="confirmSupplier" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Search</h5>
                    </div>

                    <div class="modal-body">
                        <asp:TextBox ID="txtSearch" runat="server" Width="150px" AutoCompleteType="Disabled" OnTextChanged="txtSearch_TextChanged" CssClass="txt form-control" placeholder="Enter Search" />
                        <hr />
                        <asp:UpdatePanel ID="upModal" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel ID="pnlPopup" runat="server" CssClass="ModalPanel">
                                    <asp:GridView ID="grdSupplier" runat="server" AutoGenerateColumns="false"
                                        CssClass="dynamicTable table table-striped table-bordered table-condensed dataTable"
                                        DataKeyNames="user_id" PageSize="8" AllowPaging="true"
                                        OnPageIndexChanging="grdSupplier_PageIndexChanging" OnRowDataBound="grdSupplier_RowDataBound"
                                        OnSelectedIndexChanged="grdSupplier_SelectedIndexChanged" OnRowCommand="grdSupplier_RowCommand">
                                        <Columns>
                                            <asp:TemplateField HeaderText="م">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbluser_id" runat="server" Text='<%# Eval("user_id") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="اسـم المورد">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbluser_fullname" runat="server" Text='<%# Eval("user_fullname") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="رقم التليفـون">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbluser_phone" runat="server" Text='<%# Eval("user_phone") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="العنوان">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbluser_address" runat="server" Text='<%# Eval("user_address") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="اختار">
                                                <ItemTemplate>
                                                    <asp:LinkButton Text="اختر" ID="lnkSelect" runat="server" CommandName="Select" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="Black" />
                                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="Tomato" />
                                    </asp:GridView>
                                </asp:Panel>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="txtSearch" EventName="TextChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <asp:UpdateProgress AssociatedUpdatePanelID="UpdatePanel1" ID="UpdateProgress1" runat="server">
            <ProgressTemplate>
                <img src="../img/loading1.gif" />
            </ProgressTemplate>
        </asp:UpdateProgress>

        <div class="clearfix"></div>
    </div>

      <!--End Modal Popup add -->

</asp:Content>
