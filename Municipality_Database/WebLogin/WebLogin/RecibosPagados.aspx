<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RecibosPagados.aspx.cs" Inherits="RecibosPagados" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Recibos Pagados</title>
    <style type="text/css">
        .auto-style1 {
            width: 182px;
        }
        .auto-style2 {
            width: 1192px;
        }
        .auto-style3 {
            width: 182px;
            height: 23px;
        }
        .auto-style4 {
            width: 1192px;
            height: 23px;
        }
        .auto-style5 {
            height: 23px;
        }
        .auto-style6 {
            width: 100%;
            margin-top: 6px;
        }
        .auto-style7 {
            margin-left: 410px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="font-family: 'Gloucester MT Extra Condensed'; font-size: large; font-weight: 500; color: #FFFFFF; text-align: center; background-image: url('ruinasFondoPaginas.jpg'); background-repeat: no-repeat; background-attachment: inherit; background-position: left top; width: auto; height: 960px">
            <table class="auto-style6">
                <tr>
                    <td class="auto-style3"></td>
                    <td class="auto-style4">RECIBOS PAGADOS:</td>
                    <td class="auto-style5"></td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">&nbsp;<asp:Label ID="lblError" runat="server"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style3"></td>
                    <td class="auto-style4"></td>
                    <td class="auto-style5"></td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">
                        <asp:GridView ID="listaRecibos" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="#666666" BorderColor="White" CssClass="auto-style7" DataSourceID="SqlDataSource1" ForeColor="White" Height="377px" PageSize="17" Width="486px">
                            <Columns>
                                <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                                <asp:BoundField DataField="NumeroFinca" HeaderText="NumeroFinca" SortExpression="NumeroFinca" />
                                <asp:BoundField DataField="FechaEmision" HeaderText="FechaEmision" SortExpression="FechaEmision" />
                                <asp:BoundField DataField="FechaVencimiento" HeaderText="FechaVencimiento" SortExpression="FechaVencimiento" />
                                <asp:BoundField DataField="Monto" HeaderText="Monto" SortExpression="Monto" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=.;Initial Catalog=Tarea2;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Usuario.Username, Propiedad.NumeroFinca, Recibo.FechaEmision, Recibo.FechaVencimiento, Recibo.Monto FROM Recibo INNER JOIN ComprobantePago ON Recibo.ComprobanteId = ComprobantePago.Id INNER JOIN ConceptoCobro ON Recibo.ConceptoCobroId = ConceptoCobro.Id INNER JOIN Propiedad ON Recibo.PropiedadId = Propiedad.Id INNER JOIN UsuarioDePropiedad ON Propiedad.Id = UsuarioDePropiedad.PropiedadId INNER JOIN Usuario ON UsuarioDePropiedad.UsuarioId = Usuario.Id INNER JOIN PropietarioDePropiedad ON Propiedad.Id = PropietarioDePropiedad.PropiedadId INNER JOIN Propietario ON PropietarioDePropiedad.PropietarioId = Propietario.Id WHERE (Recibo.Activo = 1) AND (Recibo.Estado = 1)"></asp:SqlDataSource>
                    </td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
