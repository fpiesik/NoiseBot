void loop(){
  MIDI.read();
  //serialread();


//------------------------------------------------------------------------------

kick1_currMicro = micros();
   if(kick1_currMicro - kick1_prvMicro >= kick1_duration || mosfet1_pin==HIGH) {
   digitalWrite(mosfet1_pin, LOW);
  }
kick2_currMicro = micros();
   if(kick2_currMicro - kick2_prvMicro >= kick2_duration || mosfet2_pin==HIGH) {
   digitalWrite(mosfet2_pin, LOW);
  }

 
  
//-----------------------------------------------------------------------------  
 if(step1_arrvd==0 && step1_enbl==1){
   if (step1_pos<step1_trgt) {
     if(step1_rmpDwn==1)stepRmpdwn(1,step1_rampAmnt);
     if(step1_rmpDwn==0){
     stepDir(1,0); 
     stepRmpup(1);
   }
     step1_move=1;}
   if (step1_pos>step1_trgt) {
     if(step1_rmpDwn==1)stepRmpdwn(1,step1_rampAmnt);
     if(step1_rmpDwn==0){
     stepDir(1,1); 
     stepRmpup(1);
   }
     step1_move=1;}
   }
   if (step1_pos==step1_trgt && step1_arrvd==0){
     step1_move=0; 
     step1_arrvd=1;
     step1_arriving=0;
     stepSndpos(1);  
     } 
      
   
  //if(digitalRead(home1_pin)==0)step1_pos=0;
 
  if (step1_move>0){
   //stepEnbl(1);
     if(step1_enbl==1);stepMove(1);
   }  
   if (step1_move==0){
     step1_interval=step1_startSpd;
     //stepEnbl(0);
   }
 


//-----------------------------------------------------------------------------  
 if(step2_arrvd==0 && step2_enbl==1){
   if (step2_pos<step2_trgt) {
     if(step2_rmpDwn==1)stepRmpdwn(2,step2_rampAmnt);
     if(step2_rmpDwn==0){
     stepDir(2,0); 
     stepRmpup(2);
   }
     step2_move=1;}
   if (step2_pos>step2_trgt) {
     if(step2_rmpDwn==1)stepRmpdwn(2,step2_rampAmnt);
     if(step2_rmpDwn==0){
     stepDir(2,1); 
     stepRmpup(2);
   }
     step2_move=1;}
   }
   if (step2_pos==step2_trgt && step2_arrvd==0){
     step2_move=0; 
     step2_arrvd=1;
     step2_arriving=0;
     stepSndpos(1); 
     } 
      
   
  //if(digitalRead(home2_pin)==0)step2_pos=0;
 
  if (step2_move>0){
   //stepEnbl(1);
     if(step2_enbl=1);stepMove(2);   
  }  
  if (step2_move==0){
    step2_interval=step2_startSpd;
    //stepEnbl(0);
  }
 
}
