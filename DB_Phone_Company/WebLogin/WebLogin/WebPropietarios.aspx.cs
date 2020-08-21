using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebPropietarios : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    
    }
    protected void btnCambiar_Click(object sender, EventArgs e)
    {
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        SqlCommand cmd = new SqlCommand("SP_Update_Propietario", con1);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@inNombre", SqlDbType.VarChar, 100).Value = txtNombreCambiar.Text.ToString();
        if (listaJuridicoCambiar.Text.CompareTo("Jurídico") == 0) {
            cmd.Parameters.Add("@inIdentificacion", SqlDbType.VarChar, 30).Value = 0;
            cmd.Parameters.Add("@inIdentificacionPersonaJ", SqlDbType.VarChar, 30).Value = txtNuevoIDCambiar.Text.ToString();
            cmd.Parameters.Add("@inIdentificacionPJOriginal", SqlDbType.VarChar, 30).Value = txtIDCambiar.Text.ToString();
            cmd.Parameters.Add("@inEsJuridico", SqlDbType.Int).Value = 1;
            cmd.Parameters.Add("@inIdentificacionOriginal", SqlDbType.VarChar, 30).Value = 0;
            cmd.Parameters.Add("@inValorTipoIdPersonaJ", SqlDbType.Int).Value = int.Parse(txtValorTDid.Text.ToString());
            cmd.Parameters.Add("@inValorTipoId", SqlDbType.Int).Value = 0;
            cmd.ExecuteNonQuery();
            con1.Close();
            con1.Dispose();
            SqlDataSource1.DataBind();
        }
        else if (listaJuridicoCambiar.Text.CompareTo("Jurídico") !=0)
        {
            cmd.Parameters.Add("@inIdentificacionPersonaJ", SqlDbType.VarChar, 30).Value = 0;
            cmd.Parameters.Add("@inIdentificacion", SqlDbType.VarChar, 30).Value = txtNuevoIDCambiar.Text.ToString();
            cmd.Parameters.Add("@inIdentificacionOriginal", SqlDbType.VarChar, 30).Value = txtIDCambiar.Text.ToString();
            cmd.Parameters.Add("@inEsJuridico", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@inIdentificacionPJOriginal", SqlDbType.VarChar, 30).Value = 0;
            cmd.Parameters.Add("@inValorTipoId", SqlDbType.Int).Value = int.Parse(txtValorTDid.Text.ToString());
            cmd.Parameters.Add("@inValorTipoIdPersonaJ", SqlDbType.Int).Value = 0;
            cmd.ExecuteNonQuery();
            con1.Close();
            con1.Dispose();
            SqlDataSource1.DataBind();
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        SqlCommand cmd = new SqlCommand("SP_Create_Propietario", con1);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@inNombre", SqlDbType.VarChar, 100).Value = txtNombreInsert.Text.ToString();
        cmd.Parameters.Add("@inIdentificacion", SqlDbType.VarChar, 30).Value = txtIdentificacionInsert.Text.ToString();
        cmd.Parameters.Add("@inValorTipoId", SqlDbType.Int).Value = (int.Parse(txtValorTipoIdInsert.Text));
        cmd.Parameters.Add("@inValorTipoIdPersonaJ", SqlDbType.Int).Value = (int.Parse(txtValorTipoIdInsert.Text));
        cmd.Parameters.Add("@inIdentificacionPersonaJ", SqlDbType.VarChar, 30).Value = txtIdentificacionInsert.Text.ToString();
        if (String.Equals("Juridico", listJuridico.Text))
        {
            cmd.Parameters.Add("@inEsJuridico", SqlDbType.Int).Value = 1;
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
        else if (String.Equals("No Juridico", listJuridico.Text))
        {
            cmd.Parameters.Add("@inEsJuridico", SqlDbType.Int).Value = 0;
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
        else
        {
            lblError.Text = "Falta ingresar algún dato";
        }
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        con1.Open();
        SqlCommand cmd = new SqlCommand("SP_Delete_Propietario", con1);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@inIdentificacion", SqlDbType.VarChar, 30).Value = txtIdentificacionInsert.Text.ToString();
        cmd.Parameters.Add("@inIdentificacionPersonaJ", SqlDbType.VarChar, 30).Value = txtIdentificacionInsert.Text.ToString();
        if (String.Equals("Juridico", listJuridico.Text))
        {
            cmd.Parameters.Add("@inEsJuridico", SqlDbType.Int).Value = 1;
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
                SqlDataSource1.DataBind();
            }
        }
        else if (String.Equals("No Juridico", listJuridico.Text))
        {
            cmd.Parameters.Add("@inEsJuridico", SqlDbType.Int).Value = 0;
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
                SqlDataSource1.DataBind();
            }
        }
        else
        {
            lblError.Text = "Falta ingresar algún dato";
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }
}
