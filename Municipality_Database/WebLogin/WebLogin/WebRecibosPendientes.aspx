<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebRecibosPendientes.aspx.cs" Inherits="WebRecibosPagados" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 648px;
        }
        .auto-style2 {
            width: 488px;
        }
        .auto-style3 {
            width: 648px;
            height: 23px;
        }
        .auto-style4 {
            width: 488px;
            height: 23px;
        }
        .auto-style5 {
            height: 23px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="font-family: 'Gloucester MT Extra Condensed'; font-size: large; font-weight: 500; color: #FFFFFF; text-align: center; background-image: url('ruinasFondoPaginas.jpg'); background-repeat: no-repeat; background-attachment: scroll; background-position: left top; border-style: groove; width: auto; height: 960px">
            <table style="width:100%;">
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">RECIBOS PENDIENTES:</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">
                        <asp:Label ID="lblError" runat="server"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=.;Initial Catalog=Tarea2;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Propiedad.NumeroFinca, Recibo.FechaEmision, Recibo.FechaVencimiento, Recibo.Monto FROM Propiedad INNER JOIN Recibo ON Propiedad.Id = Recibo.PropiedadId INNER JOIN UsuarioDePropiedad INNER JOIN Usuario ON UsuarioDePropiedad.UsuarioId = Usuario.Id ON Propiedad.Id = UsuarioDePropiedad.PropiedadId WHERE (Recibo.Activo = 1) AND (Recibo.Estado = 0) ORDER BY Recibo.FechaEmision"></asp:SqlDataSource>
                        <asp:GridView ID="listaPendientes" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="#666666" BorderColor="White" DataSourceID="SqlDataSource1" ForeColor="White" PageSize="20">
                            <Columns>
                                <asp:BoundField DataField="NumeroFinca" HeaderText="NumeroFinca" SortExpression="NumeroFinca" />
                                <asp:BoundField DataField="FechaEmision" HeaderText="FechaEmision" SortExpression="FechaEmision" />
                                <asp:BoundField DataField="FechaVencimiento" HeaderText="FechaVencimiento" SortExpression="FechaVencimiento" />
                                <asp:BoundField DataField="Monto" HeaderText="Monto" SortExpression="Monto" />
                            </Columns>
                        </asp:GridView>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style3"></td>
                    <td class="auto-style4"></td>
                    <td class="auto-style5"></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
