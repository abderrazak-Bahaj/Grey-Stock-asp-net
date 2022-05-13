<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="product_historyPrice.aspx.cs" Inherits="store_sale_point.admin.product_historyPrice" %>

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
            $('#showNotes').modal('close');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="widget-head">
        <asp:Label ID="lblheadertxt" runat="server" Text=" أرشيف أسعار المنتجات - Product Price History" Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
    </div>
    <div>
        <div style="margin: 30px 0px -5px 0px;">
            <asp:TextBox ID="txtSearch" OnTextChanged="txtSearch_TextChanged" runat="server" Width="200px" placeholder="أدخل كلمات للبحث" AutoCompleteType="Disabled"></asp:TextBox>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div>
                    <asp:GridView ID="grdrecentPrice" runat="server" AutoGenerateColumns="false" DataKeyNames="recentPrice_id"
                        CssClass="dynamicTable table table-striped table-bordered table-condensed dataTable table-hover"
                        OnDataBound="grdrecentPrice_DataBound" OnRowDeleting="grdrecentPrice_RowDeleting" AllowPaging="true" PageSize="4"
                        OnPageIndexChanging="grdrecentPrice_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField HeaderText="مسلسل">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText=" الرقم">
                                <ItemTemplate>
                                    <asp:Label ID="lblrecentPrice_id" runat="server" Text='<%# Eval("recentPrice_id") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="كـود المنتج">
                                <ItemTemplate>
                                    <asp:Label ID="lblrecentPrice_ProductCode" runat="server" Text='<%# Eval("recentPrice_ProductCode") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="إسـم المنتج">
                                <ItemTemplate>
                                    <asp:Label ID="lblproduct_name" runat="server" Text='<%# Eval("product_name") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="السـعر القديم">
                                <ItemTemplate>
                                    <asp:Label ID="lblrecentPrice_productPriceOld" runat="server" Text='<%# Eval("recentPrice_productPriceOld") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="السـعر الجديد">
                                <ItemTemplate>
                                    <asp:Label ID="lblrecentPrice_productPriceNew" runat="server" Text='<%# Eval("recentPrice_productPriceNew") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="التعديل تم بتاريخ">
                                <ItemTemplate>
                                    <asp:Label ID="lblrecentPrice_productDateEdit" runat="server" Text='<%# Eval("recentPrice_productDateEdit") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ملاحظـات">
                                <ItemTemplate>
                                    <asp:Label ID="lblrecentPrice_productNotes" runat="server" Text='<%# Eval("recentPrice_productNotes") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="العمليات">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" OnClick="btnEdit_Click"> تسجيل ملاحظة </asp:LinkButton>
                                    &nbsp | &nbsp
                                    <asp:LinkButton ID="btnDelete" CommandName="Delete" runat="server" OnClientClick=" return confirm('هل انت متاكد من الحذف؟');"> حذف </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>
                </div>

                <!--Start Modal Popup Edit -->
                <div class="modal fade bd-example-modal-lg" id="showNotes" tabindex="-1" role="dialog"
                    aria-labelledby="myLargeModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="H1">تسجيل ملاحظه على المنتج</h5>
                            </div>

                            <div class="modal-body body-mod text-center">
                                <asp:HiddenField ID="hiddenId" runat="server" />
                                ملاحظـة
                                <asp:TextBox ID="txtrecentPrice_productNotes" runat="server" Text='<%# Eval("recentPrice_productNotes") %>' AutoCompleteType="Disabled"></asp:TextBox>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <asp:LinkButton ID="btnSave" runat="server" OnClick="btnSave_Click" class="btn btn-success">Save</asp:LinkButton>
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





    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

</asp:Content>
