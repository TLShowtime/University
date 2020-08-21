<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebCRUDUsuario.aspx.cs" Inherits="WebCRUDUsuario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Usuarios</title>
    <style type="text/css">
        .auto-style2 {
            width: 126px;
        }
        .auto-style4 {
            width: 126px;
            height: 23px;
        }
        .auto-style6 {
            height: 23px;
        }
        .auto-style8 {
            width: 407px;
            height: 23px;
        }
        .auto-style9 {
            width: 407px;
        }
        .auto-style10 {
            width: 253px;
        }
        .auto-style11 {
            width: 6px;
        }
        .auto-style12 {
            width: 139px;
        }
        .auto-style13 {
            width: 139px;
            height: 23px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="font-family: 'Gloucester MT Extra Condensed'; font-size: large; font-weight: 500; color: #FFFFFF; text-align: center; background-image: url('ruinasFondoPaginas.jpg'); background-repeat: no-repeat; background-attachment: scroll; background-position: left top; border-style: groove; width: auto; height: 960px">
            Usuarios:<table style="width:100%;">
                <tr>
                    <td class="auto-style9">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td class="auto-style12">&nbsp;</td>
                    <td colspan="2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style9">&nbsp;</td>
                    <td colspan="2">Crear:</td>
                    <td colspan="2">Cambiar:</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style9">&nbsp;</td>
                    <td class="auto-style2">Nombre de Usuario:</td>
                    <td class="auto-style12">
                        <asp:TextBox ID="txtNomUsuarioCrear" runat="server"></asp:TextBox>
                    </td>
                    <td class="auto-style10">Nombre del usuario que desea cambiar:</td>
                    <td class="auto-style11">
                        <asp:TextBox ID="txtNombreUsuarioCambiar" runat="server"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style9">&nbsp;</td>
                    <td class="auto-style2">Contraseña:</td>
                    <td class="auto-style12">
                        <asp:TextBox ID="txtContrasennaCrear" runat="server">0</asp:TextBox>
                    </td>
                    <td class="auto-style10">Nuevo nombre de usuario:</td>
                    <td class="auto-style11">
                        <asp:TextBox ID="txtNuevoNombreCambiar" runat="server"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style9">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td class="auto-style12">
                        <asp:DropDownList ID="listaTipoUsuarioCrear" runat="server">
                            <asp:ListItem>Tipo de Usuario</asp:ListItem>
                            <asp:ListItem>cliente</asp:ListItem>
                            <asp:ListItem>administrador</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style10">Contraseña:</td>
                    <td class="auto-style11">
                        <asp:TextBox ID="txtContrasennaCambiar" runat="server"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style9">&nbsp;</td>
                    <td colspan="2">
                        <asp:Button ID="btnCrear" runat="server" OnClick="btnCrear_Click" Text="Crear" Width="115px" />
                        <asp:Button ID="btnEliminar" runat="server" OnClick="btnEliminar_Click" Text="Eliminar" Width="125px" />
                    </td>
                    <td class="auto-style10">&nbsp;</td>
                    <td class="auto-style11">
                        <asp:DropDownList ID="listaTipoUsuarioCambiar" runat="server">
                            <asp:ListItem>Tipo de Usuario</asp:ListItem>
                            <asp:ListItem>cliente</asp:ListItem>
                            <asp:ListItem>administrador</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style9">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td class="auto-style12">
                        <asp:Label ID="lblError" runat="server"></asp:Label>
                    </td>
                    <td class="auto-style10">&nbsp;</td>
                    <td class="auto-style11">
                        <asp:Button ID="btnCambiar" runat="server" OnClick="btnCambiar_Click" Text="Cambiar" />
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style8">&nbsp;</td>
                    <td class="auto-style4"></td>
                    <td class="auto-style13"></td>
                    <td class="auto-style6" colspan="2"></td>
                    <td class="auto-style6"></td>
                </tr>
                <tr>
                    <td class="auto-style8">&nbsp;</td>
                    <td class="auto-style6" colspan="4">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowPaging="True" BackColor="#666666" BorderColor="White" ForeColor="White" Width="658px">
                            <Columns>
                                <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                                <asp:BoundField DataField="Contrasenna" HeaderText="Contrasenna" SortExpression="Contrasenna" />
                                <asp:BoundField DataField="TipoUsuario" HeaderText="TipoUsuario" SortExpression="TipoUsuario" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=LAPTOP-RCGTG6D0;Initial Catalog=Tarea2;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Username, Contrasenna, TipoUsuario FROM Usuario WHERE (Activo = 1)"></asp:SqlDataSource>
                    </td>
                    <td class="auto-style6">&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
