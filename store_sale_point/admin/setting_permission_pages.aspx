<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="setting_permission_pages.aspx.cs" Inherits="store_sale_point.admin.setting_permission_pages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1
        {
            width: 70%;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="widget-head">
        <asp:Label ID="lblheadertxt" runat="server" Text="صفحات البرنامج  -  Program Pages" Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
    </div>

    <div style="margin-right: 50px; margin: 10px; border: 1px solid #e6e5e5; padding: 10px; width: 50%">

        <table class="auto-style1">
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label2" runat="server" Text="اسم الصفحة" />
                </td>
                <td>
                    <asp:TextBox ID="txtpage_name" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="مطلوب"
                        ControlToValidate="txtpage_name" Display="Dynamic" ForeColor="#FF9900" SetFocusOnError="True"
                        ValidationGroup="1"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td>عنوان الصفحة</td>
                <td>
                    <asp:TextBox ID="txtpage_url" runat="server"></asp:TextBox></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>

                    <asp:LinkButton ID="btnInsert" CssClass="btn" runat="server" OnClick="btnInsert_Click" ValidationGroup="1">
                       Save <img src="../img/add.png" />
                    </asp:LinkButton>

                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>

    </div>

    <hr style="width: 70%" />

    <div style="margin-right: 50px; margin: 10px; border: 1px solid #e6e5e5; padding: 10px; width: 80%">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <asp:GridView CssClass="table-hover cdynamicTable table table-striped table-bordered table-condensed dataTable" 
                    ID="grdpermission_page" AllowPaging="True" DataKeyNames="page_id"
                    runat="server" PageSize="10" AutoGenerateColumns="False" OnRowEditing="grdpermission_page_RowEditing"
                     OnRowCancelingEdit="grdpermission_page_RowCancelingEdit" OnRowDeleting="grdpermission_page_RowDeleting"
                     OnRowUpdating="grdpermission_page_RowUpdating" OnPageIndexChanging="grdpermission_page_PageIndexChanging" 
                    OnRowDataBound="grdpermission_page_RowDataBound">
                    <AlternatingRowStyle HorizontalAlign="Center" />
                    <Columns>
                        <asp:TemplateField HeaderText="الرقم">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="اسم الصفحة">
                            <ItemTemplate>
                                <asp:Label ID="lblpage_name" runat="server" Text='<%# Eval("page_name") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditpage_name" runat="server" Text='<%# Eval("page_name") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="عنوان الصفحة">
                            <ItemTemplate>
                                <asp:Label ID="lblpage_url" runat="server" Text='<%# Eval("page_url") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditpage_url" runat="server" Text='<%# Eval("page_url") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="العملــيات">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" CommandName="Edit" runat="server" Height="15px">
<img src="../img/edit.png" style="width:20px"/>
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnDelete" CommandName="Delete" runat="server" OnClientClick=" return confirm('هل انت متاكد من الحذف؟');" Height="15px">
<img src="../img/Delete.png" style="width:20px"/>
                                </asp:LinkButton>

                            </ItemTemplate>
                            <EditItemTemplate>
                                <table style="width: 80px">
                                    <td>
                                        <asp:LinkButton ID="btnUpdate" CommandName="Update" runat="server">
                        <img src="../img/save.png" style="width:18px"/>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnCancel" CommandName="Cancel" runat="server">
<img src="../img/cancel.png" style="width:18px"/>
                                        </asp:LinkButton>
                                    </td>
                                </table>

                            </EditItemTemplate>

                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>

            </ContentTemplate>
        </asp:UpdatePanel>


    </div>
</asp:Content>
