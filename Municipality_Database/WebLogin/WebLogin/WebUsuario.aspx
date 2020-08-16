<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebUsuario.aspx.cs" Inherits="WebUsuario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 184px;
            height: 46px;
        }
        .auto-style3 {
            width: 262px;
            height: 46px;
        }
        .auto-style4 {
            width: 100%;
        }
        .auto-style5 {
            width: 277px;
            height: 46px;
        }
        .auto-style6 {
            height: 606px;
            width: 628px;
            margin-left: 567px;
            margin-top: 0px;
        }
        .auto-style7 {
            width: 277px;
            height: 61px;
        }
        .auto-style8 {
            width: 262px;
            height: 61px;
        }
        .auto-style9 {
            width: 184px;
            height: 61px;
        }
        .auto-style10 {
            height: 61px;
        }
        .auto-style11 {
            width: 277px;
            height: 75px;
        }
        .auto-style12 {
            width: 262px;
            height: 75px;
        }
        .auto-style13 {
            width: 184px;
            height: 75px;
        }
        .auto-style14 {
            height: 75px;
        }
        .auto-style15 {
            width: 277px;
            height: 73px;
        }
        .auto-style16 {
            width: 262px;
            height: 73px;
        }
        .auto-style17 {
            width: 184px;
            height: 73px;
        }
        .auto-style18 {
            width: 277px;
            height: 333px;
        }
        .auto-style19 {
            width: 262px;
            height: 333px;
        }
        .auto-style20 {
            width: 184px;
            height: 333px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="background-position: left top; background-image: url('ruinasFondoPaginas.jpg'); color: #FFFFFF; width: auto; height: 960px; background-attachment: scroll; text-align: center; background-repeat: no-repeat; vertical-align: top;">
            <div class="auto-style6">
                        <table class="auto-style4" style="text-align: center">
                            <tr>
                                <td class="auto-style18">
                                </td>
                                <td class="auto-style19">
                                </td>
                                <td class="auto-style20">
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style5">
                                </td>
                                <td class="auto-style3">
                                    <asp:Button ID="btnRecibosPen" runat="server" Text="Recibos Pendientes" OnClick="btnRecibosPen_Click" BorderStyle="Groove" Font-Names="Gloucester MT Extra Condensed" Font-Size="X-Large" />
                                </td>
                                <td class="auto-style1">
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style15">
                                </td>
                                <td class="auto-style16">
                                    <asp:Button ID="btnRecibosPag" runat="server" Text="Recibos Pagados" OnClick="btnRecibosPag_Click" BorderStyle="Groove" Font-Names="Gloucester MT Extra Condensed" Font-Size="X-Large" Width="190px" />
                                </td>
                                <td class="auto-style17">
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style11"></td>
                                <td class="auto-style12">
                                    <asp:Button ID="btnComprPago" runat="server" Text="Comprobante de Pago" OnClick="btnComprPago_Click" BorderStyle="Groove" Font-Names="Gloucester MT Extra Condensed" Font-Size="X-Large" Width="257px" />
                                </td>
                                <td class="auto-style13"></td>
                                <td class="auto-style14"></td>
                            </tr>
                            <tr>
                                <td class="auto-style7">
                                </td>
                                <td class="auto-style8">
                                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Pagar Recibos pendientes" BorderStyle="Groove" Font-Names="Gloucester MT Extra Condensed" Font-Size="X-Large" Width="274px" />
                                </td>
                                <td class="auto-style9"></td>
                                <td class="auto-style10"></td>
                            </tr>
                        </table>
                    </div>
        </div>
    </form>
</body>
</html>
