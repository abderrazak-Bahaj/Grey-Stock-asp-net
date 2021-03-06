<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="c_s_customer.aspx.cs" Inherits="store_sale_point.admin.c_s_customer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table-bordered tbody tr th
        {
            text-align: center;
            color: red;
            vertical-align: middle;
        }

        .table-bordered tbody tr, .table-bordered tbody tr td
        {
            text-align: right;
            vertical-align: middle;
        }

            .table-bordered tbody tr td:first-child, .table-bordered tbody tr td:last-child
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
    </style>

    <script type="text/javascript">
        function ClosePopup() {
            $('#ShowEdit').modal('close');
        }
    </script>

    <script type="text/javascript">
        function ClosePopup() {
            $('#ShowAdd').modal('close');
        }
    </script>

    <%--    <script type="text/javascript">
        function fn_Next(sender, args) {
            $find('ShowAdd').hide();
            $find('ShowEdit').hide();
        }

        function fn_Back(sender, args) {
            $find('ShowAdd').hide();
            $find('ShowEdit').hide();
        }

        function fn_Last(sender, args) {
            $find('ShowAdd').hide();
            $find('ShowEdit').hide();
        }

    </script>--%>
    <script>
        $(window).on('beforeunload', function () {
            $('ShowAdd').hide();
        });
        $(window).on('beforeunload', function () {
            $('ShowEdit').hide();
        });
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="widget-head">
        <asp:Label ID="lblheadertxt" runat="server" Text=" العملاء  - Customers " Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
    </div>
    <div style="width: 100%; margin-top: 20px;">


        <div style="float: left">
            <asp:TextBox ID="txtSearch" runat="server" Width="200px" OnTextChanged="txtSearch_TextChanged" placeholder="أدخل كلمات للبحث" AutoCompleteType="Disabled"></asp:TextBox>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div style="float: right">
                    <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-default" OnClick="btnNew_Click">مورد جديد</asp:LinkButton>
                </div>
                <div class="clearfix"></div>
                <div>
                    <asp:GridView ID="grdCustomer" AutoGenerateColumns="false" AllowPaging="true" PageSize="15" DataKeyNames="user_id" runat="server"
                        CssClass="dynamicTable table table-striped table-bordered table-condensed dataTable table-hover"
                        OnPageIndexChanging="grdSupplier_PageIndexChanging" OnRowDeleting="grdSupplier_RowDeleting">
                        <Columns>
                            <asp:TemplateField HeaderText="مسلسل">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lbluser_id" runat="server" Text='<%# Eval("user_id") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="اسـم المـورد">
                                <ItemTemplate>
                                    <asp:Label ID="lbluser_fullname" runat="server" Text='<%# Eval("user_fullname") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="رقـم التـليفون">
                                <ItemTemplate>
                                    <asp:Label ID="lbluser_phone" runat="server" Text='<%# Eval("user_phone") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="البـريد الالـكترونى">
                                <ItemTemplate>
                                    <asp:Label ID="lbluser_email" runat="server" Text='<%# Eval("user_email") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="العـنوان">
                                <ItemTemplate>
                                    <asp:Label ID="lbluser_address" runat="server" Text='<%# Eval("user_address") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="العمليات">
                                <ItemTemplate>
                                    <asp:LinkButton ID="BtnEdit" runat="server" OnClick="BtnEdit_Click">تعديل</asp:LinkButton>
                                    &nbsp | &nbsp
                            <asp:LinkButton ID="BtnDelete" runat="server" CommandName="Delete" OnClientClick=" return confirm('هل انت متاكد من الحذف؟');">حذف</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>
                </div>

                <!--Start Modal Popup Edit -->
                <div class="modal fade bd-example-modal-lg" id="ShowEdit" tabindex="-1" role="dialog"
                    aria-labelledby="myLargeModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="H1">تعديل على بيانات العميل</h5>
                            </div>

                            <div class="modal-body body-mod text-center">
                                <asp:HiddenField ID="hiddenId" runat="server" />
                                <table>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">اسم العميل</td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtEdituser_fullname" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">رقم التليفون</td>
                                        <td>
                                            <asp:TextBox ID="txtEdituser_phone" runat="server" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">البريد الالكترونى</td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtEdituser_email" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">العنوان</td>
                                        <td>
                                            <asp:TextBox ID="txtedituser_address" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox></td>
                                    </tr>
                                </table>
                                </>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <asp:LinkButton ID="btnSave" runat="server" class="btn btn-success" OnClick="btnSave_Click">Save</asp:LinkButton>
                    </div>
                            </div>
                        </div>
                    </div>
                    <!--End Modal Popup Edit -->

                </div>
                <!--End Modal Popup Edit -->

                <!--Start Modal Popup add -->
                <div class="modal fade bd-example-modal-lg" id="ShowAdd" tabindex="-1" role="dialog"
                    aria-labelledby="myLargeModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="H2">إضافة عميل جـديد</h5>
                            </div>

                            <div class="modal-body body-mod text-center">
                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                <table>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">اسم العميل</td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtadduser_fullname" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">رقم التليفون</td>
                                        <td>
                                            <asp:TextBox ID="txtadduser_phone" runat="server" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">البريد الالكترونى</td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtadduser_email" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">العنوان</td>
                                        <td>
                                            <asp:TextBox ID="txtadduser_address" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox></td>
                                    </tr>
                                </table>
                                </>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <asp:LinkButton ID="btnAdd" runat="server" class="btn btn-success" OnClick="btnAdd_Click">Save</asp:LinkButton>
                    </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--End Modal Popup Edit -->

            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="txtSearch" EventName="TextChanged" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <!--End Modal Popup add -->

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</asp:Content>
