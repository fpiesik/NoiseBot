void kick(int str,float vel){
  if (vel>1)vel=1;
  if(str==0){
      Serial1.write(215);
      Serial1.write(int(vel*200));  
  }
}

//void pick(int str){
//  if(pickDir[str]==0){
//    serA(str,pickPosOL[str]);
//    pickDir[str]=1;
//    }
//  else{
//    serA(str,pickPosOR[str]);
//    pickDir[str]=0;
//    }
//  
//}

void pick(int str){
  if(pickDir[str]==0){
    serA(str,pickPosC[str]-pickDstO[str]);
    pickDir[str]=1;
    }
  else{
    serA(str,pickPosC[str]+pickDstO[str]);
    pickDir[str]=0;
    }
  
}

void mute(int str, bool onOff){
    if(pickDir[str]==0){
      if(onOff==1)serA(str,pickPosC[str]+pickDstM[str]);
      if(onOff==0)serA(str,pickPosC[str]+pickDstO[str]);
    }
  else{
    if(onOff==1)serA(str,pickPosC[str]-pickDstM[str]);
    if(onOff==0)serA(str,pickPosC[str]-pickDstO[str]);
    }
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


void serA(int str,int pos){
  if(pos>200)pos=200;
  if(str==0){
      Serial1.write(214);
      Serial1.write(pos);  
  }
}

void go2(int str, long pos){
  Serial.print("goto ");
  Serial.println(pos);
  actPos[0]=pos;
  byte a=pos/100;
  byte b=pos-(a*100);
  
  Serial1.write(211);
  Serial1.write(a);
  
  Serial1.write(212);
  Serial1.write(b);
  
}

void stpSpd(int str, float spd){
      if(spd>1.0)spd=1;
      if(spd<0)spd=0;
     
      spd=spd*185;
      Serial1.write(209);
      Serial1.write(int(spd));
}

void stpOnOff(byte str, bool onoff){
  Serial1.write(208);
  if(onoff==1)Serial1.write(1);
  if(onoff==0)Serial1.write(0);
}

void goHome(int str){
  Serial1.write(208);
  Serial1.write(1);
  
  Serial1.write(207);
  Serial1.write(1);
  actPos[0]=0;
}

void chVcaBias(float val){
  bMix.gain(0,val);
  bMix.gain(1,1-val);
}
