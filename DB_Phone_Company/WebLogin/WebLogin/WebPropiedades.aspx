<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebPropiedades.aspx.cs" Inherits="Propiedades" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Propiedades</title>
    <style type="text/css">
        .auto-style3 {
            width: 87%;
        }
        .auto-style1 {
            width: 226px;
        }
        .auto-style6 {
            width: 354px;
        }
        .auto-style9 {
            margin-left: 0px;
        }
        .auto-style12 {
            width: 5px;
        }
        .auto-style13 {
            width: 146px;
        }
        .auto-style14 {
            width: 86px;
        }
        .auto-style15 {
            width: 125%;
        }
        .auto-style17 {
            width: 154%;
        }
        .auto-style18 {
            width: 354px;
            height: 63px;
        }
        .auto-style19 {
            width: 80px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="background-position: left top; border-style: groove; font-family: 'Gloucester MT Extra Condensed'; font-size: large; font-weight: 500; color: #FFFFFF; text-align: center; background-image: url('ruinasFondoPaginas.jpg'); background-repeat: no-repeat; background-attachment: scroll; width: auto; height: 960px;">
            <table class="auto-style3" style="text-align: left">
                <tr>
                    <td class="auto-style1">
                        &nbsp;</td>
                    <td class="auto-style1">
                        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Volver a la pantalla de Administrador" Width="239px" />
                    </td>
                    <td class="auto-style6">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">
                        &nbsp;</td>
                    <td class="auto-style1">
                        &nbsp;</td>
                    <td class="auto-style6">
&nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1" rowspan="2">
                        &nbsp;</td>
                    <td class="auto-style1" rowspan="2">
                        <table class="auto-style17" style="text-align: left">
                            <tr>
                                <td class="auto-style19">&nbsp;</td>
                                <td>Cambiar:</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style19">&nbsp;</td>
                                <td>
                                    Número de Finca:&nbsp;&nbsp;&nbsp;<asp:TextBox ID="txtNumCambiar" runat="server"></asp:TextBox>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style19">&nbsp;</td>
                                <td>
                                    Nuevo Número de Finca:&nbsp;
                                    <asp:TextBox ID="txtNuevoNumCambiar" runat="server"></asp:TextBox>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style19">&nbsp;</td>
                                <td>
                                    Dirección:&nbsp;&nbsp;
                                    <asp:TextBox ID="txtDirCambiar" runat="server"></asp:TextBox>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style19">&nbsp;</td>
                                <td>
                                    Valor:&nbsp;&nbsp;
                                    <asp:TextBox ID="txtValorCambiar" runat="server"></asp:TextBox>
                                &nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style19">&nbsp;</td>
                                <td>
                                    <asp:Button ID="btnCambiar" runat="server" OnClick="btnCambiar_Click" Text="Cambiar" />
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style19">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                    <td class="auto-style18">
                        &nbsp;
                    &nbsp;<table class="auto-style15" style="text-align: left">
                            <tr>
                                <td class="auto-style12">&nbsp;</td>
                                <td class="auto-style13">
                                    Número de Finca:&nbsp;&nbsp;<asp:TextBox ID="txtNumeroInsert" runat="server" CssClass="auto-style9"></asp:TextBox>
                                </td>
                                <td class="auto-style14">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style12">&nbsp;</td>
                                <td class="auto-style13">
                                    Dirección:<asp:TextBox ID="txtDireccionInsert" runat="server"></asp:TextBox>
                                </td>
                                <td class="auto-style14">
                                    <asp:Label ID="lblError" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style12">&nbsp;</td>
                                <td class="auto-style13">
                                    Valor:<asp:TextBox ID="txtValorInsert" runat="server"></asp:TextBox>
                                </td>
                                <td class="auto-style14">&nbsp;</td>
                            </tr>
                        </table>
                        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Agregar Nuevo Propietario" />
                        <br />
                        &nbsp; Número de Finca:&nbsp;<asp:TextBox ID="txtNumeroEliminar" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Eliminar" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td colspan="2">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowPaging="True" BackColor="#666666" BorderColor="White" ForeColor="White" PageSize="12">
                            <Columns>
                                <asp:BoundField DataField="NumeroFinca" HeaderText="NumeroFinca" SortExpression="NumeroFinca" />
                                <asp:BoundField DataField="Direccion" HeaderText="Direccion" SortExpression="Direccion" />
                                <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" />
                                <asp:BoundField DataField="FechaCreacion" HeaderText="FechaCreacion" SortExpression="FechaCreacion" />
                                <asp:BoundField DataField="M3Acumulados" HeaderText="M3Acumulados" SortExpression="M3Acumulados" />
                                <asp:BoundField DataField="M3AcumuladosUltimoRecibo" HeaderText="M3AcumuladosUltimoRecibo" SortExpression="M3AcumuladosUltimoRecibo" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=LAPTOP-RCGTG6D0;Initial Catalog=Tarea2;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [NumeroFinca], [Direccion], [Valor], [FechaCreacion], [M3Acumulados], [M3AcumuladosUltimoRecibo] FROM [Propiedad]"></asp:SqlDataSource>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
