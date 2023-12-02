void serialread(){
  if (Serial.available()) {     
    serbyte = Serial.read();
    Serial.println(serbyte);
    if (serbyte > 200) incoming = serbyte - 200;
    if (serbyte <= 200){
        
        //Stepper1
        if (incoming == 1) step_home(1);
        if (incoming == 2) stepEnbl(1,serbyte);
        if (incoming == 3) step_setSpd(1,serbyte);
        if (incoming == 4) stepSndpos(1);
        if (incoming == 5) step1_trgtA=serbyte;
        if (incoming == 6) {step1_trgtB=serbyte; 
                            stepGo2pos(1);}
        //Stepper2 
        if (incoming == 7) step_home(2);
        if (incoming == 8) stepEnbl(2,serbyte);
        if (incoming == 9) step_setSpd(2,serbyte);
        if (incoming == 10) stepSndpos(2);
        if (incoming == 11) step2_trgtA=serbyte;
        if (incoming == 12) step2_trgtB=serbyte, stepGo2pos(2);
          
          
        if (incoming == 13) setServo(1,serbyte);
        if (incoming == 14) setServo(2,serbyte);
        if (incoming == 15) mosfet(1,serbyte*100);
        if (incoming == 16) mosfet(2,serbyte*100);
                  
    }  
  }
}
