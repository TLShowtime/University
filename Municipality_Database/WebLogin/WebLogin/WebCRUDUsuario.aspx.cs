using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebCRUDUsuario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnCrear_Click(object sender, EventArgs e)
    {
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        SqlCommand cmd = new SqlCommand("SP_Create_Usuario", con1);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@inUsername", SqlDbType.VarChar, 100).Value = txtNomUsuarioCrear.Text.ToString();
        cmd.Parameters.Add("@inContrasenna", SqlDbType.VarChar, 100).Value = txtContrasennaCrear.Text.ToString();
        cmd.Parameters.Add("@inTipoUsuario", SqlDbType.VarChar, 30).Value = listaTipoUsuarioCrear.Text.ToString();
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
            SqlDataSource1.DataBind();
        }
    }

    protected void btnCambiar_Click(object sender, EventArgs e)
    {
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        SqlCommand cmd = new SqlCommand("SP_Update_Usuario", con1);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@inUsuarioOriginal", SqlDbType.VarChar, 100).Value = txtNombreUsuarioCambiar.Text.ToString();
        cmd.Parameters.Add("@inUsuarioNuevo", SqlDbType.VarChar, 100).Value = txtNuevoNombreCambiar.Text.ToString();
        cmd.Parameters.Add("@inContrasenna", SqlDbType.VarChar, 100).Value = txtContrasennaCambiar.Text.ToString();
        if (String.Equals("administrador",listaTipoUsuarioCambiar.Text))
        {
            cmd.Parameters.Add("@inTipoUsuario", SqlDbType.Int).Value = 1;
            try
            {
                con1.Open();
                cmd.ExecuteNonQuery();
                lblError.Text = "Actualizado Exitosamente";
            }
            catch 
            {
                lblError.Text = "Los datos se ingresaron de forma erronea";

            }

            finally
            {
                con1.Close();
                con1.Dispose();
                SqlDataSource1.DataBind();
            }
        }
        else
        {
            cmd.Parameters.Add("@inTipoUsuario", SqlDbType.Int).Value = 0;
            try
            {
                con1.Open();
                cmd.ExecuteNonQuery();
                lblError.Text = "Creado Exitosamente";
                
            }
            catch 
            {
                lblError.Text = "Los datos se ingresaron de forma erronea";

            }

            finally
            {
                con1.Close();
                con1.Dispose();
                SqlDataSource1.DataBind();
            }


        }
    }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
            con1.Open();
            SqlCommand cmd = new SqlCommand("SP_Delete_Usuario", con1);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@inUsername", SqlDbType.VarChar, 100).Value = txtNomUsuarioCrear.Text.ToString();
            try
            {
                cmd.ExecuteNonQuery();
                con1.Close();
                lblError.Text = "Eliminado Exitosamente";
                SqlDataSource1.DataBind();
        }
            catch 
            {
                lblError.Text = "Los datos se ingresaron de forma erronea";

            }
            finally
            {
                con1.Close();
                con1.Dispose();
            }
        }
    }

