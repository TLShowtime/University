using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebUsuario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void ListView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void btnRecibosPen_Click(object sender, EventArgs e)
    {
        Response.Redirect("WebRecibosPendientes.aspx");
    }

    protected void btnComprPago_Click(object sender, EventArgs e)
    {
        Response.Redirect("WebComprobantesPago.aspx");
    }

    protected void btnRecibosPag_Click(object sender, EventArgs e)
    {
        Response.Redirect("RecibosPagados.aspx");
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("WebPagoRecibos.aspx");
    }
}