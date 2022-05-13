<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="product_edit.aspx.cs" Inherits="store_sale_point.admin.product_edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgproduct_img.ClientID%>').prop('src', e.target.result)
                        .width(100)
                        .height(100);
                };
                reader.readAsDataURL(input.files[0]);
                }
            }
    </script>

    <script>
        function ClearImage() {
            $get('<%= imgproduct_img.ClientID %>').src = '/Upload/noimage.png';
        }
    </script>

    <script type="text/javascript">
        function confirm() {
            $('#confirmcategory').modal('close');
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="widget-head">
        <asp:Label ID="lblheadertxt" runat="server" Text=" تعديل المنتج - Edit Product " Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
    </div>

    <div style="margin-left: 50px; margin: 10px; padding: 10px; float: left; width: 40%; border: 1px solid #e6e5e5;">

        <table style="width: 100%">
            <tr>
                <td colspan="2" style="text-align: left;">
                    <asp:Image ID="imgproduct_img" runat="server" Height="122px" Width="116px" ImageUrl="~/Upload/noimage.png" />
                    <hr />
                </td>

            </tr>

            <tr>
                <td style="margin-top: 20px">صـورة المنتج</td>
                <td style="margin-top: 20px">
                    <asp:Label runat="server" ID="imglbl"></asp:Label>
                    <div id="Div1" class="fileupload fileupload-new" data-provides="fileupload" runat="server">
                        <input type="hidden" value="" name="">
                        <div class="input-append">
                            <div class="uneditable-input span3" style="width: 200px">
                                <i class="icon-file fileupload-exists" style="position: absolute; top: 4px; left: 10px"></i>
                                <span class="fileupload-preview" style="display: block; top: 4px; position: absolute;"></span>
                            </div>
                            <span class="btn btn-file">
                                <span class="fileupload-new">Select file</span>
                                <span class="fileupload-exists">Change</span>
                                <asp:FileUpload runat="server" ID="FileUpload1" onchange="ImagePreview(this);" />
                            </span>
                            <%--<a href="#" class="btn fileupload-exists" data-dismiss="fileupload" id="removePic" onclick="ClearImage();">Remove</a>--%>
                            <asp:LinkButton OnClientClick="ClearImage();" runat="server" class="btn fileupload-exists" data-dismiss="fileupload" ID="removePic">Remove</asp:LinkButton>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>وصف المنتح</td>
                <td>
                    <asp:TextBox ID="txtproduct_desc" runat="server" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
        </table>

    </div>

    <div style="margin-right: 50px; margin: 10px; border: 1px solid #e6e5e5; padding: 10px; width: 50%; float: right;">
        <table>
            <tr>
                <td></td>
                <td></td>
                <td rowspan="3"></td>
            </tr>
            <tr>
                <td>اسـم المـنتج
                </td>
                <td>
                    <asp:TextBox ID="txtproduct_name" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>كـود المـنتج
                </td>
                <td>
                    <asp:TextBox ID="txtproduct_code" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>باركـود المـنتج
                </td>
                <td>
                    <asp:TextBox ID="txtproduct_barcode" runat="server"></asp:TextBox>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>سـعر المـنتج
                </td>
                <td>
                    <asp:TextBox ID="txtproduct_price" runat="server"></asp:TextBox>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>الكـمية</td>
                <td>
                    <asp:TextBox ID="txtproduct_quantity" runat="server"></asp:TextBox>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>كمية الانذار</td>
                <td>
                    <asp:TextBox ID="txtproduct_quantity_alert" runat="server"></asp:TextBox>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>الوحدة</td>
                <td>
                    <asp:DropDownList ID="drpunit_id" runat="server"></asp:DropDownList>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>الفرع</td>
                <td>
                    <asp:DropDownList ID="drpbranch" AutoPostBack="true" runat="server" OnSelectedIndexChanged="drpbranch_SelectedIndexChanged"></asp:DropDownList>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>المستودع</td>
                <td>
                    <asp:DropDownList ID="drpstore_id" runat="server"></asp:DropDownList>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>القسم</td>
                <td>
                    <%--<asp:DropDownList ID="drpcategory_id" runat="server"></asp:DropDownList>--%>



                    <!-- Modal Search -->
                    <%--                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>--%>
                    <asp:UpdatePanel runat="server" ID="updatepanel2" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="input-append">





                                <asp:TextBox runat="server" class="span6" ID="drpcategoryname" type="text" placeholder="CatName .." Width="200px" ReadOnly="true" />
                                <asp:TextBox runat="server" class="span6" ID="drpcategoryid" type="text" placeholder="CatID .." Width="100px" />


                                <%--<asp:LinkButton CssClass="btn" ID="btnShowPopup" runat="server">
                            <i class="icon-search"></i>
                        </asp:LinkButton>--%>


                                <button class="btn" type="button" data-toggle="modal" data-target="#confirmcategory" data-whatever="@mdo">

                                    <i class="icon-search"></i>

                                </button>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="grdcategory" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>


                    <%--<div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Search</h5>
                                </div>
                                <div class="modal-body">

                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="button" class="btn btn-primary">Ok</button>
                                </div>
                            </div>
                        </div>--%>



                    <%--<div id="dialog" style="display: none">
                        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                        <hr />
                        <asp:UpdatePanel ID="upModal" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel ID="pnlPopup" runat="server" CssClass="ModalPanel">
                                    <asp:GridView ID="grdcategory" runat="server" AutoGenerateColumns="false"
                                        CssClass="dynamicTable table table-striped table-bordered table-condensed dataTable"
                                        PageSize="4" AllowPaging="true" OnPageIndexChanging="grdcategory_PageIndexChanging">
                                        <Columns>
                                            <asp:TemplateField HeaderText="رقم القسم">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcategory_id" runat="server" Text='<%# Eval("category_id") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="اسـم القسم">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcategory_name" runat="server" Text='<%# Eval("category_name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ملاحـظات">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcategory_notes" runat="server" Text='<%# Eval("category_notes") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>--%>


                    <div class="modal fade" id="confirmcategory" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="false" data-backdrop="static" data-keyboard="false">
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

                                                <asp:GridView ID="grdcategory" runat="server" AutoGenerateColumns="false"
                                                    CssClass="dynamicTable table table-striped table-bordered table-condensed dataTable"
                                                    DataKeyNames="category_id" PageSize="4" AllowPaging="true"
                                                    OnPageIndexChanging="grdcategory_PageIndexChanging"
                                                    OnRowDataBound="grdcategory_RowDataBound" OnSelectedIndexChanged="grdcategory_SelectedIndexChanged">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="م">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex+1 %>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="رقم القسم">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblcategory_id" runat="server" Text='<%# Eval("category_id") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="اسـم القسم">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblcategory_name" runat="server" Text='<%# Eval("category_name") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ملاحـظات">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblcategory_notes" runat="server" Text='<%# Eval("category_notes") %>'></asp:Label>
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
                                    <button type="button" class="btn btn-primary">Ok</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:LinkButton ID="btnNew" runat="server" OnClick="btnNew_Click"><img src="../img/cancel.png" /></asp:LinkButton>&nbsp &nbsp
                    <asp:LinkButton ID="btnSave" runat="server" OnClick="btnSave_Click"><img src="../img/save.png" /></asp:LinkButton>
                    <div style="float:left">
                        <asp:LinkButton ID="btnDel" runat="server" OnClick="btnDel_Click" OnClientClick="return confirm('هل انت متاكد من الحذف؟');"><img src="../img/Delete.png" /></asp:LinkButton>
                    </div>
                </td>
                <td></td>
            </tr>
        </table>
    </div>

    <div class="clearfix"></div>

</asp:Content>
