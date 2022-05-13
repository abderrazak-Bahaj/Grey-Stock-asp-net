<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="POS.aspx.cs" Inherits="store_sale_point.admin.POS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%--    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>--%>

    <style>
        .modal-backdrop
        {
            z-index: 1040 !important;
        }

        .modal-dialog
        {
            margin: 2px auto;
            z-index: 1100 !important;
        }


        .lnk
        {
            background-color: white;
            color: black;
            padding: 5px;
            text-decoration: none;
            border: 1px solid black;
            margin: 5px;
            border-radius: 5px;
            text-align: center;
            line-height: 25px;
            font-family: Tahoma;
            overflow: hidden;
        }

            .lnk:hover
            {
                background-color: black;
                color: white;
                border-radius: 0px;
            }

        .txtquantity
        {
            margin: 7px;
        }
    </style>


    <%--        <script type="text/javascript">
        function confirm() {
            $('#confirmCustomers').modal('close');
        }
    </script>--%>


    <script>
        $(document).ready(function () {
            $('#confirmCustomers').modal('hide');
        });
    </script>

    <%--        <script type="text/javascript">
        function confirm() {
            $('#add_Customer').modal('close');
        }
    </script>--%>


    <script>
        $(document).ready(function () {
            $('#add_Customer').modal('hide');
        });
    </script>

    <script>
        $("#confirmCustomers").css("display", "none");
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


    <script src="http://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="widget-head" style="margin-bottom: 20px;">
        <asp:Label ID="lblheadertxt" runat="server" Text=" فاتورة مبيعات -   Sales Bill" Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
    </div>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>

            <div style="float: right; width: 40%;">

                <div>
                    <asp:LinkButton ID="btnNewOrder" runat="server" OnClick="btnNewOrder_Click">طلب جديد</asp:LinkButton>
                </div>
                <asp:Panel ID="pnlCat" runat="server">
                    <asp:DataList RepeatDirection="Vertical" RepeatColumns="4" DataKeyField="category_id" ID="dtCategory" runat="server" OnItemCommand="dtCategory_ItemCommand">
                        <ItemTemplate>
                            <asp:LinkButton Width="85px" Height="30px" CssClass="lnk" runat="server" Font-Underline="false"> &nbsp; <%# Eval("category_name") %> &nbsp; </asp:LinkButton>
                            <asp:Label ID="lblCat" runat="server" Visible="false" Text='<%# Eval("category_id") %>'></asp:Label>
                        </ItemTemplate>

                    </asp:DataList>
                </asp:Panel>


                <hr />

                <div>
                    <asp:Panel ID="pnlProduct" runat="server">
                        <asp:DataList ID="dtProduct" DataKeyField="product_id" RepeatColumns="6" RepeatDirection="Horizontal" runat="server" OnItemCommand="dtProduct_ItemCommand">
                            <ItemTemplate>
                                <table>
                                    <tr>
                                        <td style="text-align: center; padding: 10px">
                                            <div style="padding: 10px; background-color: #efeff2">
                                                <asp:Label ID="lblProduct" runat="server" Visible="false" Text='<%# Eval("product_id") %>'></asp:Label>
                                                <img src='<%# "/Upload/Product/" + Eval("product_img") %>' width="80px" height="80px" class="img img-rounded" style="margin: 5px;" />
                                                <br />
                                                <hr />
                                                <asp:LinkButton Font-Underline="false" Font-Size="16px" Font-Bold="true" ID="LinkButton1" runat="server" Text='<%# Eval("product_name") %>' />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                    </asp:Panel>
                </div>
            </div>
            <div style="float: left; width: 48%;">

                <div style="text-align: left; margin-bottom: 20px; margin-left: 20px; font-weight: bold; color: blue">
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                </div>

                <div style="max-height: 230px; overflow: auto; overflow-x: hidden">
                   <%-- <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>--%>
                    <div>
                        <asp:GridView Width="95%" OnRowDataBound="grdcart_RowDataBound" DataKeyNames="product_id" ID="grdcart" runat="server" AutoGenerateColumns="False"
                            CssClass="table-hover cdynamicTable table table-striped table-bordered table-condensed dataTable" OnRowDeleting="grdcart_RowDeleting" ShowFooter="True">
                            <Columns>
                                <asp:TemplateField HeaderText="مسلسل">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex +1 %>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblproduct_id" runat="server" Text='<%# Eval("product_id") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="اسم المنتج">
                                    <ItemTemplate>
                                        <asp:Label ID="lblproduct_name" runat="server" Text='<%# Eval("product_name") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="الكمية">
                                    <ItemTemplate>

                                        <asp:TextBox ID="txtproduct_quantity" AutoPostBack="True" OnTextChanged="txtproduct_quantity_TextChanged" Width="20px" Height="17px" runat="server" Text='<%# Eval("product_quantity") %>' CssClass="txtquantity"></asp:TextBox>

                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Bottom" />

                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>سعر البيع</HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblproduct_price" runat="server" Text='<%# Eval("product_price") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Font-Bold="true" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="الاجمالى">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTotal" runat="server" Text='<%# Eval("total_price") %>'></asp:Label>
                                        <%--<asp:Label ID="lblTotal" runat="server" Text='<%# float.Parse( Eval("product_price").ToString()) * int.Parse(Eval("product_quantity").ToString()) %>'></asp:Label>--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="حذف">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDelete" CommandName="Delete" runat="server">
