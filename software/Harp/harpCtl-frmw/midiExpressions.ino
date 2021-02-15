void nOn(byte channel, byte note, byte velocity){

  if(channel==chPitch)nState[(note+36-roots[0])%12]=1;
  
  if (channel==chExc){
    for(int s=0;s<nStr;s++){
      if(note==kickNotes[s]){
        //coil(s,1);
        if(kickGain>0)kick(s,kickGain*velocity/127.0);
        kickOn[s]=1;
        envAmps[s]->gain(velocity/127.0);
        //envs1[s]->noteOn();
      }
    }

    for(int s=0;s<nStr;s++){
      if(note==coilNotes[s]){
        //coil(s,1);
        //motor(s,motorGain[s]*motorGain[nStr]*velocity/127.0);
        //motorVel[s]=velocity/127.0;
        //coilOn[s]=!coilOn[s];
        //motorOn[s]=!motorOn[s];
        //motorOn[s]=1;
        //envs1[s]->noteOn();
      }
    }
    
    }
}

void nOff(byte channel, byte note, byte velocity){

  if(channel==chPitch)nState[(note+60-roots[0])%12]=0;
  if (channel==chExc){
    for(int s=0;s<nStr;s++){
      if(note==kickNotes[s]){
        //envs1[s]->noteOff();
        kickOn[s]=0;
        
      }
    }
    for(int s=0;s<nStr;s++){
      if(note==motorNotes[s]){
        //envs1[s]->noteOff();
        //motor(s,0);
        //motorVel[s]=0;
        //motorOn[s]=0;
      }
    }
  }
  
} 

void ccCh(byte channel, byte control, byte value){

//kickup
if (control==kickGainCC)kickGain=value/127.0;

//---Envelopes
bool updEnvNeeded=0;
for(int i=0;i<nEnvP;i++){
if (control==env1CC[i])envP[i]=value*env1Mult[i],updEnvNeeded=1;
}
if(updEnvNeeded==1)updEnv();

//---Motors
for(int s=0;s<=nStr;s++){
  if (control==motorCC[s])motorGain[s]=value/127.0;
}

//---VCA Bias
if (control==vcaBiasCC)chVcaBias(value/127.0);

//---Coils
for(int s=0;s<=nStr;s++){
  if (control==coilCC[s])coilGain[s]=value/127.0;
}

for(int s=0;s<=nStr;s++){
  if (control==coilDelCC[s])chCoilDel(s,value/127.0);
}



//if (control==18)coilGain[0]=value/127.0;
//if (control==19)coilGain[1]=value/127.0;
//if (control==20)coilGain[2]=value/127.0;

}

void mStop(){
delay(100);
motor(2,0);
motor(1,0);
motor(0,0);

allFrtsOff();
}
