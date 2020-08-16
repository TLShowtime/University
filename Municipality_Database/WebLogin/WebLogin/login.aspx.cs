using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
       
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        con.Open();
        SqlCommand cmd = new SqlCommand("SP_VerificarUsuario",con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@inUsuario",txtUsuario.Text);
        cmd.Parameters.AddWithValue("@inContrasenna", txtContra.Text);
        cmd.Parameters.AddWithValue("@inTipo", "administrador");
        int result = (Int32)cmd.ExecuteScalar();

        if (result == 1)
        {
            lblLogin.Text = "Iniciando sesión...";
            Session["User"] = txtUsuario.Text;
            Response.Redirect("WebAdmin.aspx");
        }
        else if (result == 0)
        {
            lblLogin.Text = "Iniciando sesión...";
            Session["UsuarioSesion"] = txtUsuario.Text;
            Response.Redirect("WebUsuario.aspx");
        }
        else {
            lblLogin.Text = "Usuario no registrado";
        }
        con.Close();
    }
}