<img src="../img/Delete.png" />
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>

                </div>
                <div>
                    <table id="tblOrderMaster" runat="server">
                        <tr>
                            <td colspan="4" style="text-align: center">
                                <hr />
                            </td>
                        </tr>
                        <tr>
                            <td>اسم العميل</td>
                            <td colspan="4">
                                <div class="input-append">
                                    <asp:TextBox ID="txtuser_id" runat="server" Width="80px"></asp:TextBox>
                                    <asp:TextBox ID="txtCustomerName" runat="server" Width="230px"></asp:TextBox>

                                    <button style="margin-bottom: 10px" class="btn" type="button" data-toggle="modal" data-target="#confirmCustomers" data-whatever="@mdo">
                                        <i class="icon-search"></i>
                                    </button>

                                </div>

                                <button style="margin-bottom: 20px" class="btn" type="button" data-toggle="modal" data-target="#add_Customer" data-whatever="@mdo">
                                    <i class="icon-user"></i>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td>الفرع</td>
                            <td>
                                <asp:DropDownList ID="drpbranch_id" runat="server"></asp:DropDownList></td>
                            <td>المستودع</td>
                            <td>
                               <asp:DropDownList ID="drpstore_id" runat="server"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td>الخصـم</td>
                            <td>
                                <asp:TextBox ID="txtorder_master_dicount" runat="server" AutoPostBack="true" OnTextChanged="txtorder_master_dicount_TextChanged" Width="150px" ></asp:TextBox>
                                <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="true" OnCheckedChanged="CheckBox1_CheckedChanged"/>
                                بالنسبة
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td>السداد</td>
                            <td>
                                <asp:DropDownList ID="drppayment_id" runat="server"></asp:DropDownList></td>

                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td>الضريبه</td>
                            <td>
                                <asp:TextBox ID="txtorder_master_tax" runat="server" OnTextChanged="txtorder_master_tax_TextChanged" AutoPostBack="true"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td>الاجمالى</td>
                            <td>
                                <asp:TextBox ID="txttotalPrice" runat="server" OnTextChanged="txttotalPrice_TextChanged"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="4" style="text-align: center">
                                <hr />
                                <asp:LinkButton ID="btnSave" runat="server" OnClick="btnSave_Click">Save<img src="../img/save.png" /></asp:LinkButton>
                                <asp:LinkButton ID="btnPrint" runat="server" OnClientClick="PrintElem('#div1')" OnClick="btnPrint_Click">Print</asp:LinkButton>

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
                        <td>Customer :
                    <asp:Label ID="lbluser_fullname" runat="server" /></td>
                    </tr>
                    <tr>
                        <td colspan="4">

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
                    <asp:Label ID="lbluser_name" runat="server" />
                            || Branch Name :
                    <asp:Label ID="lblbranch_name" runat="server" /></td>
                    </tr>
                </table>

            </div>
        </ContentTemplate>

        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="grdCustomer" EventName="SelectedIndexChanged" />
        </Triggers>

    </asp:UpdatePanel>

    <%--serch customer --%>

    <div style="display:none" class="modal fade" id="confirmCustomers" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Search</h5>
                </div>

                <div class="modal-body">

                    <asp:TextBox ID="txtSearch" runat="server" Width="150px" AutoCompleteType="Disabled" OnTextChanged="txtSearch_TextChanged" CssClass="txt form-control" placeholder="Enter Search" />

                    <%--<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>--%>

                    <hr />
                    <asp:UpdatePanel ID="upModal" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:Panel ID="pnlPopup" runat="server" CssClass="ModalPanel">

                                <asp:GridView ID="grdCustomer" runat="server" AutoGenerateColumns="false"
                                    CssClass="dynamicTable table table-striped table-bordered table-condensed dataTable"
                                    DataKeyNames="user_id" PageSize="8" AllowPaging="true"
                                    OnPageIndexChanging="grdCustomer_PageIndexChanging" OnPageIndexChanged="grdCustomer_PageIndexChanged"
                                    OnRowDataBound="grdCustomer_RowDataBound" OnSelectedIndexChanged="grdCustomer_SelectedIndexChanged"
                                    OnRowCommand="grdCustomer_RowCommand">
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
                                        <asp:TemplateField HeaderText="اسـم العميل">
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


    <%-- add new customer --%>

    <div style="display:none" class="modal fade" id="add_Customer" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="H1">Search</h5>
                </div>
                <div class="modal-body">
                    <table>
                        <tr>
                            <td>اسم العميل</td>
                            <td>
                                <asp:TextBox ID="txtadduser_fullname" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>رقم التليفون</td>
                            <td>
                                <asp:TextBox ID="txtadduser_phone" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>رقم التليفون</td>
                            <td>
                                <asp:TextBox ID="txtadduser_email" runat="server"></asp:TextBox></td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <asp:LinkButton runat="server" ID="btnAdd" class="btn btn-primary" OnClick="btnAdd_Click">Save</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <!--End Modal Popup add -->

    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
        <ProgressTemplate>
            <img src="../img/loading1.gif" />
        </ProgressTemplate>
    </asp:UpdateProgress>



    <div class="clearfix"></div>




</asp:Content>
