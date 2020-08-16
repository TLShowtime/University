<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PagadosPorComprobante.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 547px;
        }
        .auto-style2 {
            width: 694px;
        }
        .auto-style3 {
            margin-left: 89px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="background-color: #00FFFF; background-image: url('ruinasFondoPaginas.jpg'); background-repeat: no-repeat; background-attachment: scroll; background-position: left top; border-style: groove; width: auto; height: 960px; text-align: center; font-family: 'Gloucester MT Extra Condensed'; font-size: large; font-weight: 300;">
            <table style="width: 100%; text-align: center; font-family: 'Gloucester MT Extra Condensed'; font-size: large; font-weight: 500; color: #FFFFFF;">
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">Recibos pagados por Comprobante:</td>
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
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1" BackColor="#666666" BorderColor="White" BorderStyle="Dashed" CssClass="auto-style3" ForeColor="White" Height="298px" Width="589px">
                            <Columns>
                                <asp:BoundField DataField="Id" HeaderText="Numero Recibo" SortExpression="Id" InsertVisible="False" ReadOnly="True" />
                                <asp:BoundField DataField="NumeroFinca" HeaderText="NumeroFinca" SortExpression="NumeroFinca" />
                                <asp:BoundField DataField="FechaEmision" HeaderText="FechaEmision" SortExpression="FechaEmision" />
                                <asp:BoundField DataField="FechaVencimiento" HeaderText="FechaVencimiento" SortExpression="FechaVencimiento" />
                                <asp:BoundField DataField="Monto" HeaderText="Monto" SortExpression="Monto" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=.;Initial Catalog=Tarea2;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Propiedad.NumeroFinca, Recibo.FechaEmision, Recibo.FechaVencimiento, Recibo.Monto, Recibo.Id FROM Recibo INNER JOIN ComprobantePago ON Recibo.ComprobanteId = ComprobantePago.Id INNER JOIN Propiedad ON Recibo.PropiedadId = Propiedad.Id WHERE (Recibo.Activo = 1) AND (Recibo.Estado = 1) ORDER BY Recibo.FechaEmision"></asp:SqlDataSource>
                    </td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
