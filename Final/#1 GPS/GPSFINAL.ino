#include "WiFiEsp.h"
#include <SoftwareSerial.h>
#include <TinyGPS.h>

#define BSIZE 100

char Lat[BSIZE];
char Long[BSIZE];
char SPEED[BSIZE];
char COURSE[BSIZE];

char SBuf[BSIZE];

float latitude, longitude;

int year;
byte month, day, hour, minute, second, hundredths;


TinyGPS gps;
void getgps(TinyGPS &gps);

float course, speed;

char ssid[] = "KT_GiGA_C524";
char pass[] = "5ea63fe885";
int status = WL_IDLE_STATUS;

char server[] = "sc1.swu.ac.kr";

unsigned long lastConnectionTime = 0;
const unsigned long postingInterval = 10000L;

WiFiEspClient client;

void setup(){
  Serial.begin(115200);
  Serial1.begin(115200);
  Serial2.begin(9600);

  WiFi.init(&Serial1);

  Serial.println("");
  Serial.println("GPS Shield QuickStart Example Sketch v12");
  Serial.println("... waiting for lock...");
  Serial.println("");

  if(WiFi.status() == WL_NO_SHIELD) {
    Serial.println("WiFi shield not present");
    while (true);
  }

  while (status != WL_CONNECTED){
    Serial.print("Attempting to connect to WPA SSID: ");
    Serial.println(ssid);
    status = WiFi.begin(ssid, pass);
  }

  Serial.println("You're connected to the network");

  printWifiStatus();
}

void loop(){
  
  while (client.available()) {
    char c = client.read();
    Serial.write(c);
  }
  
  while(Serial2.available())
  {
    int c = Serial2.read();
    if(gps.encode(c))
    {
      getgps(gps);
    }
  }

  if (millis() - lastConnectionTime > postingInterval) {
    httpRequest();
  }
}

void getgps(TinyGPS &gps)
{

  gps.f_get_position(&latitude, &longitude);

  Serial.print("Lat/Long: ");
  Serial.print(latitude, 5);
  Serial.print(", ");
  Serial.print(longitude, 5);
  Serial.println();

  gps.crack_datetime(&year, &month, &day, &hour, &minute, &second, &hundredths);

  Serial.print("Date: "); Serial.print(month, DEC); Serial.print("/");
  Serial.print(day, DEC); Serial.print("/"); Serial.print(year);
  Serial.print(hour, DEC); Serial.print(":");
  Serial.print(minute, DEC); Serial.print(":");
  Serial.print(second, DEC); Serial.print(".");
  Serial.println(hundredths, DEC);

  Serial.print("Course (degrees): "); Serial.println(gps.f_course());
  course = gps.f_course();
  Serial.print("Speed(kmph): ");
  speed = gps.f_speed_kmph();
  Serial.println(gps.f_speed_kmph());
  Serial.println();

  delay(10000);

  if(millis() - lastConnectionTime > postingInterval){
    httpRequest();
  }
}

void httpRequest(){
  Serial.println();

  client.stop();

  if(client.connect(server, 80)){
    Serial.println("Connecting...");

    dtostrf((float)latitude, 8, 5, Lat);
    dtostrf((float)longitude, 9, 5, Long);
    dtostrf((float)speed, 4, 2, SPEED);
    dtostrf((float)course, 4, 2, COURSE);

    sprintf(SBuf, "GET /~yebbnrjs/GPS.jsp?Latitude=%s&Longitude=%s&Speed=%s&Course=%s HTTP/1.1", Lat, Long, SPEED, COURSE);

    client.println(SBuf);
    client.println(F("Host: sc1.swu.ac.kr"));
    client.println("Connection: close");
    client.println();

    lastConnectionTime = millis();
  }
  else{
    Serial.println("Connection failed");
  }
}

void printWifiStatus()
{
  // print the SSID of the network you're attached to
  Serial.print("SSID: ");
  Serial.println(WiFi.SSID());

  // print your WiFi shield's IP address
  IPAddress ip = WiFi.localIP();
  Serial.print("IP Address: ");
  Serial.println(ip);

  // print the received signal strength
  long rssi = WiFi.RSSI();
  Serial.print("Signal strength (RSSI):");
  Serial.print(rssi);
  Serial.println(" dBm");
}
