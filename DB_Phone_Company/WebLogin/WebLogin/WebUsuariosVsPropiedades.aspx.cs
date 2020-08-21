using System;
using System.Activities.Expressions;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebUsuariosVsPropiedades : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    
    protected void Button1_Click(object sender, EventArgs e)
    {
            SqlDataSource1.SelectCommand = "SELECT Usuario.Username, Propiedad.NumeroFinca, Propiedad.Direccion, Propiedad.Valor FROM Usuario INNER JOIN UsuarioDePropiedad ON Usuario.Id = UsuarioDePropiedad.UsuarioId INNER JOIN Propiedad ON UsuarioDePropiedad.PropiedadId = Propiedad.Id WHERE Usuario.Username LIKE '%" + nomUsuario.Text + "%'";
            SqlDataSource1.DataBind();
    }

    protected void GridViewUvsP_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        SqlCommand cmd = new SqlCommand("SP_Create_UsuarioVSPropiedad", con1);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@inUsuario", SqlDbType.VarChar, 200).Value = txtNombreCrear.Text.ToString();
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
            SqlDataSource1.DataBind();
        }
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        con1.Open();
        SqlCommand cmd = new SqlCommand("SP_Delete_UsuarioVSPropiedad", con1);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@inUsuario", SqlDbType.VarChar, 200).Value = txtNombreCrear.Text.ToString();
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
            SqlDataSource1.DataBind();
        }
    }

    protected void btnCambiar_Click(object sender, EventArgs e)
    {
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        con1.Open();
        SqlCommand cmd = new SqlCommand("SP_Update_UsuarioVSPropiedad", con1);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@inNumFincaOriginal", SqlDbType.Int).Value = int.Parse(txtNumeroOCambiar.Text.ToString());
        cmd.Parameters.Add("@inNumFincaNuevo", SqlDbType.Int).Value = int.Parse(txtNumeroNCambiar.Text.ToString());
        cmd.Parameters.Add("@inUsuarioOriginal", SqlDbType.VarChar, 200).Value = txtNombreOCambiar.Text.ToString();
        cmd.Parameters.Add("@inUsuarioNuevo", SqlDbType.VarChar, 200).Value = txtNombreNCambiar.Text.ToString();

        cmd.ExecuteNonQuery();
        con1.Close();
        SqlDataSource1.DataBind();
    }

    protected void btnBuscarFinca_Click(object sender, EventArgs e)
    {
        SqlDataSource1.SelectCommand = "SELECT Usuario.Username, Propiedad.NumeroFinca, Propiedad.Direccion, Propiedad.Valor FROM Usuario INNER JOIN UsuarioDePropiedad ON Usuario.Id = UsuarioDePropiedad.UsuarioId INNER JOIN Propiedad ON UsuarioDePropiedad.PropiedadId = Propiedad.Id WHERE Propiedad.NumeroFinca LIKE '%" + int.Parse(numPropiedad.Text.ToString()) + "%'";
        SqlDataSource1.DataBind();
    }
}
    