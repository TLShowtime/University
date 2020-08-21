<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebPropietarios.aspx.cs" Inherits="WebPropietarios" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 343px;
        }
        .auto-style3 {
            width: 74%;
        }
        .auto-style4 {
            width: 78px;
        }
        .auto-style5 {
            width: 100%;
        }
        .auto-style6 {
            width: 354px;
        }
        .auto-style8 {
            width: 548px;
        }
        .auto-style9 {
            width: 114px;
        }
        .auto-style10 {
            width: 706px;
        }
        .auto-style11 {
            margin-left: 185px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="font-family: 'Gloucester MT Extra Condensed'; font-size: large; font-weight: 500; color: #FFFFFF; background-image: url('ruinasFondoPaginas.jpg'); background-repeat: no-repeat; background-attachment: scroll; background-position: left top; border-style: groove; width: auto; height: 960px">
            <table class="auto-style3">
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style10">&nbsp;</td>
                    <td class="auto-style6">&nbsp;</td>
                    <td class="auto-style8">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">
                        <table style="width:100%;">
                            <tr>
                                <td class="auto-style9">Cambiar:</td>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style9">Nombre:</td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtNombreCambiar" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style9">ID del propietario</td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtIDCambiar" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style9">Nuevo ID:</td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtNuevoIDCambiar" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style9">ValorTipoDocId</td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtValorTDid" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style9">&nbsp;</td>
                                <td colspan="2">
                                    <asp:DropDownList ID="listaJuridicoCambiar" runat="server">
                                        <asp:ListItem>Seleccione una opción</asp:ListItem>
                                        <asp:ListItem>Jurídico</asp:ListItem>
                                        <asp:ListItem>No Jurídico</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style9">&nbsp;</td>
                                <td colspan="2">
                                    <asp:Button ID="btnCambiar" runat="server" OnClick="btnCambiar_Click" Text="Cambiar" />
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style9">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                    <td class="auto-style10">&nbsp;</td>
                    <td class="auto-style6">
                        <table class="auto-style5">
                            <tr>
                                <td class="auto-style4">Nombre:&nbsp;</td>
                                <td>
                                    <asp:TextBox ID="txtNombreInsert" runat="server"></asp:TextBox>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style4">Identificación:</td>
                                <td>
                                    <asp:TextBox ID="txtIdentificacionInsert" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:DropDownList ID="listJuridico" runat="server">
                                        <asp:ListItem>Seleccione una opción</asp:ListItem>
                                        <asp:ListItem>Juridico</asp:ListItem>
                                        <asp:ListItem>No Juridico</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style4">ValorTipoID:</td>
                                <td>
                                    <asp:TextBox ID="txtValorTipoIdInsert" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblError" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Agregar Nuevo Propietario" />
                        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Eliminar" />
                    </td>
                    <td class="auto-style8">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style6">
&nbsp;&nbsp;
                        </td>
                    <td class="auto-style8">
                        &nbsp;</td>
                </tr>
            </table>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="741px" AllowPaging="True" BackColor="#666666" BorderColor="White" CssClass="auto-style11" ForeColor="White" PageSize="17">
                <Columns>
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                    <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                    <asp:BoundField DataField="ValorTipoDocId" HeaderText="ValorTipoDocId" SortExpression="ValorTipoDocId" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=LAPTOP-RCGTG6D0;Initial Catalog=Tarea2;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Nombre, Identificacion, ValorTipoDocId FROM Propietario WHERE (Activo = 1)"></asp:SqlDataSource>
            <br />
        </div>
    </form>
</body>
</html>
