using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebRecibosPagados : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            SqlDataSource1.SelectCommand = "SELECT  Usuario.Username, Propiedad.NumeroFinca, Recibo.FechaEmision, Recibo.FechaVencimiento, Recibo.Monto FROM Propiedad INNER JOIN Recibo ON Propiedad.Id = Recibo.PropiedadId INNER JOIN UsuarioDePropiedad INNER JOIN Usuario ON UsuarioDePropiedad.UsuarioId = Usuario.Id ON Propiedad.Id = UsuarioDePropiedad.PropiedadId WHERE (Recibo.Activo = 1) AND (Recibo.Estado=0) AND Usuario.Username LIKE '%" + Convert.ToString(Session["UsuarioSesion"]) + "%' ORDER BY Recibo.FechaEmision";
            SqlDataSource1.DataBind();
            listaPendientes.Visible = true;
        }
        catch
        {
            lblError.Text = "Los datos se ingresaron de forma erronea";
        }
    }
}