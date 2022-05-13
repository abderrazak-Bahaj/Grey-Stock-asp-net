<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="setting_permission_UserInGroup.aspx.cs" Inherits="store_sale_point.admin.setting_permission_UserInGroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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


    <%--    <script>
        $(window).on('beforeunload', function () {
            $('ShowAdd').hide();
        });
        $(window).on('beforeunload', function () {
            $('ShowEdit').hide();
        });
    </script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="widget-head">
        <asp:Label ID="lblheadertxt" runat="server" Text=" المستخدمين - Users " Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
    </div>
    <div style="margin-top: 30px">
        <table>
            <tr>
                <td>اسم المستخدم</td>
                <td>
                    <asp:DropDownList ID="drpuser_id" runat="server"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>المجموعة</td>
                <td>
                    <asp:DropDownList ID="drpgroup_id" runat="server"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div style="margin-top: 20px;">
                        <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-success" OnClick="btnSave_Click">حفظ التغييرات</asp:LinkButton>

                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div style="width: 70%; margin-top: 20px;">
        <div style="float: left">
            <asp:TextBox ID="txtSearch" runat="server" Width="200px" OnTextChanged="txtSearch_TextChanged" placeholder="أدخل كلمات للبحث" AutoCompleteType="Disabled"></asp:TextBox>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="clearfix"></div>
                <div>
                    <asp:GridView ID="grdUsers" AutoGenerateColumns="false" AllowPaging="true" PageSize="15"
                        DataKeyNames="user_id" runat="server"
                        CssClass="dynamicTable table table-striped table-bordered table-condensed dataTable table-hover"
                        OnPageIndexChanging="grdUsers_PageIndexChanging">
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
                            <asp:TemplateField HeaderText="اسم المستخدم بالكامل">
                                <ItemTemplate>
                                    <asp:Label ID="lbluser_fullname" runat="server" Text='<%# Eval("user_fullname") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="اسم المستخدم للدخول">
                                <ItemTemplate>
                                    <asp:Label ID="lbluser_name" runat="server" Text='<%# Eval("user_name") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText=" كود المستخدم">
                                <ItemTemplate>
                                    <asp:Label ID="lbluser_code" runat="server" Text='<%# Eval("user_code") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="المجموعة">
                                <ItemTemplate>
                                    <asp:Label ID="lblgroup_id" runat="server" Text='<%# Eval("group_name") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
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
