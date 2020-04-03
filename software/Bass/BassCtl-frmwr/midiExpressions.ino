void nOn(byte channel, byte note, byte velocity){
  if(channel==1){
    if(note>=root[0]&&note<root[0]+nPitch){
      stpSpd(0,velocity/127.0);
      go2(0,pPos[note-root[0]]);
    }
  }

  if(channel==2){
    if(note==25){
      mute(0,1);
    }
    if(note==24)kick(0,float(velocity/127.00));
    if(note==23)goHome(0);

    if(note==22)stpOnOff(0,1);
    if(note==21)stpOnOff(0,0);
  
    if(note==12)go2(0,actPos[0]+1);
    if(note==13)go2(0,actPos[0]+10);
    if(note==14)go2(0,actPos[0]+100);
    if(note==15)go2(0,actPos[0]+1000);

    if(note==11)go2(0,actPos[0]-1);
    if(note==10)go2(0,actPos[0]-10);
    if(note==9)go2(0,actPos[0]-100);
    if(note==8)go2(0,actPos[0]-1000);
    }
}

void nOff(byte channel, byte note, byte velocity){
  if(note==25)mute(0,0);
}
