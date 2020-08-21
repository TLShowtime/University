<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebPropiedadesVsConceptoCobro.aspx.cs" Inherits="WebPropiedadesVsConceptoCobro" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 317px;
        }
        .auto-style2 {
            width: 324px;
        }
        .auto-style23 {
            width: 242px;
            height: 23px;
        }
        .auto-style17 {
            width: 147px;
            height: 23px;
        }
        .auto-style18 {
            width: 433px;
            height: 23px;
        }
        .auto-style24 {
            width: 242px;
            height: 26px;
        }
        .auto-style5 {
            width: 147px;
            height: 26px;
        }
        .auto-style6 {
            width: 433px;
            height: 26px;
        }
        .auto-style26 {
            width: 242px;
            height: 50px;
        }
        .auto-style3 {
            width: 433px;
            height: 50px;
        }
        .auto-style25 {
            width: 242px;
            height: 30px;
        }
        .auto-style15 {
            width: 181px;
            height: 30px;
        }
        .auto-style31 {
            width: 108px;
            height: 30px;
        }
        .auto-style10 {
            width: 433px;
            height: 30px;
        }
        .auto-style27 {
            width: 242px;
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
        .auto-style35 {
            width: 131%;
        }
        .auto-style36 {
            width: 100%;
        }
        .auto-style38 {
            width: 82px;
        }
        .auto-style39 {
            width: 731px;
        }
        .auto-style40 {
            width: 324px;
            height: 50px;
        }
        .auto-style41 {
            width: 655px;
        }
        .auto-style42 {
            width: 108px;
            height: 34px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="border-style: groove; font-family: 'Gloucester MT Extra Condensed'; font-size: large; font-weight: 500; color: #FFFFFF; background-image: url('ruinasFondoPaginas.jpg'); width: auto; height: 960px;">
            Propiedad vs CC:<table class="auto-style36">
                <tr>
                    <td class="auto-style1" colspan="2">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td class="auto-style38">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style41">
        <table class="auto-style35">
            <tr>
                <td class="auto-style23">Crear Nueva Relación:</td>
                <td class="auto-style17" colspan="2"></td>
                <td class="auto-style18">Cambiar Datos:</td>
            </tr>
            <tr>
                <td class="auto-style24">&nbsp;</td>
                <td class="auto-style5" colspan="2">
                    &nbsp;</td>
                <td class="auto-style6">Ingrese el Id del Concepto Cobro que desea cambiar</td>
            </tr>
            <tr>
                <td class="auto-style24">Ingrese el Id del cobro:</td>
                <td class="auto-style5" colspan="2">
                    <asp:TextBox ID="txtIdCobroCrear" runat="server" Width="197px"></asp:TextBox>
                </td>
                <td class="auto-style6">
                    <asp:TextBox ID="txtIdCobroOCambiar" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style26">Ingrese el Número de propiedad:</td>
                <td class="auto-style40" colspan="2">
                    <asp:TextBox ID="txtNumeroCrear" runat="server" Width="195px">0</asp:TextBox>
                </td>
                <td class="auto-style3">Ingrese el nuevo Id del Concepto Cobro que desea cambiar&nbsp;&nbsp;
                    <asp:TextBox ID="txtIdCobroNCambiar" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
            </tr>
            <tr>
                <td class="auto-style25"></td>
                <td class="auto-style15">
                    <asp:Button ID="btnCrear" runat="server" OnClick="Button3_Click" Text="Crear" Width="73px" />
                </td>
                <td class="auto-style31">
                    <asp:Button ID="btnEliminar" runat="server" BackColor="#CCFF99" Font-Bold="True" Font-Names="Constantia" OnClick="btnEliminar_Click" Text="Eliminar" />
                </td>
                <td class="auto-style10">Ingrese el numero de finca que desea cambiar:&nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="txtNumeroOCambiar" runat="server">0</asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style25">
                    <asp:Label ID="lblError" runat="server"></asp:Label>
                </td>
                <td class="auto-style15">
                </td>
                <td class="auto-style31">
                </td>
                <td class="auto-style10">Ingrese el nuevo número de finca:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="txtNumeroNCambiar" runat="server">0</asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style27">&nbsp;</td>
                <td class="auto-style28">
                    &nbsp;</td>
                <td class="auto-style42">
                    &nbsp;</td>
                <td class="auto-style29">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnCambiar" runat="server" BackColor="#FFFF99" OnClick="btnCambiar_Click" Text="Aceptar" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
            </tr>
                </table>
                    </td>
                    <td class="auto-style39">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td class="auto-style38">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1" colspan="2">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowPaging="True" BackColor="#666666" BorderColor="White" ForeColor="White" Width="1508px">
                            <Columns>
                                <asp:BoundField DataField="PropiedadId" HeaderText="PropiedadId" SortExpression="PropiedadId" />
                                <asp:BoundField DataField="ConceptoCobroId" HeaderText="ConceptoCobroId" SortExpression="ConceptoCobroId" />
                                <asp:BoundField DataField="NumeroFinca" HeaderText="NumeroFinca" SortExpression="NumeroFinca" />
                                <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" />
                                <asp:BoundField DataField="Direccion" HeaderText="Direccion" SortExpression="Direccion" />
                                <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                                <asp:BoundField DataField="DiasDelMes" HeaderText="DiasDelMes" SortExpression="DiasDelMes" />
                                <asp:BoundField DataField="QDiasVencen" HeaderText="QDiasVencen" SortExpression="QDiasVencen" />
                                <asp:BoundField DataField="TasaIntMor" HeaderText="TasaIntMor" SortExpression="TasaIntMor" />
                                <asp:BoundField DataField="EsImpuesto" HeaderText="EsImpuesto" SortExpression="EsImpuesto" />
                                <asp:BoundField DataField="EsRecurrente" HeaderText="EsRecurrente" SortExpression="EsRecurrente" />
                                <asp:BoundField DataField="EsFijo" HeaderText="EsFijo" SortExpression="EsFijo" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=LAPTOP-RCGTG6D0;Initial Catalog=Tarea2;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT CCenPropiedad.PropiedadId, CCenPropiedad.ConceptoCobroId, Propiedad.NumeroFinca, Propiedad.Valor, Propiedad.Direccion, ConceptoCobro.Nombre, ConceptoCobro.DiasDelMes, ConceptoCobro.QDiasVencen, ConceptoCobro.TasaIntMor, ConceptoCobro.EsImpuesto, ConceptoCobro.EsRecurrente, ConceptoCobro.EsFijo FROM CCenPropiedad INNER JOIN Propiedad ON CCenPropiedad.PropiedadId = Propiedad.Id INNER JOIN ConceptoCobro ON CCenPropiedad.ConceptoCobroId = ConceptoCobro.Id WHERE (CCenPropiedad.Activo = 1)"></asp:SqlDataSource>
                    </td>
                    <td class="auto-style2">&nbsp;</td>
                    <td class="auto-style38">&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
