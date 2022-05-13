<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="box.aspx.cs" Inherits="store_sale_point.admin.box" %>

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
        <asp:Label ID="lblheadertxt" runat="server" Text=" الصندوق  - Box " Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
    </div>
    <div style="width: 100%; margin-top: 20px;">


        <div style="float: left">
            <asp:TextBox ID="txtSearch" runat="server" Width="200px" OnTextChanged="txtSearch_TextChanged" placeholder="أدخل كلمات للبحث" AutoCompleteType="Disabled"></asp:TextBox>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div style="float: right">
                    <asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-default" OnClick="btnNew_Click">جديد</asp:LinkButton>
                </div>
                <div class="clearfix"></div>
                <div>
                    <asp:GridView ID="grdBox" AutoGenerateColumns="false" AllowPaging="true" PageSize="15"
                        DataKeyNames="box_id" runat="server"
                        CssClass="dynamicTable table table-striped table-bordered table-condensed dataTable table-hover"
                        OnPageIndexChanging="grdSupplier_PageIndexChanging" OnRowDeleting="grdSupplier_RowDeleting"
                        ShowFooter="true">
                        <Columns>
                            <asp:TemplateField HeaderText="مسلسل">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblbox_id" runat="server" Text='<%# Eval("box_id") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="الفرع">
                                <ItemTemplate>
                                    <asp:Label ID="lblbranch_i" runat="server" Text='<%# Eval("branch_id") %>' Visible="false" />
                                    <asp:Label ID="lblbranch_id" runat="server" Text='<%# Eval("branch_name") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="نوع الصندوق">
                                <ItemTemplate>
                                    <asp:Label ID="lblbox_kind_i" runat="server" Text='<%# Eval("box_kind_id") %>' Visible="false" />
                                    <asp:Label ID="lblbox_kind_id" runat="server" Text='<%# Eval("box_kind_name") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="نوع الحساب">
                                <ItemTemplate>
                                    <asp:Label ID="lblbox_account_i" runat="server" Text='<%# Eval("box_account_id") %>' Visible="false" />
                                    <asp:Label ID="lblbox_account_id" runat="server" Text='<%# Eval("box_account_name") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="التاريخ">
                                <ItemTemplate>
                                    <asp:Label ID="lblbox_datecreation" runat="server" Text='<%# Eval("box_datecreation") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="القيمة">
                                <ItemTemplate>
                                    <asp:Label ID="lblbox_value" runat="server" Text='<%# Eval("box_value") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="رقم الشيك">
                                <ItemTemplate>
                                    <asp:Label ID="lblbox_cheknumber" runat="server" Text='<%# Eval("box_cheknumber") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="مكان الصرف">
                                <ItemTemplate>
                                    <asp:Label ID="lblbox_chekplace" runat="server" Text='<%# Eval("box_chekplace") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText=" ملاحظات">
                                <ItemTemplate>
                                    <asp:Label ID="lblbox_notes" runat="server" Text='<%# Eval("box_notes") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="ملف">
                                <ItemTemplate>
                                    <asp:Label ID="lblbox_file" runat="server" Text='<%# Eval("box_file") %>' />
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
                <div style="float:left">
                    <table>
                        <tr>
                            <td style="width:50px"></td>
                            <td style="width:50px"></td>
                        </tr>
                        <tbody runat="server" id="trBody">
                        </tbody>
                    </table>
                </div>
                
                <div class="clearfix"></div>

                <!--Start Modal Popup Edit -->
                <div class="modal fade bd-example-modal-lg" id="ShowEdit" tabindex="-1" role="dialog" style="display: none"
                    aria-labelledby="myLargeModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="H1">تعديل على بيانات الحساب</h5>
                            </div>

                            <div class="modal-body body-mod text-center">
                                <asp:HiddenField ID="hiddenId" runat="server" />
                                <table>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">الفرع</td>
                                        <td colspan="2">
                                            <%--<asp:TextBox ID="txtadduser_fullname" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox>--%>
                                            <asp:DropDownList ID="drpEditbranch_id" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma"></asp:DropDownList>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">نوع الصندوق</td>
                                        <td>
                                            <%--<asp:TextBox ID="txtadduser_phone" runat="server" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox></td>--%>
                                            <asp:DropDownList ID="drpEditbox_kind_id" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma"></asp:DropDownList>

                                            <td></td>
                                            <td></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">نوع الحساب</td>
                                        <td>
                                            <%--<asp:TextBox ID="txtadduser_phone" runat="server" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox></td>--%>
                                            <asp:DropDownList ID="drpEditbox_account_id" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma"></asp:DropDownList>

                                            <td></td>
                                            <td></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">القيمة</td>
                                        <td>
                                            <asp:TextBox ID="txtEditbox_value" runat="server" Width="200px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">رقم الشيك</td>
                                        <td>
                                            <asp:TextBox ID="txtEditbox_cheknumber" runat="server" Width="200px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">مكان الصرف</td>
                                        <td>
                                            <asp:TextBox ID="txtEditbox_chekplace" runat="server" Width="200px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">ملاحظات </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtEditbox_notes" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">رفع ملف </td>
                                        <td colspan="2">
                                            <%--<asp:TextBox ID="TextBox5" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox>--%>
                                            <asp:FileUpload ID="EditFileUpload" CssClass="pull-right" Font-Names="Tahoma" Width="300px" runat="server" />
                                        </td>
                                    </tr>
                                </table>
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
                <div class="modal fade bd-example-modal-lg" id="ShowAdd" tabindex="-1" role="dialog" style="display: none"
                    aria-labelledby="myLargeModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="H2">عملية جديدة</h5>
                            </div>

                            <div class="modal-body body-mod text-center">
                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                <table>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">الفرع</td>
                                        <td colspan="2">
                                            <%--<asp:TextBox ID="txtadduser_fullname" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox>--%>
                                            <asp:DropDownList ID="drpbranch_id" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma"></asp:DropDownList>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">نوع الصندوق</td>
                                        <td>
                                            <%--<asp:TextBox ID="txtadduser_phone" runat="server" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox></td>--%>
                                            <asp:DropDownList ID="drpbox_kind_id" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma"></asp:DropDownList>

                                            <td></td>
                                            <td></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">نوع الحساب</td>
                                        <td>
                                            <%--<asp:TextBox ID="txtadduser_phone" runat="server" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox></td>--%>
                                            <asp:DropDownList ID="drpbox_account_id" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma"></asp:DropDownList>

                                            <td></td>
                                            <td></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">القيمة</td>
                                        <td>
                                            <asp:TextBox ID="txtbox_value" runat="server" Width="200px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">رقم الشيك</td>
                                        <td>
                                            <asp:TextBox ID="txtbox_cheknumber" runat="server" Width="200px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">مكان الصرف</td>
                                        <td>
                                            <asp:TextBox ID="txtbox_chekplace" runat="server" Width="200px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">ملاحظات </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtbox_notes" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="pull-left" style="font-family: Tahoma">رفع ملف </td>
                                        <td colspan="2">
                                            <%--<asp:TextBox ID="TextBox5" runat="server" Width="300px" CssClass="pull-right" Font-Names="Tahoma" AutoCompleteType="Disabled"></asp:TextBox>--%>
                                            <asp:FileUpload ID="FileUpload1" CssClass="pull-right" Font-Names="Tahoma" Width="300px" runat="server" />
                                        </td>
                                    </tr>
                                </table>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <asp:LinkButton ID="btnAdd" runat="server" class="btn btn-success" OnClick="btnAdd_Click">Save</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--End Modal Popup add -->

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
