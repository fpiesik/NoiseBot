void kick(float vel){
  if (vel>1.0)vel=1.0;
  mosfet(1,vel*20000);
}

void pick(){
  if(pickDir==0){
    serA(pickPosC-pickDstO);
    pickDir=1;
    }
  else{
    serA(pickPosC+pickDstO);
    pickDir=0;
    }
}

void mute(bool onOff){
    if(pickDir==0){
      if(onOff==1)serA(pickPosC+pickDstM);
      if(onOff==0)serA(pickPosC+pickDstO);
    }
  else{
    if(onOff==1)serA(pickPosC-pickDstM);
    if(onOff==0)serA(pickPosC-pickDstO);
    }
}

void damp(float pos){
   if(pos>1.0)pos=1;
   if(pos<0)pos=0;
   setServo(2,int(155-pos*155.0)); 
}

//void mute(int str, bool onOff){
//    if(pickDir[str]==0){
//      if(onOff==1)serA(str,pickPosMR[str]);
//      if(onOff==0)serA(str,pickPosOR[str]);
//    }
//  else{
//    if(onOff==1)serA(str,pickPosML[str]);
//    if(onOff==0)serA(str,pickPosOL[str]);
//    }
//}


void serA(int pos){
  if(pos>200)pos=200;
  setServo(1,pos); 
}

void go2(long pos){
//  Serial.print("goto ");
//  Serial.println(pos);
  actPos=pos;
  byte a=pos/100;
  byte b=pos-(a*100);
  step1_trgtA=a;
  step1_trgtB=b; 
  stepGo2pos(1);
}

void stpSpd(float spd){
      if(spd>1.0)spd=1;
      if(spd<0)spd=0;
     
      spd=spd*185;
      step_setSpd(1,spd);
}

void stpOnOff(byte stp, bool onoff){
  stepEnbl(stp,onoff);
}

void goHome(int str){
  step_home(1);
  //step_home(2);
  actPos=0;
}
