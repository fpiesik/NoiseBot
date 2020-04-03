void kick(byte str, float vel){
  digitalWrite(kickupPins[str],HIGH);
  delayMicroseconds(1500+vel*3000);
  digitalWrite(kickupPins[str],LOW);
}

void motor(byte str, float spd){
  analogWrite(motorPins[str],spd * 255);
}
