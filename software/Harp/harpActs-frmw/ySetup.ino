void setup() {
Serial.begin(115200); 
TCCR1B = TCCR1B & B11111000 | B00000001; 
TCCR2B = TCCR2B & B11111000 | B00000001;  

 for(int s=0;s<nStr;s++){ 
  pinMode(kickupPins[s],OUTPUT);
  pinMode(motorPins[s],OUTPUT);
  digitalWrite(kickupPins[s], LOW);
  analogWrite(motorPins[s],0);
}
} 
