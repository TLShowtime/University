--Verificar usuario
CREATE PROCEDURE SP_VerificarUsuario (@inUsuario varchar(100),@inContrasenna varchar(100),@outEncontrado int OUTPUT)
AS
BEGIN
	SET NOCOUNT ON;
	Begin try

		if @inUsuario is NULL OR @inContrasenna is NULL
			Return -50001

		DECLARE @IdUsuario int
		
		Select @IdUsuario = U.Id 
		FROM dbo.Usuario U
		WHERE U.Username = @inUsuario AND U.Contrasenna = @inContrasenna
	
		IF @IdUsuario IS NULL
		BEGIN
				Set @outEncontrado = -1
		END

		ELSE
		BEGIN
			SET @outEncontrado = @IdUsuario
		END
		return 1
	End try
	Begin Catch
		RETURN @@ERROR* -1
	End Catch
END;

SELECT * FROM DBO.Usuario;

--DROP PROC SP_VerificarUsuario
/*
DECLARE @Encontrado int = 0

EXEC SP_VerificarUsuario 'EMadrigal','bgNH1',@Encontrado

PRINT (@Encontrado)
*/
