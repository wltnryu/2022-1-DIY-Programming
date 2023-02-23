const int buttonPin = 2;
const int GreenPin =  9;

int buttonState = 0;

void setup() {
  Serial.begin(115200);
  pinMode(GreenPin, OUTPUT);
  pinMode(buttonPin, INPUT);
}

void loop() {
  buttonState = digitalRead(buttonPin);

  if (buttonState == LOW) {
    // turn LED on:
    digitalWrite(GreenPin, HIGH);
    Serial.println("BUTTON / LED on");
    delay(10);
  } else {
    digitalWrite(GreenPin, LOW);
    Serial.println("BUTTON / LED off");
    delay(10);
  }
}
