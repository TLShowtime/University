<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebPropiedadesDePropietario.aspx.cs" Inherits="WebPropiedadesDePropietario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Propiedades VS Propietarios</title>
    <style type="text/css">
        .auto-style1 {
            width: 206px;
        }
        .auto-style2 {
            width: 164px;
        }
        .auto-style3 {
            width: 273px;
            height: 30px;
        }
        .auto-style4 {
            width: 541px;
            height: 30px;
        }
        .auto-style7 {
            margin-left: 0px;
        }
        .auto-style9 {
            width: 158px;
        }
        .auto-style11 {
            width: 126px;
        }
        .auto-style12 {
            width: 291%;
            margin-right: 43px;
        }
        .auto-style14 {
            width: 25px;
        }
        .auto-style15 {
            width: 130px;
        }
        .auto-style16 {
            width: 224%;
            height: 94px;
        }
        .auto-style17 {
            width: 50px;
        }
        .auto-style18 {
            width: 232px;
        }
        .auto-style19 {
            width: 232px;
            height: 26px;
        }
        .auto-style20 {
            height: 26px;
        }
        .auto-style21 {
            width: 541px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="font-family: 'Gloucester MT Extra Condensed'; font-size: large; font-weight: 500; color: #FFFFFF; background-image: url('ruinasFondoPaginas.jpg'); background-repeat: no-repeat; background-attachment: scroll; background-position: left top; border-style: groove; width: auto; height: 960px">
            <table style="width:100%;">
                <tr>
                    <td class="auto-style1" colspan="4">Propiedades de un propietario:</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1" colspan="2">Crear:</td>
                    <td class="auto-style1" colspan="2">Cambiar Datos:</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style11" colspan="2">
                        <table class="auto-style12">
                            <tr>
                                <td class="auto-style15">Número de Finca:<asp:TextBox ID="txtNumFincaCrear" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:DropDownList ID="listJuridico" runat="server">
                                        <asp:ListItem>Seleccione una opción</asp:ListItem>
                                        <asp:ListItem>Jurídico</asp:ListItem>
                                        <asp:ListItem>No Jurídico</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td class="auto-style14">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style15">Identificación:<asp:TextBox ID="txtIdentPropieCrear" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblError" runat="server"></asp:Label>
                                </td>
                                <td class="auto-style14">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style15">&nbsp;</td>
                                <td>
                                    <asp:Button ID="btnCrear" runat="server" OnClick="btnCrear_Click" Text="Crear" Width="100px" />
                                    <asp:Button ID="btnEliminar" runat="server" OnClick="btnEliminar_Click" Text="Eliminar" />
                                </td>
                                <td class="auto-style14">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                    <td class="auto-style1" colspan="2">
                        <table class="auto-style16">
                            <tr>
                                <td class="auto-style19">Número de Finca que desea cambiar:</td>
                                <td class="auto-style20">
                                    <asp:TextBox ID="txtNumFincaO" runat="server"></asp:TextBox>
                                </td>
                                <td class="auto-style20"></td>
                            </tr>
                            <tr>
                                <td class="auto-style18">Nuevo número de finca:</td>
                                <td>
                                    <asp:TextBox ID="txtNumFincaN" runat="server"></asp:TextBox>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style18">Identificación del propietario:</td>
                                <td>
                                    <asp:TextBox ID="txtIdentPropieO" runat="server"></asp:TextBox>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style18">Nueva Identificación:</td>
                                <td>
                                    <asp:TextBox ID="txtIdentPropieN" runat="server"></asp:TextBox>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style18">
                                    <asp:Label ID="lblError0" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="listJuridico1" runat="server">
                                        <asp:ListItem>Seleccione una opción</asp:ListItem>
                                        <asp:ListItem>Jurídico</asp:ListItem>
                                        <asp:ListItem>No Jurídico</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style18">&nbsp;</td>
                                <td>
                                    <asp:Button ID="btnCambiar" runat="server" OnClick="btnCambiar_Click" Text="Cambiar" />
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style21">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1" colspan="4">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1" colspan="4">Buscar:</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style4">Identificación del propietario:&nbsp;&nbsp;&nbsp;
                        <asp:TextBox ID="txtIDPropietario" runat="server" Width="151px"></asp:TextBox>
                        <asp:Button ID="btnBuscar" runat="server" Height="22px" OnClick="btnBuscar_Click" Text="Buscar" Width="54px" />
                        <br />
                        <br />
                        Nombre de Propietario:<asp:TextBox ID="txtNombreBuscar" runat="server" Width="152px"></asp:TextBox>
                        <asp:Button ID="btnBuscar3" runat="server" OnClick="btnBuscar3_Click" Text="Buscar" />
                        <br />
                        <br />
                        Número de Finca:&nbsp;&nbsp;
                        <asp:TextBox ID="txtNumFincaBuscar" runat="server" CssClass="auto-style7" Width="153px"></asp:TextBox>
                        <asp:Button ID="btnBuscar2" runat="server" Height="23px" OnClick="btnBuscar2_Click" Text="Buscar" />
                    </td>
                    <td class="auto-style3" colspan="3">
                        <br />
                        <br />
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style21">&nbsp;</td>
                    <td class="auto-style9" colspan="2">&nbsp;</td>
                    <td class="auto-style17">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1" colspan="4">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="1312px" AllowPaging="True" BackColor="#666666" BorderColor="White" ForeColor="White">
                            <Columns>
                                <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                                <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                                <asp:BoundField DataField="NumeroFinca" HeaderText="NumeroFinca" SortExpression="NumeroFinca" />
                                <asp:BoundField DataField="Direccion" HeaderText="Direccion" SortExpression="Direccion" />
                                <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" />
                                <asp:BoundField DataField="FechaInicio" HeaderText="FechaInicio" SortExpression="FechaInicio" />
                                <asp:BoundField DataField="FechaFinal" HeaderText="FechaFinal" SortExpression="FechaFinal" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=LAPTOP-RCGTG6D0;Initial Catalog=Tarea2;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Propietario.Nombre, Propietario.Identificacion, Propiedad.NumeroFinca, Propiedad.Direccion, Propiedad.Valor, PropietarioDePropiedad.FechaInicio, PropietarioDePropiedad.FechaFinal FROM PropietarioDePropiedad INNER JOIN Propietario ON PropietarioDePropiedad.PropietarioId = Propietario.Id INNER JOIN Propiedad ON PropietarioDePropiedad.PropiedadId = Propiedad.Id WHERE (PropietarioDePropiedad.Activo = 1)" UpdateCommand="SP_Update_PropietariosVsPropiedades" UpdateCommandType="StoredProcedure">
                            <UpdateParameters>
                                <asp:Parameter Name="inNumeroFincaOriginal" Type="Int32" />
                                <asp:Parameter Name="inIdentificacionOriginal" Type="String" />
                                <asp:Parameter Name="inIdentificacionPJOriginal" Type="String" />
                                <asp:Parameter Name="inNumeroFincaNuevo" Type="Int32" />
                                <asp:Parameter Name="inIdentificacionNuevo" Type="String" />
                                <asp:Parameter Name="inIdentificacionPJNuevo" Type="String" />
                                <asp:Parameter Name="inEsJuridico" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
