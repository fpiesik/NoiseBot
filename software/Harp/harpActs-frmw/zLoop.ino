void loop(){

if (Serial.available()) {


       
      byte  serbyte = Serial.read();
      Serial.write(serbyte);
        if (serbyte > 200) incoming = serbyte - 200;
        if (serbyte <= 200){
            
     
            if (incoming == 1) kick(0,float(serbyte/200.0));
            if (incoming == 2) kick(1,float(serbyte/200.0));
            if (incoming == 3) kick(2,float(serbyte/200.0));

            if (incoming == 4) motor(0,float(serbyte/200.0));
            if (incoming == 5) motor(1,float(serbyte/200.0));
            if (incoming == 6) motor(2,float(serbyte/200.0));

            //if (incoming >= 10)thrgh(incoming+200,serbyte);
            incoming = 0;                 
        }
        
}

}

void thrgh(byte id, byte val){
//  Serial.write(id);
//  Serial.write(val);
}
