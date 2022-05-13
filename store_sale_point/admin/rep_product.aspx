<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="rep_product.aspx.cs" Inherits="store_sale_point.admin.rep_product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .displayprint {
            display: none !important;
            width: 100%;
            height: 377px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="widget-head">
        <asp:Label ID="lblheadertxt" runat="server" Text=" تقرير المنتجات  - Product Report " Font-Size="Large" Font-Bold="true" ForeColor="SkyBlue"></asp:Label>
    </div>
    <br />
    <div style="font-family: tahoma">
        <table>
            <tr>
                <td>الفرع</td>
                <td>
                    <asp:DropDownList ID="drpBranch_id" runat="server" AutoPostBack="true" OnSelectedIndexChanged="drpBranch_id_SelectedIndexChanged"></asp:DropDownList></td>
                <td></td>
            </tr>
            <tr>
                <td>المخزن</td>
                <td>
                    <asp:DropDownList ID="drpStore_id" runat="server"></asp:DropDownList></td>
                <td></td>
            </tr>
            <tr>
                <td>كود المنتج</td>
                <td>
                    <asp:TextBox ID="txtCode_Product" runat="server"></asp:TextBox></td>
                <td></td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:Button ID="btnSearch" CssClass="btn btn-default" runat="server" Text="بحـث" OnClick="btnSearch_Click" /></td>
            </tr>
        </table>
    </div>
    <hr />
    <br />
    <div id="divPrint" runat="server">
        <div id="div1">

            <div class="row">
                <div class="col-sm-6">
                    <asp:Image CssClass=" img-responsive displayprint" Width="100px" Height="50px" ImageUrl="~/img/Acess_Denied.jpg" ID="Image1" runat="server" />
                </div>
                <div class="col-sm-6">
                    <asp:Label ID="lblCompanyName" CssClass="displayprint" runat="server" Style="font-weight: 700"></asp:Label>
                </div>
            </div>

            <hr />
            <table style="width: 100%">
                <tr style="background-color: #0000FF; color: #FFFFFF">
                    <td>مسلسل</td>
                    <td>الكود</td>
                    <td>الاسـم</td>
                    <td>الصورة</td>
                    <td>السعر</td>
                    <td>الكمية</td>
                    <td>الكمية الان</td>
                    <td>الفرع</td>
                    <td>المخزن</td>
                    <td>الوحدة</td>
                    <td>الفئه</td>

                </tr>
                <tbody runat="server" id="trBody">
                </tbody>
                <tfoot>
                    <tr>
                        <td>
                            <asp:Label ID="lbltxt" runat="server"></asp:Label></td>
                        <td colspan="10" style="text-align: right">
                            <asp:Label ID="lblCount" runat="server"></asp:Label></td>
                    </tr>
                </tfoot>
            </table>
            <div>
                <asp:Label ID="lblDateNow" runat="server" CssClass="displayprint" Style="font-weight: 700"></asp:Label>
            </div>
        </div>


        <%--                    <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="PrintElem('#div1')">طبـاعة</asp:LinkButton></td>--%>
        <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="PrintElem('#div1')">طبـاعة</asp:LinkButton>

    </div>
    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" Visible="false">طبـاعة</asp:LinkButton>


    <script type="text/javascript">
    function PrintElem(elem) {
                                     Popup($(elem).html());
                                 }

                                 function Popup(data) {
                                     var mywindow = window.open('', '_blank', 'width=580,height=480,location=no');
                                     mywindow.document.write('<html><head><title>طباعة</title>');
                                     /*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
                                     mywindow.document.write('</head><body dir="rtl">');
                                     mywindow.document.write(data);
                                     mywindow.document.write('</body></html>');

                                     mywindow.document.close(); // necessary for IE >= 10
                                     mywindow.focus(); // necessary for IE >= 10

                                     mywindow.print();
                                     mywindow.close();

                                     return true;
                                 }
    </script>



    <%--     <script type="text/javascript">
        function PrintDivAqar() {
            var divToPrint = document.getElementsByClassName('div1')[0];
            var popupWin = window.open('', '_blank', 'width=580,height=480,location=no');
            popupWin.document.open();
            popupWin.document.write('<html><head><link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"><link rel="stylesheet" href="../bootstrap/font-awesome/css/font-awesome.min.css" /><style>   @font-face {font-family: "Hacen"; src: url("../assets/fonts/HACEN_LINER_PRINT-OUT.ttf") format("truetype");}.fa{display:none;}.hiddenprint{display:none;} .print{display:none;} body{background-color:#fff !important;direction:rtl !important;line-height:0.2px !important }   @media print {.print { display: none;}}</style></head><body onload="window.print()">' + divToPrint.innerHTML + '</body></html>');
            popupWin.document.close();
        }

     </script>--%>
</asp:Content>
