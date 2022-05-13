<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="product_view.aspx.cs" Inherits="store_sale_point.admin.product_view" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        /*div.AspNet-GridView
        {
            border: 1px solid #828790;
            font-size: 0.8em;
            min-height: 1px;
            font-family: "Lucida Sans";
        }*/

        div.AspNet-GridView table
        {
            width: 100%;
            border-collapse: collapse;
        }

            /*div.AspNet-GridView table thead tr th
                {
                    padding: 3px 3px 2px 2px;

                    font-weight: normal;
                    border-bottom: 1px solid #d5d5d5;
                    border-right: 1px solid #e3e4e6;
                }*/

            /*div.AspNet-GridView table thead tr th.sortable
                    {
                        padding: 0px;
                    }*/

            /*div.AspNet-GridView table thead tr th.sortable:hover
                        {
                            border-top: none;
                            border-left: none;
                        }*/

            /*div.AspNet-GridView table thead tr th.sortable a
                        {
                            display: block;
                            padding: 3px 3px 2px 2px;
                            color: Black;
                            min-height: 1px;
                        }*/

            /*div.AspNet-GridView table thead tr th.sortable a:hover
                            {
                                text-decoration: none;
                            }*/

            /*div.AspNet-GridView table thead tr th.sorted
                    {
                        
                        background-color: #d8ecf6;
                        border: 1px solid #96d9f9;
                        border-top: none;
                        border-left: none;
                    }*/

            div.AspNet-GridView table tbody tr td
            {
                padding: 2px 6px 2px 4px;
                border: 1px solid #efefef;
            }

            div.AspNet-GridView table tbody tr:hover
            {
                background-color: #B7E7FB;
                cursor: pointer;
            }

            div.AspNet-GridView table thead tr th.action,
            div.AspNet-GridView table tbody tr td.action
            {
                border-left: none;
                border-right: none;
            }

            div.AspNet-GridView table tbody tr td.action
            {
                padding: 2px 2px 2px 2px;
                width: 40px;
                text-align: center;
            }

            div.AspNet-GridView table tbody tr.AspNet-GridView-Alternate td
            {
                background: #f2f9fc;
            }

        div.grid-row-count
        {
            color: #666666;
            padding: 2px 0px 2px 6px;
            font-size: 0.8em;
        }

        .GridHeader
        {
            /*font-weight: bold;*/
            background-color: #F1F1F1;
        }

        .GridFooter
        {
            background-color: #F1F1F1;
            float: left;
            display: table-footer-group;
            margin: 0px 5px;
            padding: 0px 5px;
        }



        GridHeader table
        {
            background: #F1F1F1;
        }

            GridHeader table:hover
            {
                background: #F1F1F1;
                cursor: default;
            }

        .PagerStyle table
        {
            text-align: center;
            margin: auto;
            overflow: hidden;
        }

            .PagerStyle table:hover
            {
                cursor: default;
                color: #333333;
                background-color: #fff;
                border: 0px #fff;
            }

            .PagerStyle table tr
            {
                text-align: center;
                margin: auto;
                float: left;
            }

            .PagerStyle table td
            {
                border: 0px;
                padding: 5px;
            }

        .PagerStyle td
        {
            /*border-top: #1d1d1d 3px solid;*/
            color: red;
        }

        .PagerStyle a
        {
            color: red;
            text-decoration: none;
            padding: 2px 10px 2px 10px;
            border-top: solid 1px #777777;
            border-right: solid 1px #333333;
            border-bottom: solid 1px #333333;
            border-left: solid 1px #777777;
        }

        .PagerStyle span
        {
            font-weight: bold;
            color: red;
            text-decoration: none;
            padding: 2px 10px 2px 10px;
        }



        /*.HeaderStyle, .PagerStyle
        {
            background-image: url(Images/HeaderGlassBlack.jpg);
            background-position: center;
            background-repeat: repeat-x;
            background-color: #1d1d1d;
        }*/

        .HeaderStyle th
        {
            /*padding: 5px;*/
            color: #333333;
            background-color: #F1F1F1;
        }

            .HeaderStyle th:hover
            {
                cursor: default;
            }

        .HeaderStyle a
        {
            text-decoration: none;
            color: #ffffff;
            display: block;
            text-align: left;
            font-weight: normal;
        }
    </style>


    <script type="text/javascript">
        function ClosePopup() {
            $('#showImg').modal('close');
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="widget-head">
        <asp:Label ID="lblheadertxt" runat="server" Text=" المنتجات - All Products " Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
    </div>

    <div style="margin-right: 50px; margin: 10px; padding: 10px; float: right; width: 40%; border: 1px solid #e6e5e5;">

        <table>
            <tr>
                <td>اسـم المنتج</td>
                <td>
                    <asp:TextBox ID="txtproduct_name" runat="server"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td>كود المنتج</td>
                <td>
                    <asp:TextBox ID="txtproduct_code" runat="server"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td>باركـود المنتج</td>
                <td>
                    <asp:TextBox ID="txtproduct_barcode" runat="server"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td>الفـرع</td>
                <td>
                    <asp:DropDownList ID="drpbranch_id" runat="server" AutoPostBack="true" OnSelectedIndexChanged="drpbranch_id_SelectedIndexChanged"></asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td>المخـزن</td>
                <td>
                    <asp:DropDownList ID="drpstore_id" runat="server"></asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td>القسـم</td>
                <td>
                    <asp:DropDownList ID="drpcategory_id" runat="server"></asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td></td>
                <td style="text-align: center">
                    <br />
                    <asp:LinkButton CssClass="btn" ID="btnSearch" runat="server" OnClick="btnSearch_Click">Search</asp:LinkButton>
                </td>
            </tr>

        </table>

    </div>
    <div>
        <hr style="width: 80%" />
    </div>


    <!--Start Modal Popup Edit -->
    <div class="modal fade bd-example-modal-lg" id="showImg" tabindex="-1" role="dialog"
        aria-labelledby="myLargeModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="H1">عرض الصورة</h5>

                </div>

                <div class="modal-body body-mod text-center">
                    <asp:Image ID="ImgProduct" runat="server" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!--End Modal Popup Edit -->



    <div style="margin-right: 50px; margin: 10px; margin-top: 0px; padding: 10px; float: right; width: 80%; text-align: right" class="AspNet-GridView">
        <div>
            <div style="float: right">
                <asp:LinkButton ID="btnNewProduct" runat="server" CssClass="btn btn-light" PostBackUrl="~/admin/product_add.aspx"> جديد &nbsp
<img src="../img/add.png" /> 
                </asp:LinkButton>
            </div>
            <div style="float: left">
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            </div>
        </div>

        <asp:GridView ID="grdProduct" runat="server" AutoGenerateColumns="false" DataKeyNames="product_id"
            CssClass="AspNet-GridView table-bordered cdynamicTable dataTable" OnRowDataBound="grdProduct_RowDataBound"
            PageSize="5" AllowPaging="true" OnPageIndexChanging="grdProduct_PageIndexChanging"
            OnRowDeleting="grdProduct_RowDeleting" GridLines="None">
            <Columns>
                <asp:TemplateField HeaderText="مسلسل">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="رقم المنتج">
                    <ItemTemplate>
                        <asp:Label ID="lblproduct_id" runat="server" Text='<%# Eval("product_id") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="اسم المنتج">
                    <ItemTemplate>
                        <asp:Label ID="lblproduct_name" runat="server" Text='<%# Eval("product_name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="كود المنتج">
                    <ItemTemplate>
                        <asp:Label ID="lblproduct_code" runat="server" Text='<%# Eval("product_code") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="سـعر المنتج">
                    <ItemTemplate>
                        <asp:Label ID="lblproduct_price" runat="server" Text='<%# Eval("product_price") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="الكـميه">
                    <ItemTemplate>
                        <asp:Label ID="lblproduct_quantity" runat="server" Text='<%# Eval("product_quantity") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="الوحـدة">
                    <ItemTemplate>
                        <asp:Label ID="lblunit_id" runat="server" Text='<%# Eval("unit_name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="الفرع">
                    <ItemTemplate>
                        <asp:Label ID="lblbranch_id" runat="server" Text='<%# Eval("branch_name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="المستودع">
                    <ItemTemplate>
                        <asp:Label ID="lblstore_id" runat="server" Text='<%# Eval("store_name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="القسـم">
                    <ItemTemplate>
                        <asp:Label ID="lblcategory_id" runat="server" Text='<%# Eval("category_name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="الصورة">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnShowImg" runat="server" OnClick="btnShowImg_Click">Image</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="العمليات">
                    <ItemTemplate>
                        <asp:HyperLink ID="btnEdit" NavigateUrl='<%# "product_edit.aspx?product_id=" + Eval("product_id") %>' runat="server">تعديل</asp:HyperLink>
                        || 
                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" OnClientClick="return confirm('هل انت متاكد من الحذف؟');">حـذف</asp:LinkButton>

                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
            <HeaderStyle CssClass="HeaderStyle" />
            <FooterStyle CssClass="GridFooter" />
            <PagerStyle CssClass="PagerStyle" VerticalAlign="Middle" HorizontalAlign="Center" />
            <EmptyDataTemplate>لايوجد منتجات بهذا البحـث</EmptyDataTemplate>
        </asp:GridView>

    </div>
    <div class="clearfix"></div>
</asp:Content>
