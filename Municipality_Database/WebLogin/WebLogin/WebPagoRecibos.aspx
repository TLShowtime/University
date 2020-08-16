<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebPagoRecibos.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 95px;
        }
        .auto-style2 {
            margin-left: 540px;
            margin-top: 79px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="font-family: 'Gloucester MT Extra Condensed'; font-size: large; font-weight: 500; color: #FFFFFF; text-align: center; background-image: url('ruinasFondoPaginas.jpg'); background-repeat: no-repeat; background-attachment: scroll; background-position: left top; border-style: groove; width: auto; height: 960px">
            <table style="width: 100%; text-align: center;">
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td>Seleccione la propiedad a la que le quiere pagar los recibos:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="Label1" runat="server"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="608px" AllowPaging="True" BackColor="#666666" BorderColor="White" CssClass="auto-style2" ForeColor="White">
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                                <asp:BoundField DataField="NumeroFinca" HeaderText="NumeroFinca" SortExpression="NumeroFinca" />
                                <asp:BoundField DataField="Direccion" HeaderText="Direccion" SortExpression="Direccion" />
                                <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=LAPTOP-RCGTG6D0;Initial Catalog=Tarea2;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Usuario.Username, Propiedad.NumeroFinca, Propiedad.Direccion, Propiedad.Valor FROM Usuario INNER JOIN UsuarioDePropiedad ON Usuario.Id = UsuarioDePropiedad.UsuarioId INNER JOIN Propiedad ON UsuarioDePropiedad.PropiedadId = Propiedad.Id WHERE (Usuario.Username LIKE '%&quot; + Convert.ToString(Session[&quot;UsuarioSesion&quot;])+ &quot;%')"></asp:SqlDataSource>
                    </td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
