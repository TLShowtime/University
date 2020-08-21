<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebComprobantesPago.aspx.cs" Inherits="WebComprobantesPago" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Comprobantes de Pago</title>
    <style type="text/css">
        .auto-style1 {
            width: 602px;
        }
        .auto-style2 {
            width: 390px;
        }
        .auto-style3 {
            width: 602px;
            height: 23px;
        }
        .auto-style4 {
            width: 390px;
            height: 23px;
        }
        .auto-style5 {
            height: 23px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="font-family: 'Gloucester MT Extra Condensed'; font-size: large; font-weight: 500; color: #FFFFFF; text-align: center; background-image: url('ruinasFondoPaginas.jpg'); border-style: groove; width: auto; height: 960px">
            <table style="width:100%;">
                <tr>
                    <td class="auto-style3"></td>
                    <td class="auto-style4">COMPROBANTES DE PAGO:</td>
                    <td class="auto-style5"></td>
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
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">
                        <asp:GridView ID="listaComprobantes" runat="server" AutoGenerateColumns="False" DataKeyNames="Numero" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="listaComprobantes_SelectedIndexChanged" AllowPaging="True" BackColor="#666666" BorderColor="White" ForeColor="White" PageSize="17">
                            <Columns>
                                <asp:BoundField DataField="MedioPago" HeaderText="MedioPago" SortExpression="MedioPago" />
                                <asp:BoundField DataField="Numero" HeaderText="Numero" SortExpression="Numero" InsertVisible="False" ReadOnly="True" />
                                <asp:BoundField DataField="Fecha" HeaderText="Fecha" SortExpression="Fecha" />
                                <asp:BoundField DataField="TotalPagado" HeaderText="TotalPagado" SortExpression="TotalPagado" />
                                <asp:BoundField DataField="NumeroFinca" HeaderText="NumeroFinca" SortExpression="NumeroFinca" />
                                <asp:CommandField SelectText="Detalle" ShowSelectButton="True" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=.;Initial Catalog=Tarea2;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT  ComprobantePago.MedioPago, ComprobantePago.Id AS Numero, ComprobantePago.Fecha, ComprobantePago.TotalPagado, Propiedad.NumeroFinca FROM ConceptoCobro INNER JOIN Recibo ON ConceptoCobro.Id = Recibo.ConceptoCobroId INNER JOIN ComprobantePago ON Recibo.ComprobanteId = ComprobantePago.Id INNER JOIN Propiedad ON Recibo.PropiedadId = Propiedad.Id INNER JOIN UsuarioDePropiedad ON Propiedad.Id = UsuarioDePropiedad.PropiedadId INNER JOIN Usuario ON UsuarioDePropiedad.UsuarioId = Usuario.Id WHERE (ComprobantePago.Activo = 1) ORDER BY ComprobantePago.Fecha DESC"></asp:SqlDataSource>
                    </td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
