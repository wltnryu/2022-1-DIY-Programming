

void setup() {
  Serial.begin(115200);
  Serial1.begin(9600);
  Serial2.begin(9600);

}

void loop() {
  
  if(Serial.available()){
    Serial.write(Serial.read());
  }
  if(Serial1.available()){
    Serial.write(Serial1.read());
    Serial2.write(Serial.read());
  }

  if(Serial2.available()){
    Serial.write(Serial2.read());
  }
}
