<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebUsuariosVsPropiedades.aspx.cs" Inherits="WebUsuariosVsPropiedades" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style2 {
            width: 147px;
        }
        .auto-style3 {
            width: 433px;
        }
        .auto-style5 {
            width: 147px;
            height: 26px;
        }
        .auto-style6 {
            width: 433px;
            height: 26px;
        }
        .auto-style7 {
            height: 26px;
        }
        .auto-style10 {
            width: 433px;
            height: 30px;
        }
        .auto-style11 {
            height: 30px;
        }
        .auto-style12 {
            width: 385px;
        }
        .auto-style13 {
            width: 482px;
        }
        .auto-style14 {
            width: 479px;
        }
        .auto-style15 {
            width: 181px;
            height: 30px;
        }
        .auto-style17 {
            width: 147px;
            height: 23px;
        }
        .auto-style18 {
            width: 433px;
            height: 23px;
        }
        .auto-style19 {
            height: 23px;
        }
        .auto-style21 {
            height: 224px;
        }
        .auto-style23 {
            width: 524px;
            height: 23px;
        }
        .auto-style24 {
            width: 524px;
            height: 26px;
        }
        .auto-style25 {
            width: 524px;
            height: 30px;
        }
        .auto-style26 {
            width: 524px;
        }
        .auto-style27 {
            width: 524px;
            height: 34px;
        }
        .auto-style28 {
            width: 147px;
            height: 34px;
        }
        .auto-style29 {
            width: 433px;
            height: 34px;
        }
        .auto-style30 {
            height: 34px;
        }
        .auto-style31 {
            width: 161px;
            height: 30px;
        }
        .auto-style32 {
            width: 524px;
            height: 27px;
        }
        .auto-style33 {
            width: 147px;
            height: 27px;
        }
        .auto-style34 {
            width: 482px;
            height: 27px;
        }
        .auto-style35 {
            width: 385px;
            height: 27px;
        }
        .auto-style36 {
            height: 27px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="font-family: 'Gloucester MT Extra Condensed'; font-size: large; font-weight: 500; color: #FFFFFF; background-image: url('ruinasFondoPaginas.jpg'); border-style: groove; width: auto; height: 960px">
        <table style="width:100%;">
            <tr>
                <td class="auto-style26">Usuarios vs Propiedades</td>
                <td class="auto-style2" colspan="2">&nbsp;</td>
                <td class="auto-style3" colspan="2">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style23"></td>
                <td class="auto-style17" colspan="2"></td>
                <td class="auto-style18" colspan="2"></td>
                <td class="auto-style19"></td>
            </tr>
            <tr>
                <td class="auto-style23">Crear Nueva Relación:</td>
                <td class="auto-style17" colspan="2"></td>
                <td class="auto-style18" colspan="2">Cambiar Datos:</td>
                <td class="auto-style19"></td>
            </tr>
            <tr>
                <td class="auto-style24">Ingrese el nombre de usuario:</td>
                <td class="auto-style5" colspan="2">
                    <asp:TextBox ID="txtNombreCrear" runat="server" Width="197px"> </asp:TextBox>
                </td>
                <td class="auto-style6" colspan="2">Ingrese el nombre de usuario que desea cambiar:<asp:TextBox ID="txtNombreOCambiar" runat="server"> </asp:TextBox>
                </td>
                <td class="auto-style7">
                </td>
            </tr>
            <tr>
                <td class="auto-style26">Ingrese el Numero de propiedad:</td>
                <td class="auto-style2" colspan="2">
                    <asp:TextBox ID="txtNumeroCrear" runat="server" Width="195px">0</asp:TextBox>
                </td>
                <td class="auto-style3" colspan="2">Ingrese el nuevo nombre de usuario:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="txtNombreNCambiar" runat="server"> </asp:TextBox>
&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style25"></td>
                <td class="auto-style15">
                    <asp:Button ID="btnCrear" runat="server" OnClick="Button3_Click" Text="Crear" Width="73px" />
                </td>
                <td class="auto-style31">
                    <asp:Button ID="btnEliminar" runat="server" BackColor="#CCFF99" Font-Bold="True" Font-Names="Constantia" OnClick="btnEliminar_Click" Text="Eliminar" />
                </td>
                <td class="auto-style10" colspan="2">Ingrese el numero de finca que desea cambiar:&nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="txtNumeroOCambiar" runat="server">0</asp:TextBox>
                </td>
                <td class="auto-style11"></td>
            </tr>
            <tr>
                <td class="auto-style25">Buscar:</td>
                <td class="auto-style15">
                    &nbsp;</td>
                <td class="auto-style31">
                    &nbsp;</td>
                <td class="auto-style10" colspan="2">Ingrese el nuevo número de finca:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="txtNumeroNCambiar" runat="server">0</asp:TextBox>
                </td>
                <td class="auto-style11">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style27">Ingrese el Nombre de usuario:</td>
                <td class="auto-style28">
                    <asp:TextBox ID="nomUsuario" runat="server" Width="113px"> </asp:TextBox>
                </td>
                <td class="auto-style28">
                    <asp:Button ID="btnAceptar" runat="server" OnClick="Button1_Click" Text="Buscar" BackColor="#99FF99" Font-Bold="True" Font-Italic="False" Font-Names="Constantia" />
                </td>
                <td class="auto-style29" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnCambiar" runat="server" BackColor="#FFFF99" OnClick="btnCambiar_Click" Text="Aceptar" />
                </td>
                <td class="auto-style30"></td>
            </tr>
            <tr>
                <td class="auto-style32">Ingrese el Numero de propiedad:</td>
                <td class="auto-style33">
                    <asp:TextBox ID="numPropiedad" runat="server" Width="112px">0</asp:TextBox>
                </td>
                <td class="auto-style33">
                    <asp:Button ID="btnBuscarFinca" runat="server" OnClick="btnBuscarFinca_Click" Text="Buscar" />
                </td>
                <td class="auto-style34">
                    <asp:Label ID="lblError" runat="server"></asp:Label>
                </td>
                <td class="auto-style35"></td>
                <td class="auto-style36"></td>
            </tr>
            <tr>
                <td class="auto-style26">&nbsp;</td>
                <td class="auto-style2" colspan="2">
                    &nbsp;</td>
                <td class="auto-style13">&nbsp;</td>
                <td class="auto-style12">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td colspan="5">
                    <table style="width:100%;">
                        <tr>
                            <td class="auto-style21" colspan="3">
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" BackColor="#666666" BorderColor="White" ForeColor="White" Width="840px" AllowPaging="True">
                                    <Columns>
                                        <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                                        <asp:BoundField DataField="NumeroFinca" HeaderText="NumeroFinca" SortExpression="NumeroFinca" />
                                        <asp:BoundField DataField="Direccion" HeaderText="Direccion" SortExpression="Direccion" />
                                        <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" />
                                    </Columns>
                                </asp:GridView>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=.;Initial Catalog=Tarea2;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Usuario.Username, Propiedad.NumeroFinca, Propiedad.Direccion, Propiedad.Valor FROM Usuario INNER JOIN UsuarioDePropiedad ON Usuario.Id = UsuarioDePropiedad.UsuarioId INNER JOIN Propiedad ON UsuarioDePropiedad.PropiedadId = Propiedad.Id WHERE (UsuarioDePropiedad.Activo = 1)"></asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style14">&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="auto-style14">&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                            </table>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
        </div>
            </form>
        </body>
        </html>
