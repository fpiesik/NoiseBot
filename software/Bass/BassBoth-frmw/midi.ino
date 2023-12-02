void nOn(byte channel, byte note, byte velocity){
  if(channel==midiChn){
    
//    if(note>=root&&note<root+nPitch){
//      actNote=note;
//      kick(float(velocity/127.00));
//      go2(pPos[note-root]);
//    }
    if(note>=root&&note<root+nPitch){
      actNote=note;
      stpSpd(float(velocity/127.00));
      go2(pPos[note-root]);
    }
    if(note==8)stpOnOff(1,1);
    if(note==9)goHome(0);
    //if(note==21)stpOnOff(2,0);
    
    if(note<root){
      if(note==10)tunePPos(actNote-root, -1);
      if(note==11)tunePPos(actNote-root, 1);
    }
    if(note==12){
      kick(float(velocity/127.00));
    }
    if(note==13){
      pick();
    }
    if(note==14){
      mute(velocity>=64);
     
    }
  }
}

void nOff(byte channel, byte note, byte velocity){
  //if(note==25 && channel==midiChn+1)mute(0);
}

void ccCh(byte channel, byte cc, byte value){
  if(channel==midiChn){
    if(cc==2)if(value>0)stpSpd(value/127.0);
    if(cc==3)if(value>0)damp(value/127.0);
    //if(cc==2)kick(float(value/127.00));
    //if(cc==3)pick();
    if(cc==4)if(value>0)mute(value>=64);
    if(cc==5)goHome(0);
  }  
}

void midiStop(){
  mute(0);
  damp(0);
}
void setMidiHandles(){
  MIDI.setHandleNoteOn(nOn);
  MIDI.setHandleNoteOff(nOff);
  MIDI.setHandleControlChange(ccCh);
//  MIDI.setHandleClock(midiClock);
//  MIDI.setHandleStart(midiStart);
  MIDI.setHandleStop(midiStop);
}
