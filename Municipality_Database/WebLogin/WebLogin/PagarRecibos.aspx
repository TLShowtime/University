<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PagarRecibos.aspx.cs" Inherits="PagarRecibos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 464px;
        }
        .auto-style2 {
            width: 762px;
        }
        .auto-style3 {
            margin-left: 2px;
        }
        .auto-style4 {
            width: 747px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="background-image: url('ruinasFondoPaginas.jpg'); background-repeat: no-repeat; background-attachment: scroll; background-position: left top; border-style: groove; text-align: center; width: auto; height: 960px; font-family: 'Gloucester MT Extra Condensed'; font-size: large; font-weight: 500; color: #FFFFFF;">
            <table style="width:100%; font-family: 'Gloucester MT Extra Condensed'; font-size: x-large; font-weight: 500; color: #FFFFFF; text-align: center;">
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2" colspan="2">Seleccione los recibos que quiere pagar:<asp:Label ID="Label2" runat="server"></asp:Label>
                        <asp:Label ID="Label1" runat="server"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2" colspan="2">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged1" BackColor="#666666" BorderColor="White" CssClass="auto-style3" ForeColor="White">
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" InsertVisible="False" ReadOnly="True" />
                                <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                                <asp:BoundField DataField="NumeroFinca" HeaderText="NumeroFinca" SortExpression="NumeroFinca" />
                                <asp:BoundField DataField="FechaEmision" HeaderText="FechaEmision" SortExpression="FechaEmision" />
                                <asp:BoundField DataField="FechaVencimiento" HeaderText="FechaVencimiento" SortExpression="FechaVencimiento" />
                                <asp:BoundField DataField="Monto" HeaderText="Monto" SortExpression="Monto" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=.;Initial Catalog=Tarea2;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Usuario.Username, Propiedad.NumeroFinca, Recibo.FechaEmision, Recibo.FechaVencimiento, Recibo.Monto, Recibo.Id FROM Propiedad INNER JOIN Recibo ON Propiedad.Id = Recibo.PropiedadId INNER JOIN UsuarioDePropiedad INNER JOIN Usuario ON UsuarioDePropiedad.UsuarioId = Usuario.Id ON Propiedad.Id = UsuarioDePropiedad.PropiedadId WHERE (Recibo.Activo = 1) AND (Recibo.Estado = 0) ORDER BY Recibo.FechaEmision"></asp:SqlDataSource>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style4">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Pagar" Width="100px" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" OnClick="btnCancelar_Click" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
