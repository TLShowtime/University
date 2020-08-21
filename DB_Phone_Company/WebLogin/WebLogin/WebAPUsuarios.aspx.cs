using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        SqlDataSource1.SelectCommand = "SELECT Usuario.Username, Propiedad.NumeroFinca, Propiedad.Direccion, Propiedad.Valor FROM Usuario INNER JOIN UsuarioDePropiedad ON Usuario.Id = UsuarioDePropiedad.UsuarioId INNER JOIN Propiedad ON UsuarioDePropiedad.PropiedadId = Propiedad.Id WHERE(UsuarioDePropiedad.Activo = 1) AND Usuario.Username  LIKE '%" + txtUsuarioNombre.Text + "%'";
        SqlDataSource1.DataBind();
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (listaFincas.Rows.Count != 0)
        {
            Session["NumPropiedad"] = Convert.ToInt32(listaFincas.SelectedRow.Cells[2].Text);
            SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());

            SqlCommand cmd = new SqlCommand("SP_Crear_AP_Web", con1);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@inNumFinca", SqlDbType.Int);
            cmd.Parameters.Add("@outMonto", SqlDbType.Decimal).Direction = ParameterDirection.Output;

            cmd.Parameters["@inNumFinca"].Value = Convert.ToInt32(Session["NumPropiedad"]);

            con1.Open();
            cmd.ExecuteNonQuery();
            Session["PagoTotal"] = cmd.Parameters["@outMonto"].Value;
            con1.Close();
            Response.Redirect("WebAP.aspx");
        
        }
        Label1.Text = "Usted no tiene recibos pendientes";

    }
}