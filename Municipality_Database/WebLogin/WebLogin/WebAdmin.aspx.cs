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

    }

    protected void btnPropietarios_Click(object sender, EventArgs e)
    {
        Response.Redirect("WebPropietarios.aspx");
    }

    protected void btnPropiedades_Click(object sender, EventArgs e)
    {
        Response.Redirect("WebPropiedades.aspx");
    }

    protected void btnPvsP_Click(object sender, EventArgs e)
    {
        Response.Redirect("WebPropiedadesDePropietario.aspx");
    }

    protected void btnUvsP_Click(object sender, EventArgs e)
    {
        Response.Redirect("WebUsuariosVsPropiedades.aspx");
    }

    protected void btnPvsCC_Click(object sender, EventArgs e)
    {
        Response.Redirect("WebPropiedadesVsConceptoCobro.aspx");
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("WebCRUDUsuario.aspx");
    }

    protected void Button1_Click1(object sender, EventArgs e)
    {
        Response.Redirect("WebBitácora.aspx");
    }

    protected void btnPagarAP_Click(object sender, EventArgs e)
    {
        Response.Redirect("WebAPUsuarios.aspx");
    }
}