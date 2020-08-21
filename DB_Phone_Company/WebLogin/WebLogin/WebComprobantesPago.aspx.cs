using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebComprobantesPago : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            SqlDataSource1.SelectCommand = "SELECT DISTINCT  ComprobantePago.MedioPago, ComprobantePago.Id AS Numero, ComprobantePago.Fecha, ComprobantePago.TotalPagado,Propiedad.NumeroFinca FROM ConceptoCobro INNER JOIN Recibo ON ConceptoCobro.Id = Recibo.ConceptoCobroId INNER JOIN ComprobantePago ON Recibo.ComprobanteId = ComprobantePago.Id INNER JOIN Propiedad ON Recibo.PropiedadId = Propiedad.Id INNER JOIN UsuarioDePropiedad ON Propiedad.Id = UsuarioDePropiedad.PropiedadId INNER JOIN Usuario ON UsuarioDePropiedad.UsuarioId = Usuario.Id WHERE(ComprobantePago.Activo = 1) AND Usuario.Username LIKE '%" + Convert.ToString(Session["UsuarioSesion"]) + "%' ORDER BY ComprobantePago.Fecha DESC, Numero DESC";
            SqlDataSource1.DataBind();
            listaComprobantes.Visible = true;
        }
        catch
        {
            lblError.Text = "Los datos se ingresaron de forma erronea";
        }
    }


    protected void listaComprobantes_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["Comprobante"] = Convert.ToInt32(listaComprobantes.SelectedRow.Cells[1].Text);
        lblError.Text = Convert.ToString(Session["Comprobante"]);
        int numero = (int)Session["Comprobante"];
        Response.Redirect("PagadosPorComprobante.aspx");

    }
}