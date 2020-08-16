using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlDataSource1.SelectCommand = "SELECT Usuario.Username, Propiedad.NumeroFinca, Propiedad.Direccion, Propiedad.Valor FROM Usuario INNER JOIN UsuarioDePropiedad ON Usuario.Id = UsuarioDePropiedad.UsuarioId INNER JOIN Propiedad ON UsuarioDePropiedad.PropiedadId = Propiedad.Id WHERE Usuario.Username LIKE '%" + Convert.ToString(Session["UsuarioSesion"]) + "%'";
        SqlDataSource1.DataBind();
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        int numeroFinca= Convert.ToInt32(GridView1.SelectedRow.Cells[2].Text);
        Session["NumPropiedad"] = numeroFinca;
        Response.Redirect("PagarRecibos.aspx");
    }
}