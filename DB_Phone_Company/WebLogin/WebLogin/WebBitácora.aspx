<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebBitácora.aspx.cs" Inherits="WebBitácora" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Bitácora</title>
    <style type="text/css">
        .auto-style1 {
            width: 232px;
        }
        .auto-style2 {
            width: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="width:100%;">
                <tr>
                    <td class="auto-style1">BITÁCORA DE CAMBIOS:</td>
                    <td colspan="2">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">Fecha Inicio:&nbsp;
                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    </td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">Fecha Final:&nbsp;&nbsp; <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                    </td>
                    <td colspan="2">Tipo de Entidad&nbsp;
                        <asp:DropDownList ID="DropDownList1" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td colspan="2">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                            <Columns>
                                <asp:BoundField DataField="jsonAntes" HeaderText="jsonAntes" SortExpression="jsonAntes" />
                                <asp:BoundField DataField="jsonDespues" HeaderText="jsonDespues" SortExpression="jsonDespues" />
                                <asp:BoundField DataField="insertedAt" HeaderText="insertedAt" SortExpression="insertedAt" />
                                <asp:BoundField DataField="insertedby" HeaderText="insertedby" SortExpression="insertedby" />
                                <asp:BoundField DataField="insertedIn" HeaderText="insertedIn" SortExpression="insertedIn" />
                                <asp:BoundField DataField="IdEntityType" HeaderText="IdEntityType" SortExpression="IdEntityType" />
                                <asp:BoundField DataField="EntityId" HeaderText="EntityId" SortExpression="EntityId" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=LAPTOP-RCGTG6D0;Initial Catalog=Tarea2;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [jsonAntes], [jsonDespues], [insertedAt], [insertedby], [insertedIn], [IdEntityType], [EntityId] FROM [Bitacora]"></asp:SqlDataSource>
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td colspan="2">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
