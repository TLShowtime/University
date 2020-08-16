using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PagarRecibos : System.Web.UI.Page
{
    List<int> recibos = new List<int>();
    List<int> recibosSelect = new List<int>();
    int mayor = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlDataSource1.SelectCommand = "SELECT  Recibo.Id, Usuario.Username, Propiedad.NumeroFinca, Recibo.FechaEmision, Recibo.FechaVencimiento, Recibo.Monto FROM Propiedad INNER JOIN Recibo ON Propiedad.Id = Recibo.PropiedadId INNER JOIN UsuarioDePropiedad INNER JOIN Usuario ON UsuarioDePropiedad.UsuarioId = Usuario.Id ON Propiedad.Id = UsuarioDePropiedad.PropiedadId WHERE (Recibo.Activo = 1) AND (Recibo.Estado=0) AND Usuario.Username LIKE '%" + Convert.ToString(Session["UsuarioSesion"]) + "%' AND Propiedad.NumeroFinca = " + Convert.ToString((int)Session["NumPropiedad"]) + " ORDER BY Recibo.FechaEmision";
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            int numero = Convert.ToInt32(GridView1.Rows[i].Cells[1].Text);
            recibos.Add(numero);
            Label1.Text = recibos.Count.ToString();
        }
    }
    protected void GridView1_SelectedIndexChanged1(object sender, EventArgs e)
    {
        mayor = Convert.ToInt32(GridView1.SelectedRow.Cells[1].Text);
        int reciboIM = Convert.ToInt32(GridView1.Rows[GridView1.Rows.Count-1].Cells[1].Text);
        Session["ReciboGuia"] = mayor;
        Session["ReciboIM"] = reciboIM;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count!=0) {
            SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());

            SqlCommand cmd = new SqlCommand("SP_Pago_Seleccion_Web", con1);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@inNumFinca", SqlDbType.Int);
            cmd.Parameters.Add("@inIdReciboMayor", SqlDbType.Int);
            cmd.Parameters.Add("@outMontoAPagar", SqlDbType.Decimal).Direction = ParameterDirection.Output;

            // Setea valores
            cmd.Parameters["@inNumFinca"].Value = Convert.ToInt32(Session["NumPropiedad"]);
            cmd.Parameters["@inIdReciboMayor"].Value = Convert.ToInt32(Session["ReciboGuia"]);

            SqlParameter returnParameter = cmd.Parameters.Add("RetVal", SqlDbType.Int);
            returnParameter.Direction = ParameterDirection.ReturnValue;
            con1.Open();
            cmd.ExecuteNonQuery();
            Session["PagoTotal"]= cmd.Parameters["@outMontoAPagar"].Value;
            con1.Close();
            Response.Redirect("PagoFinal.aspx");
        }
        Label1.Text = "Usted no tiene recibos pendientes";
    }


    protected void btnCancelar_Click(object sender, EventArgs e)
    {
        Response.Redirect("WebUsuario.aspx");
    }
}
