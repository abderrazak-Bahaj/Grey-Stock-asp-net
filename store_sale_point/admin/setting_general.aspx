<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="setting_general.aspx.cs" Inherits="store_sale_point.admin.setting_general" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="http://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=Image1.ClientID%>').prop('src', e.target.result)
                        .width(100)
                        .height(100);
                };
                reader.readAsDataURL(input.files[0]);
                }
            }

    </script>

    <style type="text/css">
        .auto-style1
        {
            height: 60px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="widget-head">
        <asp:Label ID="lblheadertxt" runat="server" Text=" الاعدادات العامة -   General Settins" Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
    </div>
    <div style="margin-right: 50px; margin: 10px; border: 1px solid #e6e5e5; padding: 10px; width: 50%">
        <table>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>العـنوان
                </td>
                <td>
                    <asp:TextBox ID="txtsetting_title" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="مطلوب" ControlToValidate="txtsetting_title" Display="Dynamic" ForeColor="#FF9900" SetFocusOnError="True" ValidationGroup="1"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td>التليـفون
                </td>
                <td>
                    <asp:TextBox ID="txtsetting_phone" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="مطلوب" ControlToValidate="txtsetting_phone" Display="Dynamic" ForeColor="#FF9900" SetFocusOnError="True" ValidationGroup="1"></asp:RequiredFieldValidator></td>
            </tr>

            <tr>
                <td>اسم المستخدم
                </td>
                <td>
                    <asp:DropDownList ID="drpUser" runat="server">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="مطلوب" InitialValue="0" SetFocusOnError="True" ValidationGroup="1" Display="Dynamic" ControlToValidate="drpUser" ForeColor="#FF9900"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td>ملاحظات</td>
                <td>
                    <asp:TextBox ID="txtsetting_notes" runat="server" TextMode="MultiLine"></asp:TextBox></td>
                <td>
                    <asp:Image ID="Image1" runat="server" Height="122px" Width="116px" />
                </td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>رفع صورة</td>
                <td>
                    <asp:FileUpload ID="FileUpload1" runat="server" CssClass="btn" onchange="ImagePreview(this);" /></td>
                <td style="text-align: center">
                    <asp:Button ID="Button1" runat="server" Text="ClearImg" CssClass="btn" OnClick="Button1_Click" Width="89px"/>
                </td>
            </tr>
            <tr>
                <td class="auto-style1"></td>
                <td class="auto-style1"></td>
                <td class="auto-style1"></td>
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
</asp:Content>
