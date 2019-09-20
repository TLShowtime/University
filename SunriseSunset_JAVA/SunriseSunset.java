import javax.swing.JOptionPane;
import java.util.ArrayList;

public class SunriseSunset {
	public native int calcularHora(int pDay,int pMonth,int pYear,double latitude,double longitude);
	
	// Convert the 32-bit binary into the decimal  
    	private static float GetFloat32( String Binary )  
    	{  
        	int intBits = Integer.parseInt(Binary, 2);
        	float myFloat = Float.intBitsToFloat(intBits);
        	return myFloat;  
    	} 
     
    	// Get 32-bit IEEE 754 format of the decimal value  
    	private static String GetBinary32( float value )  
    	{  
        	int intBits = Float.floatToIntBits(value); 
        	String binary = Integer.toBinaryString(intBits);
        	return binary;
    	} 

	public static void infoBox(String infoMessage, String titleBar){
        
		JOptionPane.showMessageDialog(null, infoMessage, "Resultados: " + titleBar, JOptionPane.INFORMATION_MESSAGE);
	}
	static {
		System.loadLibrary("SunriseSunsetImpl");
	}
	public static void main(String[] args) {
		SunriseSunset op = new SunriseSunset();

		int nResult = op.calcularHora(25,6,2019,9.86444,-83.9194412);

		String nResString = Integer.toBinaryString(nResult);
		float nResultado = GetFloat32(nResString);

		
		String finalResult=  "\nResultado = " + nResultado;
		System.out.println(finalResult);
		
	}
}