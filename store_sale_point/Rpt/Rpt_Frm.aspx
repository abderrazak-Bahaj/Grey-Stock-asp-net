<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Rpt_Frm.aspx.cs" Inherits="store_sale_point.Rpt.Rpt_Frm" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="http://code.jquery.com/jquery-1.10.2.js"></script>
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $(window).bind("beforeunload", function () {
                return confirm("You are about to close the window");
            });
        });
    </script>

    <script language="javascript" type="text/javascript">
        //<![CDATA[
        function HandleClose() {
            alert("Killing the session on the server!!");
            PageMethods.AbandonSession();
        }
        //]]>
    </script>

    <style type="text/css">
        html#html, body#body, form#form1, div#content {
            height: 100%;
        }
        .auto-style1 {
            text-align: right;
        }
    </style>

</head>
<body onunload="HandleClose()">
    <form id="form1" runat="server" style="width: 100%">
        <div>
            <%--                        <asp:ScriptManager ID="ScriptManager2" runat="server"  EnablePageMethods="true">
            </asp:ScriptManager>--%>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>

        </div>
        <div id="content" class="auto-style1">

            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="80%" ShowPrintButton="true" Height="600px">
            </rsweb:ReportViewer>

        </div>
    </form>
</body>
</html>
