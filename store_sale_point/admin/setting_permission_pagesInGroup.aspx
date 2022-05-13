<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="setting_permission_pagesInGroup.aspx.cs" Inherits="store_sale_point.admin.setting_permission_pagesInGroup" %>

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
        <asp:Label ID="lblheadertxt" runat="server" Text="ربط صفحات البرنامج بالمجموعات  -  Pages And Groups in The Program" Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
    </div>

    <div style="margin-right: 50px; margin: 10px; border: 1px solid #e6e5e5; padding: 10px; width: 80%; font-family: tahoma">

        <table style="width: 700px">
            <tr>
                <td style="text-align: left;">اختر المجموعه</td>
                <td style="text-align: right;">
                    <div style="margin: 30px">

                        <asp:DropDownList ID="drpShowGroup" runat="server" AutoPostBack="true" OnSelectedIndexChanged="drpShowGroup_SelectedIndexChanged"></asp:DropDownList>
                    </div>
                </td>
            </tr>
            <tr>
                <td>صفحات البرنامج
                </td>
                <td>
                    <div style="margin-bottom: 30px; text-align: right">
                       اختيار الكل <asp:CheckBox Width="50px" ID="ChkAll" runat="server" AutoPostBack="true" OnCheckedChanged="ChkAll_CheckedChanged"/>
                    </div>
                    <div style="border: 1px solid black; padding: 10px 0px">
                        <asp:CheckBoxList ID="chkList" RepeatDirection="Vertical" RepeatColumns="3" runat="server" Width="80%">
                        </asp:CheckBoxList>

                    </div>

                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div style="margin-top: 20px">
                        <asp:LinkButton ID="btnSave" CssClass="btn btn-success" OnClick="btnSave_Click" runat="server" Text="حفظ التغييرات" />
                    </div>
                </td>
            </tr>
        </table>

    </div>


</asp:Content>
