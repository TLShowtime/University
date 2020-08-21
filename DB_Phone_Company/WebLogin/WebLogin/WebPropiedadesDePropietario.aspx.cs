using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebPropiedadesDePropietario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnCrear_Click(object sender, EventArgs e)
    {
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        SqlCommand cmd = new SqlCommand("SP_Create_PropietariosVsPropiedades", con1);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@inNumeroFinca", SqlDbType.Int).Value = (int.Parse(txtNumFincaCrear.Text));
        if (listJuridico.Text.CompareTo("Jurídico") == 0)
        {
            cmd.Parameters.Add("@inIdentificacionPJ", SqlDbType.Int).Value = (int.Parse(txtIdentPropieCrear.Text));
            cmd.Parameters.Add("@inIdentificacion", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@inEsJuridico", SqlDbType.Int).Value = 1;
            try
            {
                con1.Open();
                cmd.ExecuteNonQuery();
            }
            catch
            {
                lblError.Text = "Los datos fueron ingresados de forma erronea";
            }
            finally
            {
                con1.Close();
                con1.Dispose();
                SqlDataSource1.DataBind();
            }
        }
        else if (listJuridico.Text.CompareTo("No Jurídico") == 0)
        {
            cmd.Parameters.Add("@inIdentificacion", SqlDbType.Int).Value = (int.Parse(txtIdentPropieCrear.Text));
            cmd.Parameters.Add("@inIdentificacionPJ", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@inEsJuridico", SqlDbType.Int).Value = 0;
            try
            {
                con1.Open();
                cmd.ExecuteNonQuery();
            }
            catch
            {
                lblError.Text = "Los datos fueron ingresados de forma erronea";
            }
            finally
            {
                con1.Close();
                con1.Dispose();
                SqlDataSource1.DataBind();
            }


        }
        else {
            lblError.Text = "No ingresó es estado jurídico del propietario";
        }
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {

        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        SqlCommand cmd = new SqlCommand("SP_Delete_PropietariosVsPropiedades", con1);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@inNumeroFinca", SqlDbType.Int).Value = (int.Parse(txtNumFincaCrear.Text));
        if (listJuridico.Text.CompareTo("Jurídico") == 0)
        {
            cmd.Parameters.Add("@inIdentificacionPJ", SqlDbType.Int).Value = (int.Parse(txtIdentPropieCrear.Text));
            cmd.Parameters.Add("@inEsJuridico", SqlDbType.Int).Value = 1;
            cmd.Parameters.Add("@inIdentificacion", SqlDbType.Int).Value = 0;
            try
            {
                con1.Open();
                cmd.ExecuteNonQuery();
            }
            catch
            {
                lblError.Text = "Los datos fueron ingresados de forma erronea";
            }
            finally
            {
                con1.Close();
                con1.Dispose();
                SqlDataSource1.DataBind();
            }
        }
        else if (listJuridico.Text.CompareTo("No Jurídico") == 0)
        {
            cmd.Parameters.Add("@inIdentificacion", SqlDbType.Int).Value = (int.Parse(txtIdentPropieCrear.Text));
            cmd.Parameters.Add("@inEsJuridico", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@inIdentificacionPJ", SqlDbType.Int).Value = 0;
            try
            {
                con1.Open();
                cmd.ExecuteNonQuery();
            }
            catch
            {
                lblError.Text = "Los datos fueron ingresados de forma erronea";
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
            lblError.Text = "No ingresó es estado jurídico del propietario";
        }
    }

    protected void btnCambiar_Click(object sender, EventArgs e)
    {
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ToString());
        SqlCommand cmd = new SqlCommand("SP_Update_PropietariosVsPropiedades", con1);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@inNumeroFincaOriginal", SqlDbType.Int).Value = int.Parse(txtNumFincaO.Text.ToString());
        cmd.Parameters.Add("@inNumeroFincaNuevo", SqlDbType.Int).Value = int.Parse(txtNumFincaN.Text.ToString());
        if (listJuridico1.Text.CompareTo("Jurídico") == 0)
        {
            cmd.Parameters.Add("@inIdentificacionPJOriginal", SqlDbType.Int).Value = int.Parse(txtIdentPropieO.Text.ToString());
            cmd.Parameters.Add("@inIdentificacionPJNuevo", SqlDbType.Int).Value = int.Parse(txtIdentPropieN.Text.ToString());
            cmd.Parameters.Add("@inIdentificacionOriginal", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@inIdentificacionNuevo", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@inEsJuridico", SqlDbType.Int).Value = 1;
            try
            {
                con1.Open();
                cmd.ExecuteNonQuery();
            }
            catch
            {
                lblError.Text = "Los datos fueron ingresados de forma erronea";
            }
            finally
            {
                con1.Close();
                con1.Dispose();
                SqlDataSource1.DataBind();
            }
        }
        else if (listJuridico1.Text.CompareTo("No Jurídico") == 0)
        {
            cmd.Parameters.Add("@inIdentificacionOriginal", SqlDbType.Int).Value = int.Parse(txtIdentPropieO.Text.ToString());
            cmd.Parameters.Add("@inIdentificacionNuevo", SqlDbType.Int).Value = int.Parse(txtIdentPropieN.Text.ToString());
            cmd.Parameters.Add("@inIdentificacionPJOriginal", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@inIdentificacionPJNuevo", SqlDbType.Int).Value = 0;
            cmd.Parameters.Add("@inEsJuridico", SqlDbType.Int).Value = 0;
            try
            {
                con1.Open();
                cmd.ExecuteNonQuery();
            }
            catch
            {
                lblError.Text = "Los datos fueron ingresados de forma erronea";
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
            lblError0.Text = "No ingresó es estado jurídico del propietario";
        }
        SqlDataSource1.DataBind();
    }

    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        SqlDataSource1.SelectCommand = "SELECT Propietario.Nombre, Propietario.Identificacion, Propiedad.NumeroFinca, Propiedad.Direccion, Propiedad.Valor, PropietarioDePropiedad.FechaInicio, PropietarioDePropiedad.FechaFinal FROM PropietarioDePropiedad INNER JOIN Propietario ON PropietarioDePropiedad.PropietarioId = Propietario.Id INNER JOIN Propiedad ON PropietarioDePropiedad.PropiedadId = Propiedad.Id WHERE (PropietarioDePropiedad.Activo = 1)  AND Propietario.Identificacion LIKE '%" + int.Parse(txtIDPropietario.Text.ToString()) + "%'";
        SqlDataSource1.DataBind();
    }

    protected void btnBuscar2_Click(object sender, EventArgs e)
    {
        SqlDataSource1.SelectCommand = "SELECT Propietario.Nombre, Propietario.Identificacion, Propiedad.NumeroFinca, Propiedad.Direccion, Propiedad.Valor, PropietarioDePropiedad.FechaInicio, PropietarioDePropiedad.FechaFinal FROM PropietarioDePropiedad INNER JOIN Propietario ON PropietarioDePropiedad.PropietarioId = Propietario.Id INNER JOIN Propiedad ON PropietarioDePropiedad.PropiedadId = Propiedad.Id WHERE (PropietarioDePropiedad.Activo = 1) AND Propiedad.NumeroFinca LIKE '%" + int.Parse(txtNumFincaBuscar.Text.ToString()) + "%'";
        SqlDataSource1.DataBind();
    }

    protected void btnBuscar3_Click(object sender, EventArgs e)
    {
        SqlDataSource1.SelectCommand = "SELECT Propietario.Nombre, Propietario.Identificacion, Propiedad.NumeroFinca, Propiedad.Direccion, Propiedad.Valor, PropietarioDePropiedad.FechaInicio, PropietarioDePropiedad.FechaFinal FROM PropietarioDePropiedad INNER JOIN Propietario ON PropietarioDePropiedad.PropietarioId = Propietario.Id INNER JOIN Propiedad ON PropietarioDePropiedad.PropiedadId = Propiedad.Id WHERE (PropietarioDePropiedad.Activo = 1) AND Propietario.Nombre LIKE '%" + txtNombreBuscar.Text + "%'";
        SqlDataSource1.DataBind();
    }
}
