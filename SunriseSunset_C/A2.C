#include "conio.h"
#include <math.h> 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern calculateN(),calculateLngHour(), sunRisingT(), sunSettingT(),sunAnomaly(),sunTrueLong(),sunRightAscension(),sunDeclination(),localHourAngle(),sunRisingH(),sunSettingH(),localMeanTime(),toUTC(),toLocalTime();
extern masSig,menosSig,localT;
int day;
int month;
int year;
int sun_set_rise;
int determineZen;
float latitude;
float longitude;
float zenit;
unsigned int binaryNum[16];


// C program to convert 
// IEEE 754 floating point representaion 
// into real value 
typedef union { 
  
    float f; 
    struct
    { 
        // Order is important. 
        // Here the members of the union data structure 
        // use the same memory (32 bits). 
        // The ordering is taken 
        // from the LSB to the MSB. 
        unsigned int mantissa_2 : 11;
        unsigned int mantissa : 12; 
        unsigned int exponent : 8; 
        unsigned int sign : 1; 
  
    } raw; 
} myfloat; 

// Function to convert a binary array 
// to the corresponding integer 
unsigned int convertToInt(int* arr, int low, int high) 
{ 
    unsigned f = 0, i; 
    for (i = high; i >= low; i--) { 
        f = f + arr[i] * pow(2, high - i); 
    } 
    return f; 
}

void tellHour(float number){
    double hora,minutos;
    int horaNueva,minutosNuevos;
    minutos = modf((double)number, &hora)*60;
    horaNueva = (int)hora;
    minutosNuevos = (int)minutos;
    printf("Hora = %d:%d\n",horaNueva,minutosNuevos);
} 

// Driver Code 
void ieeeConverter(int *ieee){
  unsigned i;  
    myfloat var; 
    // Convert the least significant 
    // mantissa part (23 bits) 
    // to corresponding decimal integer 
    unsigned f = convertToInt(ieee, 21, 31); 
  
    // Assign integer representation of mantissa 
    var.raw.mantissa_2 = f; 
    f = convertToInt(ieee, 9, 20);
    var.raw.mantissa = f;

    // Convert the exponent part (8 bits) 
    // to a corresponding decimal integer 
    f = convertToInt(ieee, 1, 8); 
  
    // Assign integer representation 
    // of the exponent 
    var.raw.exponent = f; 
  
    // Assign sign bit 
    var.raw.sign = ieee[0]; 
  
    /**printf("The float value of the given"
           " IEEE-754 representation is : \n"); 
    printf("%f\n", var.f); */
    tellHour(var.f);
} 

void decToBinary (int n,int m) 
{ 
    // array to store binary number 
    unsigned int binaryNum[32];
  
    // counter for binary array 
    int i = 31,j; 

    while (m > 0 || i >=16) { 
  
        // storing remainder in binary array 
        binaryNum[i] = m % 2;  
        m = m / 2; 
        i--; 
    }

    while (n > 0 || i >=0) { 
  
        // storing remainder in binary array 
        binaryNum[i] = n % 2; 
        n = n / 2; 
        i--; 
    }  

    printf("\n");
    

    // printing binary array in reverse order
    /**for (j = 0; j <32; j++) 
        printf("%d",binaryNum[j]);
    
    printf("\n"); */
    ieeeConverter(binaryNum);
}


void determineZenit(int determine){

  switch (determine){
    case 1:
      // Offical
      zenit = 90.83333333333333;
      break;
    case 2:
      // Civil
      zenit = 96.0;
      break;
    case 3:
      zenit = 102.0;
      break;
    case 4:
      zenit = 108.0;
      break;
    default:
      zenit = 90.83333333333333;
      printf("Opción incorrecta. Se va a escoger el zenit como offical.\n");
  }


}

void determine_RiseOrSetLngHour(int determine){
  if (determine == 0)
  {
    printf("RisingT\n");
    sunRisingT();
  }else{
    printf("SettingT\n");
    sunSettingT();
  }
}

void determine_RiseOrSetConvertHour(int determine){
  if (determine == 0)
  {
    printf("RisingH\n");
    sunRisingH();
  }else{
    printf("SettingH\n");
    sunSettingH();
  }
}


int main()  {
  int a;

  printf("\nBienvenido al programa!!!\nVamos a calcular las puestas y salidas del Sol!\n");
  printf("Digite '0' para calcular la salida o '1' para calcular la puesta del Sol\n");
  scanf("%d",&sun_set_rise);
  printf("Digite un dia:\n");
  scanf("%d",&day);
  printf("Digite un mes:\n");
  scanf("%d",&month);
  printf("Digite un anno:\n");
  scanf("%d",&year);
  printf("Digite la latitud del punto:\n");
  scanf("%f",&latitude);
  printf("%f \n",latitude);
  printf("Digite la longitud del punto:\n");
  scanf("%f",&longitude);
  printf("%f \n",longitude);
  printf("Escoga el zenit que se quiera ver (1-4): \n 1. Offical\n 2. Civil\n 3. Nautical\n 4. Astronomical\n");
  scanf("%d",&determineZen);
  determineZenit(determineZen);
  calculateN(year,month,day); //calculo de N (primer punto del algoritmo)
  calculateLngHour(longitude,latitude); //conversion de la longitud a hora (segundo punto del algoritmo)
  determine_RiseOrSetLngHour(sun_set_rise);
  sunAnomaly();
  sunTrueLong();
  sunRightAscension();
  sunDeclination();
  a = localHourAngle();
  if (a == 0){
    determine_RiseOrSetConvertHour(sun_set_rise);
    printf("%d \n",sun_set_rise);
    localMeanTime();
    toUTC();
    toLocalTime();

    decToBinary(masSig,menosSig);
  } else {
    printf("the sun never rises on this location(on the specified date)");
  }

  getch();  //esperar enter
  return 0;
}