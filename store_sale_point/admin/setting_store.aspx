<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="setting_store.aspx.cs" Inherits="store_sale_point.admin.setting_store" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="widget-head">
        <asp:Label ID="lblheadertxt" runat="server" Text="المستودعات  -   Stores" Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
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
                    <asp:Label ID="Label2" runat="server" Text="اسم المخزن" />
                </td>
                <td>
                    <asp:DropDownList ID="drpBranch" runat="server"></asp:DropDownList>
                    <br />
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="drpBranch" Display="Dynamic" ErrorMessage="اختر الفرع" InitialValue="-1" SetFocusOnError="True" ValidationGroup="1"></asp:RequiredFieldValidator>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="drpBranch" Display="Dynamic" ErrorMessage="اختر الفرع" InitialValue="0" SetFocusOnError="True" ValidationGroup="1"></asp:RequiredFieldValidator>--%>

                </td>

            </tr>
            <tr>
                <td>اسم المستودع</td>
                <td>
                    <asp:TextBox ID="txtstore_name" runat="server"></asp:TextBox></td>
                <td></td>

            </tr>
            <tr>
                <td>ملاحظات</td>
                <td>
                    <asp:TextBox ID="txtstore_notes" runat="server" TextMode="MultiLine"></asp:TextBox></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>

                    <asp:LinkButton ID="btnInsert" CssClass="btn" runat="server" ValidationGroup="1" OnClick="btnInsert_Click">
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
    <div style="margin-right: 50px; margin: 10px; border: 1px solid #e6e5e5; padding: 10px; width: 80%; direction: ltr;">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView DataKeyNames="store_id" ID="grdStore" CssClass="table-hover cdynamicTable table table-striped table-bordered table-condensed dataTable" runat="server" AutoGenerateColumns="false" OnPageIndexChanging="grdStore_PageIndexChanging" OnRowCancelingEdit="grdStore_RowCancelingEdit" OnRowDeleting="grdStore_RowDeleting" OnRowEditing="grdStore_RowEditing" OnRowUpdating="grdStore_RowUpdating" OnRowDataBound="grdStore_RowDataBound">
                    <Columns>

                        <asp:TemplateField HeaderText="الرقــم">
                            <ItemTemplate>
                                <%# Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="اسم المســتودع">
                            <ItemTemplate>
                                <asp:Label ID="lblstore_name" runat="server" Text='<%# Eval("store_name") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtstore_name" runat="server" Text='<%# Eval("store_name") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="اسم الفــرع">
                            <ItemTemplate>
                                <asp:Label ID="lblbranch_id" runat="server" Text='<%# Eval("branch_name") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="drpBranchEdit" runat="server"></asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ملاحظــات">
                            <ItemTemplate>
                                <asp:Label ID="lblstore_notes" runat="server" Text='<%# Eval("store_notes") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtstore_notes" runat="server" Text='<%# Eval("store_notes") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="العمليات">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" CommandName="Edit" runat="server"><img src="../img/edit.png" /></asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" CommandName="Delete" runat="server" OnClientClick=" return confirm('هل انت متاكد من الحذف؟');"><img src="../img/Delete.png" /></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:LinkButton ID="btnUpdate" CommandName="Update" runat="server"><img src="../img/save.png"  style="width:18px"/></asp:LinkButton>
                                            <asp:LinkButton ID="btnCancel" CommandName="Cancel" runat="server"><img src="../img/cancel.png"  style="width:18px"/></asp:LinkButton>
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
