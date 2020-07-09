#include <ESP8266WiFi.h>              //Including the ESP8266 WiFi library in order to usm them
#include <ESP8266HTTPClient.h>
#include <ArduinoJson.h>
#include <Wire.h>

//FOR SOIL MOISTURE
int soil_pin = D0; // Soil Sensor input at PIN D0
int soil_value = 0;

//FOR DHT11
#include <Adafruit_Sensor.h>           //In order to use DHT sensor we have to include this library first 
#include <DHT.h>                      //Including the DHT library 

char dstmp[20], btmp[20], bprs[20], balt[20];
bool bmp085_present = true;
#define DHTPIN 2                                    //Connect the DHT11 sensor's data pin to GPIO2(D4) of Nodemcu    
#define DHTTYPE DHT11                               //Mention the type of sensor we are using, Here it it DHT11, for DHT22 just replace DHT11 with DHT22
float temp = 0.000 ;
float humidity = 0.000 ;
DHT dht(DHTPIN, DHTTYPE); //Defining the pin and the dhttype

//FOR BMP180
//For using I2C connection of BMP180 in order to connect it to the board
#include <Adafruit_BMP085.h>          //Including the library for BMP180
Adafruit_BMP085 bmp;                  //Defining the object bmp
#define I2C_SCL 12                    //Connect SCL pin of BMP180 to GPIO12(D6) of Nodemcu
#define I2C_SDA 13                    //Connect SDA pin of BMP180 to GPIO13(D7) of Nodemcu
float pressure = 0.000;

//FOR RAIN SENSOR
int rain_sensor = A0;
int rain_sensor_value = 0; //variable to store RainDrop Sensor Module's output value

//________________________Mention the SSID and Password____________________________________________________
const char* ssid = "shresthas_wlink";//SSID of the WiFi hotspot available
const char* password = "alumanchor"; //Password of the WiFi

void setup() {
  Serial.begin(9600);
  //Connecting nodemcu with wifi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(1000);
    Serial.println("Connecting...");
  }

  //starting DTH & BMP 180
  dht.begin();  //Initializing the DHT sensor
  Wire.begin(I2C_SDA, I2C_SCL); //Initializing the I2C connection BMP180

}

//MAIN
void loop() {
  //FOR SOIL MOISTURE
  startReadingSoilMoisture();
  startReadingDHT();
  startReadingRainSensor();
  startReadingBMPSensor();
   Serial.println("Sending data to cloud....... ");
//  apiCall();
}



//FOR SOIL MOISTURE
void startReadingSoilMoisture() {
  Serial.println("Started Reading SoilMoisture : ");
  soil_value = analogRead(soil_pin); //Takes reading from soil moisture sensor
  Serial.print("MOISTURE LEVEL : ");
  Serial.println(soil_value);
}

//FOR DHT
void startReadingDHT() {
  //______________________Getting the Humidity and temperature value from DHT11____________________________
  Serial.println("Started Reading Humidity : ");
  humidity = dht.readHumidity();
  Serial.print("Humidity : ");
  Serial.println(humidity);
  Serial.println("Started Reading Temperature : ");
  temp = dht.readTemperature(); // or dht.readTemperature(true) for Fahrenheit
  Serial.print("Temperature : ");
  Serial.println(temp);
}

//FOR RAINSENSOR
void startReadingRainSensor() {
  //_____________________________________Checking for Rain______________________________________________________
  Serial.println("Started RAINSENSOR : ");
  rain_sensor_value = analogRead(rain_sensor);
  Serial.print("RAINSENSOR : ");
  Serial.println(rain_sensor_value);
  rain_sensor_value = constrain(rain_sensor, 150, 440);
  rain_sensor_value = map(rain_sensor, 150, 440, 1023, 0);

}

//FOR BMP180 Sensor
void startReadingBMPSensor()
{
  Serial.println("Started Reading Pressure : ");
  if (bmp.begin())
  {
    //BMP180 is working
    //______________________Reading the value of Pressure from the BMP180__________________
    pressure =  bmp.readPressure() / 100; // Division by 100 makes it in millibars
    Serial.print("Pressure : ");
    Serial.println(pressure);
  }
}



//SENDING DATA TO SERVER THROUGHT API CALL
void apiCall() {
  String deviceKey = "123456";

  String postbody = "";
  postbody += "{\"device_key\":";
  postbody += deviceKey;
  postbody += ",\"temperature\":";
  postbody += temp;
  postbody += ",\"pressure\":";
  postbody += pressure;
  postbody += ",\"rain\":";
  postbody += rain_sensor_value;
  postbody += ",\"humidity\":";
  postbody += humidity;
  postbody += ",\"soil_moisture\":";
  postbody += soil_value;
  postbody += "}";

  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http; //Object of class HTTPClient

    http.begin("http://localhost:3000/api/update-stats");
    http.addHeader("Content-Type", "application/json");
    int httpCode = http.POST(postbody);
    if (httpCode > 0) {

    }
    http.end(); //Close connection
  }
  delay(10000); //10sec delay
}
