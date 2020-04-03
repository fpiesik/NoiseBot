int nCnt(){
  int nNotes=0;
  for (int i=0; i<nTones; i++) {
    if(nState[i]>0)nNotes++;
  }  
  return nNotes;
}


void mkVoicing(){


for (int n=0; n<nStr; n++) {
  byte v=n;
  int chck=0;
  int vI[nStr];
  for (int i=0; i<nTones; i++) {
    
    if(nState[i]==1){
      vI[v]=i;
      v=(v+1)%nStr;
    }
  }

  Serial.print("voicing: ");
Serial.print(vI[0]);
Serial.print(" ");
Serial.print(vI[1]);
Serial.print(" ");
Serial.println(vI[2]);
  for (int i=0; i<nStr; i++) {
    if(vI[i]>=i*(nPpS-1)&&vI[i]<=i*(nPpS-1)+nPpS)chck++;
    if(i==nStr-1&&vI[i]==0){
      vI[i]=12;
      chck++;
    }
  }
  
  if(chck==3){
    for (int i=0; i<nStr; i++) {
      voicing[i]=vI[i];
    }
    sndVc();
    break;
  }
}
  

//Serial.print(" chck: ");
//Serial.println(chck);

}
