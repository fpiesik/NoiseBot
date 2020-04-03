  static float actP;

void scanFor(float trgt){
  Serial.print("trgt ");
  Serial.println(trgt);
  float preci=0.1;
  while(actP<trgt-preci||actP>trgt+preci){
  sample(0);
  float diff=trgt-actP;
  if (abs(diff)<12){
    Serial.print("diff ");
    Serial.println(diff);
    if(actP<trgt)go2(0,actPos[0]+diff*100);
    if(actP>trgt)go2(0,actPos[0]+diff*100);
  }
  delay(1000);
  }
  
  Serial.print("found: ");
  Serial.print(actP);
  Serial.print(" at pos: ");
  Serial.println(actPos[0]);
}

void sample(int str){
  mute(0,0);
  delay(100);
  kick(str,0.8);
  delay(350);
//if (notefreq.available()) {
        int nSamples=10;
        float note;
        float prob= 1;
        for (int i=0;i<nSamples;i){
          if (tuner.available()){
            note = note + tuner.read();
            i++;
          }
          delay(10);
        }
        mute(0,1);
        note=note/nSamples;
        note= 69 + (12.0 * log(note / 440.0) / log(2));
        Serial.printf("Note: %3.2f | Pos: %.2f\n", note, actPos);
//        return (note);
          actP=note;
          delay(250);
//        delay(100);
//        prob = tuner.probability();
        
//}
}
