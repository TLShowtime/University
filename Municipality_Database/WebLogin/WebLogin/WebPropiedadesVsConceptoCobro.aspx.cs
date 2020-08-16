using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebPropiedadesVsConceptoCobro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        SqlCommand cmd = new SqlCommand("SP_Create_CCVSPropiedad", con1);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@inIdCobro", SqlDbType.Int).Value = int.Parse(txtIdCobroCrear.Text.ToString());
        cmd.Parameters.Add("@inNumFinca", SqlDbType.Int).Value = (int.Parse(txtNumeroCrear.Text));
        try
        {
            con1.Open();
            cmd.ExecuteNonQuery();
            lblError.Text = "Creado Exitosamente";
        }
        catch (Exception ex)
        {
            throw ex;

        }

        finally
        {
            con1.Close();
            con1.Dispose();
        }
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        SqlCommand cmd = new SqlCommand("SP_Delete_CCVSPropiedad", con1);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@inIdCobro", SqlDbType.Int).Value = int.Parse(txtIdCobroCrear.Text.ToString());
        cmd.Parameters.Add("@inNumFinca", SqlDbType.Int).Value = (int.Parse(txtNumeroCrear.Text));
        try
        {
            cmd.ExecuteNonQuery();
            con1.Close();
            lblError.Text = "Eliminado Exitosamente";
        }
        catch (Exception ex)
        {
            throw ex;

        }
        finally
        {
            con1.Close();
            con1.Dispose();
        }
    }

    protected void btnCambiar_Click(object sender, EventArgs e)
    {
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        con1.Open();
        SqlCommand cmd = new SqlCommand("SP_Update_CCVSPropiedad", con1);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@inNumFincaOriginal", SqlDbType.Int).Value = int.Parse(txtNumeroOCambiar.Text.ToString());
        cmd.Parameters.Add("@inNumFincaNuevo", SqlDbType.Int).Value = int.Parse(txtNumeroNCambiar.Text.ToString());
        cmd.Parameters.Add("@inIdCobroOriginal", SqlDbType.Int).Value = int.Parse(txtIdCobroOCambiar.Text.ToString());
        cmd.Parameters.Add("@inIdCobroNuevo", SqlDbType.Int).Value = int.Parse(txtIdCobroNCambiar.Text.ToString());

        cmd.ExecuteNonQuery();
        con1.Close();
        SqlDataSource1.DataBind();
    }
}