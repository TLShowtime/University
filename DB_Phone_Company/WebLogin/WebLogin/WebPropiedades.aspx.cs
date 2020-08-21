using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Propiedades : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("WebAdmin.aspx");
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        SqlCommand cmd = new SqlCommand("SP_Create_Propiedad", con1);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@inNumeroFinca", SqlDbType.Int).Value = (int.Parse(txtNumeroInsert.Text));
        cmd.Parameters.Add("@inValor", SqlDbType.Money).Value = Double.Parse(txtValorInsert.Text.ToString()).ToString("C");
        cmd.Parameters.Add("@inDireccion", SqlDbType.VarChar, 200).Value = txtDireccionInsert.Text.ToString();
        try
         {
            con1.Open();
            cmd.ExecuteNonQuery();
            lblError.Text = "Creado Exitosamente";
         }
         catch 
         {
            lblError.Text = "Dato Ingresado de forma incorrecta";

        }

         finally
         {
            con1.Close();
            con1.Dispose();
            SqlDataSource1.DataBind();
        }
     }

    protected void Button3_Click(object sender, EventArgs e)
    {
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        con1.Open();
        SqlCommand cmd = new SqlCommand("SP_Delete_Propiedad", con1);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@inNumeroFinca", SqlDbType.Int).Value = (int.Parse(txtNumeroEliminar.Text));
        try
         {
            cmd.ExecuteNonQuery();
            con1.Close();
            lblError.Text = "Eliminado Exitosamente";
         }
         catch 
         {
            lblError.Text = "Dato Ingresado de forma incorrecta";

        }
         finally
         {
            con1.Close();
            con1.Dispose();
            SqlDataSource1.DataBind();
        }
        }

    protected void btnCambiar_Click(object sender, EventArgs e)
    {
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        SqlCommand cmd = new SqlCommand("SP_Update_Propiedad", con1);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@inNumFincaOriginal", SqlDbType.Int).Value = int.Parse(txtNumCambiar.Text.ToString());
        cmd.Parameters.Add("@inNumeroFincaNuevo", SqlDbType.Int).Value = int.Parse(txtNuevoNumCambiar.Text.ToString());
        cmd.Parameters.Add("@inDireccion", SqlDbType.VarChar, 200).Value = txtDirCambiar.Text.ToString();
        cmd.Parameters.Add("@inValor", SqlDbType.Money).Value = Double.Parse(txtValorCambiar.Text.ToString()).ToString("C");
        try
        {
            con1.Open();
            cmd.ExecuteNonQuery();
        }
        catch {
            lblError.Text = "Los datos fueron ingresados de forma erronea";
        }
        finally
        {
            con1.Close();
            con1.Dispose();
            SqlDataSource1.DataBind();
        }
    }
}
