const int RedPin =  8;

void setup() {
  pinMode(RedPin, OUTPUT);
}

void loop() {
  digitalWrite(RedPin, HIGH);
  delay(1000);
  digitalWrite(RedPin, LOW);
  delay(1000);
}
