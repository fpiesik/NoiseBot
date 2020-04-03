void kick(int str,float vel){
  if (vel>1)vel=1;
  if(str==0){
      Serial1.write(203);
      Serial1.write(int(vel*160+40));  
  }
    if(str==1){
      Serial1.write(202);
      Serial1.write(int(vel*130+70));  
  }
    if(str==2){
      Serial1.write(201);
      Serial1.write(int(vel*160+40));  
  }
  delay(1);
}

void chVcaBias(float val){
  mix3.gain(0,val);
  mix3.gain(1,1-val);
}

void chCoilDel(byte str, float val){
  coilDels[str]->delay(0,val*5.0);
}

void motor(int str,float vel){
  if (vel>1)vel=1;
  if(str==0){
      Serial1.write(204);
      Serial1.write(int(vel*200));  
  }
    if(str==1){
      Serial1.write(205);
      Serial1.write(int(vel*200));  
  }
    if(str==2){
      Serial1.write(206);
      Serial1.write(int(vel*200));  
  }
  delay(1);
}

void coil(int str, float val){
coilAmps[str]->gain(coilGain[str]*30*val);
}

void playMonoOn(byte note, byte vel){
      for(int i=0;i<nStr;i++){
        if(note>=roots[i]&&note<roots[i]+nPpS){
        byte fret=note-roots[i];
        Serial1.write(frtID[i][fret]);
        Serial1.write(frtPrs[i][fret]); 
        }
      }      
}

void playMonoOff(byte note, byte vel){   
      for(int i=0;i<nStr;i++){
        if(note>=roots[i]&&note<roots[i]+nPpS){
        byte fret=note-roots[i];
        Serial1.write(frtID[i][fret]);
        Serial1.write(frtRel[i][fret]); 
        }
      }
}

void sndVc(){
  for(int i=0;i<nStr;i++){
    if(lastVoicing[i]!=voicing[i]){
      int fret=lastVoicing[i]+roots[0]-roots[i];
      Serial1.write(frtID[i][fret]);
      Serial1.write(frtRel[i][fret]); 
      usbMIDI.sendNoteOff(lastVoicing[i]+roots[0], 0, i+1);
    }
  }
  
  for(int i=0;i<nStr;i++){
    if(lastVoicing[i]!=voicing[i]){
      int fret=voicing[i]+roots[0]-roots[i];
      Serial1.write(frtID[i][fret]);
      Serial1.write(frtPrs[i][fret]); 
      usbMIDI.sendNoteOn(voicing[i]+roots[0], 100, i+1);
      lastVoicing[i]=voicing[i];
    }
  }
  delay(1);
}

void allFrtsOff(){
  for(int s=0;s<nStr;s++){
    for(int f=0;f<nPpS;f++){
      Serial1.write(frtID[s][f]);
      Serial1.write(frtRel[s][f]); 
      delay(1);
    }
  }
}

void updEnv(){
  for (int i=0; i<nStr; i++) {
    envs1[i]->delay(envP[0]);
    envs1[i]->attack(envP[1]);
    envs1[i]->hold(envP[2]);
    envs1[i]->decay(envP[3]);
    envs1[i]->sustain(envP[4]);
    envs1[i]->release(envP[5]);
    envs1[i]->releaseNoteOn(envP[6]);
  }
}
