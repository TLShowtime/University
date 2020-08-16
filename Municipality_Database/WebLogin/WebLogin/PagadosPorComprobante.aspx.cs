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
        SqlDataSource1.SelectCommand = "SELECT Propiedad.NumeroFinca, Recibo.FechaEmision, Recibo.FechaVencimiento, Recibo.Monto, Recibo.Id,Recibo.ConceptoCobroId FROM Recibo INNER JOIN ComprobantePago ON Recibo.ComprobanteId = ComprobantePago.Id INNER JOIN Propiedad ON Recibo.PropiedadId = Propiedad.Id WHERE(Recibo.Activo = 1) AND(Recibo.Estado = 1) AND ComprobantePago.Id = " + Convert.ToString((int)Session["Comprobante"])+ "ORDER BY Recibo.FechaEmision";
        SqlDataSource1.DataBind();
    }
}