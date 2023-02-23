#include <MsTimer2.h>

const int buttonPin = 2;
const int RedPin =  8;
const int GreenPin =  9;

int Timer;

int buttonState = 0;

void setup() {
  Serial.begin(115200);
  pinMode(RedPin, OUTPUT);
  pinMode(GreenPin, OUTPUT);
  pinMode(buttonPin, INPUT);
}

void ISR_Timer()
{
  if(Timer < 100)
  {
    digitalWrite(RedPin, HIGH);
    Timer++;
  } else if(Timer >= 100 && Timer < 200){
    digitalWrite(RedPin, LOW);
    Timer++;
  } else if (Timer == 200) Timer = 0;
}

void loop() {
  ISR_Timer();
  
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
