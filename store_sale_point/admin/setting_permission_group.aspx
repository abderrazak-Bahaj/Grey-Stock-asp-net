<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="setting_permission_group.aspx.cs" Inherits="store_sale_point.admin.setting_permission_group" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="widget-head">
        <asp:Label ID="lblheadertxt" runat="server" Text=" مجموعات المستخدمين -   Permission Group" Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
    </div>
    <div style="margin-right: 50px; margin: 10px; border: 1px solid #e6e5e5; padding: 10px; width: 50%">
        <table>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>اسـم المجـموعة
                </td>
                <td>
                    <asp:TextBox ID="txtgroup_name" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="مطلوب" ControlToValidate="txtgroup_name" Display="Dynamic" ForeColor="#FF9900" SetFocusOnError="True" ValidationGroup="1"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td>ملاحظات</td>
                <td>
                    <asp:TextBox ID="txtgroup_notes" runat="server" TextMode="MultiLine"></asp:TextBox></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:LinkButton ID="btnInsert" CssClass="btn" runat="server" ValidationGroup="1" OnClick="btnInsert_Click">Save <img src="../img/add.png" /></asp:LinkButton>
                </td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </table>
    </div>
    <hr style="width: 70%" />
    <div style="margin-right: 50px; margin: 10px; border: 1px solid #e6e5e5; padding: 10px; width: 80%">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <asp:GridView ID="grd" DataKeyNames="group_id" runat="server" AllowPaging="true" PageSize="3"
                    AutoGenerateColumns="false" OnRowCancelingEdit="grd_RowCancelingEdit" OnRowEditing="grd_RowEditing"
                    OnPageIndexChanging="grd_PageIndexChanging"
                    CssClass="table-hover cdynamicTable table table-striped table-bordered table-condensed dataTable"
                    OnRowDeleting="grd_RowDeleting" OnRowUpdating="grd_RowUpdating">

                    <Columns>

                        <asp:TemplateField HeaderText="المسـلسل" ItemStyle-Width="30px">
                            <ItemTemplate>
                                <%# Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="اسم المجموعة">
                            <ItemTemplate>
                                <asp:Label ID="lblgroup_name" runat="server" Text='<%# Eval("group_name") %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txteditgroup_name" runat="server" Text='<%# Eval("group_name") %>' />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ملاحــظات">
                            <ItemTemplate>
                                <asp:Label ID="lblgroup_notes" runat="server" Text='<%# Eval("group_notes") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txteditgroup_notes" runat="server" Text='<%# Eval("group_notes") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="الـعمليـات" ItemStyle-Width="100px">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" CommandName="Edit" runat="server"><img src="../img/edit.png"  style="width:20px"/></asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" CommandName="Delete" runat="server" OnClientClick=" return confirm('هل انت متاكد من الحذف؟');"><img src="../img/Delete.png"  style="width:20px"/></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <table style="width: 80px">
                                    <tr>
                                        <td>
                                            <asp:LinkButton ID="btnUpdate" CommandName="Update" runat="server"><img src="../img/save.png" style="width:18px"/></asp:LinkButton>
                                            <asp:LinkButton ID="btnCancel" CommandName="Cancel" runat="server"><img src="../img/cancel.png" style="width:18px"/></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </EditItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
