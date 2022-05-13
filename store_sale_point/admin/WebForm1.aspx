<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="store_sale_point.admin.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

    <script>
        $(function () {
            $("#txtsdate").datepicker({
                defaultDate: "+1w",
                changeMonth: true,
                onClose: function (selectedDate) {
                    $("#txtsdate").datepicker("option", "minDate", selectedDate);
                }
            });

            $("#txtedate").datepicker({
                defaultDate: "+1w",
                changeMonth: true,
                onClose: function (selectedDate) {
                    $("#txtedate").datepicker("option", "maxDate", selectedDate);
                }

            });
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                Start Date:<asp:TextBox ID="txtsdate" runat="server"></asp:TextBox>
                End Date:<asp:TextBox ID="txtedate" runat="server"></asp:TextBox>

            </div>
        </div>
    </form>
</body>
</html>
