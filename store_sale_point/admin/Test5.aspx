<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test5.aspx.cs" Inherits="store_sale_point.admin.Test5" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <%--Script for CheckBox Selection --%>
    <script type="text/javascript">
        function CheckBoxCheck(rb) {
            var gv = document.getElementById("<%=grdSubject.ClientID%>");
            var rbs = gv.getElementsByTagName("input");

            var row = rb.parentNode.parentNode;
            for (var i = 0; i < rbs.length; i++) {
                if (rbs[i].type == "checkbox") {
                    if (rbs[i].checked && rbs[i] != rb) {
                        rbs[i].checked = false;
                        break;
                    }
                }
            }
        }
    </script>
    <%-- Script of checkbox ends here --%>
    <script type="text/javascript">
        function pageLoad(sender, args) {
            if (!args.get_isPartialLoad()) {
                $addHandler(document, "keydown", onKeyDown);
            }
        }
        function onKeyDown(e) {
            if (e && e.keyCode == Sys.UI.Key.esc) {
                $find('mpeMessageBox').hide();
                $find('mpeDeleteSubject').hide();
            }
        }
    </script>
    <style>
        .form-horizontal .control-label {
            padding-top: 7px;
            margin-bottom: 0;
            text-align: left;
        }

        .left {
            padding-left: 0px;
        }

        .bothcenter {
            padding-left: 10px;
            padding-right: 0px;
        }

        .pnlback {
            background-color: silver;
        }

        .input-sm {
            border: 1px;
            border-style: solid;
        }

        body {
            font-family: Arial;
            font-size: 10pt;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div>

            <div class="ContentBack col-md-12 col-lg-12">
        <div class="panel panel-danger">
            <div class="panel-heading">
                <i class="fa fa-bell fa-fw"></i>
                <center>
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    <b>Subject Master</b></center>
            </div>
            <div class="panel-body">
                <div class="form-horizontal">
                    <div class="form-group">
                        <asp:Label ID="lblSubName" runat="server" Text="Subject Name" CssClass="control-label col-md-offset-2 col-lg-offset-2 col-md-2 col-lg-2 "></asp:Label>
                        <div class="col-md-6 col-lg-6">
                            <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control input-sm" Style="text-transform: uppercase"
                                MaxLength="30"></asp:TextBox>
                        </div>
                        <div class="col-md-2 col-lg-2">
                            <asp:RequiredFieldValidator ID="rfv1" runat="server" ErrorMessage="Please Enter Subject"
                                ControlToValidate="txtSubject" ForeColor="Red" CssClass="control-label" SetFocusOnError="True"
                                ToolTip="Enter"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblHqrsSubCode" runat="server" Text="HQRS Sub Code" CssClass="control-label col-md-offset-2 col-lg-offset-2 col-md-2 col-lg-2 "></asp:Label>
                        <div class="col-md-2 col-lg-2">
                            <asp:TextBox ID="txtHqrsSubCode" runat="server" CssClass="form-control input-sm "
                                MaxLength="4" Style="text-transform: uppercase"></asp:TextBox>
                        </div>
                        <asp:Label ID="lblHqrsDesc" runat="server" Text="HQRS Sub Description" CssClass="control-label col-lg-2"></asp:Label>
                        <div class="col-md-2 col-lg-2">
                            <asp:TextBox ID="txtHqrsSubDesc" runat="server" CssClass="form-control input-sm"
                                Style="text-transform: uppercase" MaxLength="30"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-1 col-lg-offset-1 col-md-1 col-lg-1">
                            <asp:Label ID="lblSubjectCode" runat="server" Text="" Visible="false"></asp:Label>
                        </div>
                        <div class=" col-md-2 col-lg-2">
                            <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-success btn-block"
                                OnClick="btnSave_Click" Text="Save">
                                           <span aria-hidden="true" class="glyphicon glyphicon-save"></span>&nbsp;&nbsp;SAVE
                            </asp:LinkButton>
                        </div>
                        <div class=" col-md-2 col-lg-2">
                            <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-warning btn-block"
                                OnClick="btnUpdate_Click" Text="Edit">
                                           <span aria-hidden="true" class="glyphicon glyphicon-edit"></span>&nbsp;&nbsp;UPDATE
                            </asp:LinkButton>
                        </div>
                        <div class=" col-md-2 col-lg-2">
                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn  btn-danger btn-block"
                                OnClick="btnDelete_Click" Text="Save">
                                           <span aria-hidden="true"  class="glyphicon glyphicon-trash"></span>&nbsp;&nbsp;DELETE
                            </asp:LinkButton>
                        </div>
                        <div class=" col-md-2 col-lg-2">
                            <asp:Button ID="btnClear" runat="server" Text="CLEAR" CssClass="btn btn-default btn-block"
                                OnClick="btnClear_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="well well-lg">
            <asp:UpdatePanel ID="upCrudGrid" runat="server">
                <ContentTemplate>
                    <div class="form-horizontal">
                        <div class="form-group">
                            <asp:Label ID="lblSearchCode" runat="server" Text="Search Code" CssClass="col-md-1 col-lg-1 control-label"></asp:Label>
                            <div class="col-md-1 col-lg-1">
                                <asp:TextBox ID="txtSerCode" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm"
                                    MaxLength="4" AutoPostBack="true" OnTextChanged="txtSerCode_TextChanged"></asp:TextBox>
                                <cc1:FilteredTextBoxExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtSerCode"
                                    FilterType="Numbers">
                                </cc1:FilteredTextBoxExtender>
                            </div>
                            <asp:Label ID="lblSearchName" runat="server" Text="Search Name" CssClass="col-md-1 col-lg-1 control-label "
                                Style="padding-right: 0px"></asp:Label>
                            <div class="col-md-2 col-lg-2">
                                <asp:TextBox ID="txtSerName" runat="server" MaxLength="30" CssClass="form-control input-sm"
                                    Style="text-transform: uppercase" AutoPostBack="true" OnTextChanged="txtSerName_TextChanged"></asp:TextBox>
                            </div>
                            <div class="col-md-3 col-lg-2">
                                <div class="row">
                                    <asp:Label ID="Label1" runat="server" Text="Hqrs Code" CssClass="col-md-5 col-lg-5 control-label "
                                        Style="padding-right: 0px"></asp:Label>
                                    <div class="col-md-7 col-lg-7">
                                        <asp:TextBox ID="txtSerHqrsCode" runat="server" CssClass="form-control input-sm"
                                            MaxLength="4" AutoPostBack="true" Style="text-transform: uppercase" OnTextChanged="txtSerHqrsCode_TextChanged"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <asp:Label ID="Label5" runat="server" Text="Sub Description" CssClass="col-md-1 col-lg-1 control-label "
                                Style="padding-right: 0px"></asp:Label>
                            <div class="col-md-2 col-lg-2">
                                <asp:TextBox ID="txtSerHqrsDesc" runat="server" CssClass="form-control input-sm"
                                    AutoPostBack="true" MaxLength="30" OnTextChanged="txtSerHqrsDesc_TextChanged"
                                    Style="text-transform: uppercase"></asp:TextBox>
                            </div>
                            <asp:Label ID="lblPageSize" runat="server" Text="Page Size" CssClass="col-md-1 col-lg-1 control-label"></asp:Label>
                            <div class="col-md-1 col-lg-1">
                                <asp:TextBox ID="txtPageSize" runat="server" CssClass="form-control input-sm" AutoPostBack="true"
                                    MaxLength="4" OnTextChanged="txtPageSize_TextChanged">                      
                                </asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <asp:GridView ID="grdSubject" runat="server" HorizontalAlign="Center" Width="100%"
                            OnRowDataBound="grdSubject_RowDataBound" AutoGenerateColumns="false" AllowPaging="true"
                            OnPageIndexChanging="grdSubject_PageIndexChanging" OnSelectedIndexChanged="grdSubject_SelectedIndexChanged"
                            DataKeyNames="id" CssClass=" table table-hover table-condensed " AlternatingRowStyle-BackColor="LightGray"
                            GridLines="Both" BorderStyle="Solid" BorderWidth="1px">
                            <HeaderStyle CssClass="bg-info" />
                            <Columns>
                                <asp:TemplateField HeaderText="Select" HeaderStyle-CssClass="GridHeaders" HeaderStyle-Width="5%">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" runat="server" AutoPostBack="true" GroupName="SingleSelection"
                                            onclick="CheckBoxCheck(this);" OnCheckedChanged="chkSelect_CheckedChanged" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sr No" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%"
                                    HeaderStyle-CssClass="GridHeaders">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSrNo" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="id" HeaderText="Subject Code" ItemStyle-Width="10%"
                                    HeaderStyle-CssClass="GridHeaders" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="ContactName" HeaderText="Subject Name" ItemStyle-Width="28%"
                                    ItemStyle-HorizontalAlign="Left" HeaderStyle-CssClass="GridHeaders" />
                                <asp:BoundField DataField="City" HeaderText="HQRS Sub Code" ItemStyle-Width="10%"
                                    HeaderStyle-CssClass="GridHeaders" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="Country" HeaderText="HQRS Sub Desc" ItemStyle-Width="28%"
                                    ItemStyle-HorizontalAlign="Left" HeaderStyle-CssClass="GridHeaders" />
                            </Columns>
                            <PagerStyle HorizontalAlign="Center" />
                            <PagerSettings Mode="NumericFirstLast" PageButtonCount="6" FirstPageText="First"
                                LastPageText="Last" />
                        </asp:GridView>
                        <!---DeleteSubject Modal Popup -->
                        <asp:LinkButton ID="lnkDeleteFake" runat="server"></asp:LinkButton>
                        <asp:Panel ID="pnlDeleteSubject" runat="server" CssClass="modalPopup" Style="display: none;
                            width: 30%">
                            <div id="Div1" runat="server" class="header">
                            </div>
                            <div style="overflow-y: auto; overflow-x: hidden; max-height: 450px;">
                                <div class="modal-header bg-danger" style="background-color: #d9534f">
                                    <div class="title" style="color: white; text-shadow: none">
                                        <i class="fa fa-trash"></i>Do you Want to delete this record ?
                                    </div>
                                </div>
                                <div align="right" class="modal-body" style="margin-top: 0px">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <asp:HiddenField ID="hfDeleteSubjectCode" runat="server" Value="0" />
                                            <asp:LinkButton ID="btnYes" runat="server" Text="Yes" OnClick="Yes" class="btn btn-danger btn-sm"
                                                CausesValidation="false" Style="text-shadow: none"><span class="glyphicon glyphicon-ok">&nbsp;YES</span></asp:LinkButton>
                                            <asp:Button ID="btnNo" runat="server" class="btn btn-default btn-sm" CausesValidation="false"
                                                Text="Cancel" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <cc1:ModalPopupExtender ID="mpeDeleteSubject" runat="server" PopupControlID="pnlDeleteSubject"
                            TargetControlID="lnkDeleteFake" BehaviorID="mpeDeletProduct" CancelControlID="btnNo"
                            BackgroundCssClass="modalBackground">
                        </cc1:ModalPopupExtender>
                        <!---DeleteSubject Modal Popup End-->
                        <!---MessageBox Modal Popup-->
                        <asp:LinkButton ID="lnkFakeAlert" runat="server"></asp:LinkButton>
                        <cc1:ModalPopupExtender ID="mpeMessageBox" runat="server" PopupControlID="pnlMessageAlert"
                            TargetControlID="lnkFakeAlert" BehaviorID="mpeMessageAlert" CancelControlID="btnCloseAlert"
                            BackgroundCssClass="modalBackground">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="pnlMessageAlert" runat="server" Style="display: none;">
                            <div class="alert alert-success" role="alert" runat="server" id="AlertMsg">
                                <asp:LinkButton ID="btnCloseAlert" runat="server" CssClass="close" data-dismiss="alert"
                                    aria-label="Close"><span aria-hidden="true">&times;</span></asp:LinkButton>
                                <span class=" glyphicon glyphicon-ok"></span>&nbsp;&nbsp;<strong>Alert!</strong>&nbsp;&nbsp;
                                <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;
                            </div>
                        </asp:Panel>
                        <!---MessageBox Modal Popup End-->
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="grdSubject" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
    <%--  <script src="js/jquery-1.8.3-jquery.min.js"></script>--%>

        </div>
    </form>
</body>
</html>
