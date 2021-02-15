/*
 * A simple hardware test which receives audio from the audio shield
 * Line-In pins and send it to the Line-Out pins and headphone jack.
 *
 * Four audio channels are used.
 *
 * This example code is in the public domain.
 */

#include <Audio.h>
#include <Wire.h>
#include <SPI.h>
#include <SD.h>
#include <SerialFlash.h>

//---global constants
const byte nStr=3;
const byte nPpS=5;
const byte roots[nStr]={43,47,51};
const byte nTones=12;
const byte nEnvP=7;

//---midi channels
byte chPitch=1; //midi channel for notes to change pitch
byte chExc=2; //midi channel for notes to excite the strings

//---kickups
byte kickNotes[nStr]={44,45,46}; //notes to activate the kickup
byte kickOn[nStr];
byte lastKickOn[nStr];
float kickGain=1;
float kickGainCC=40;

//---motors
byte motorNotes[nStr]={48,49,50};
byte motorCC[nStr+1]={20,21,22,23};
bool motorOn[nStr]={0,0,0};
bool lastMotorOn[nStr];
float motorGain[nStr+1]={1,1,1,1};
float lastMotorGain[nStr+1]={1,1,1,1};
float motorVel[nStr]={0,0,0};
float lastMotorVel[nStr]={0,0,0};

//---coils
byte coilNotes[nStr]={30,31,32};
byte coilCC[nStr+1]={30,31,32,33};
byte coilDelCC[nStr]={34,35,36};
byte coilDel[nStr]={0.5,0.5,0.5};
bool coilOn[nStr]={1,1,1};
bool lastCoilOn[nStr]={1,1,1};
float shpStr[9]= {-1,-0.95,-0.9,-0.85,0,0.85,0.9,0.95,1,};
float coilGain[nStr+1]={1,1,1,0};
float lastCoilGain[nStr+1]={1,1,1,1};

//---envelopes
byte vcaBiasCC=17;
byte env1CC[nEnvP]={10,11,12,13,14,15,16};
float env1Mult[nEnvP]={1.0,2.0,5.0,5.0,1.0/127,5,1.0};
float envP[7]={0,20,50,200,1,80,0};

//---Pitch
bool nState[nTones];
int voicing[nStr];
int lastVoicing[nStr];
int chcks[nStr];
int noteCnt;
int lastNCnt;
byte frtID[nStr][nPpS]={{0,219,216,213,222},{0,220,217,214,211},{0,221,218,215,212}};
byte frtPrs[nStr][nPpS]={{0,150,150,130,135},{0,160,150,150,150},{0,160,150,150,145}};
byte frtRel[nStr][nPpS]={{0,80,80,70,70},{0,100,80,80,80},{0,100,90,70,70}};

//---preamp
float strGain[nStr]={1,3,2};


//---Codec
const int myInput = AUDIO_INPUT_LINEIN;
AudioControlSGTL5000     sgtl5000_1;     //xy=302,184
AudioControlSGTL5000     sgtl5000_2;     //xy=302,254

//---Audio Modules
AudioInputI2SQuad        i2s_quad1;      //xy=150,69
AudioOutputI2SQuad       i2s_quad2;      //xy=365,94
AudioMixer4              mix1;
AudioMixer4              mix2;
AudioMixer4              mix3;

AudioEffectEnvelope      envelope1;  
AudioEffectEnvelope      envelope2;
AudioEffectEnvelope      envelope3;  

AudioEffectDelay         coilDel1;
AudioEffectDelay         coilDel2;
AudioEffectDelay         coilDel3;

AudioAmplifier           preamp1;
AudioAmplifier           preamp2;
AudioAmplifier           preamp3;

AudioAmplifier           envAmp1;
AudioAmplifier           envAmp2;
AudioAmplifier           envAmp3;

AudioEffectWaveshaper    coilShp1;
AudioEffectWaveshaper    coilShp2;
AudioEffectWaveshaper    coilShp3;

AudioAmplifier           coilAmp1;
AudioAmplifier           coilAmp2;
AudioAmplifier           coilAmp3;


//---AudioConnections
AudioConnection          patchCord1(i2s_quad1, 3, preamp1, 0);
AudioConnection          patchCord2(i2s_quad1, 1 , preamp2, 0);
AudioConnection          patchCord3(i2s_quad1, 2, preamp3, 0);

AudioConnection          patchCord4(preamp1, 0, envelope1, 0);
AudioConnection          patchCord5(preamp2, 0, envelope2, 0);
AudioConnection          patchCord6(preamp3, 0, envelope3, 0);

AudioConnection          patchCord7(preamp1, 0, coilDel1, 0);
AudioConnection          patchCord8(preamp2, 0, coilDel2, 0);
AudioConnection          patchCord9(preamp3, 0, coilDel3, 0);

AudioConnection          patchCord10(coilDel1, 0, coilShp1, 0);
AudioConnection          patchCord11(coilDel2, 0, coilShp2, 0);
AudioConnection          patchCord12(coilDel3, 0, coilShp3, 0);

AudioConnection          patchCord13(preamp1, 0, mix1, 0);
AudioConnection          patchCord14(preamp2, 0, mix1, 1);
AudioConnection          patchCord15(preamp3, 0, mix1, 2);

AudioConnection          patchCord16(envelope1, 0, envAmp1, 0);
AudioConnection          patchCord17(envelope2, 0, envAmp2, 0);
AudioConnection          patchCord18(envelope3, 0, envAmp3, 0);

AudioConnection          patchCord19(envAmp1, 0, mix2, 0);
AudioConnection          patchCord20(envAmp2, 0, mix2, 1);
AudioConnection          patchCord21(envAmp3, 0, mix2, 2);

AudioConnection          patchCord22(coilShp1, 0, coilAmp1, 0);
AudioConnection          patchCord23(coilShp2, 0, coilAmp2, 0);
AudioConnection          patchCord24(coilShp3, 0, coilAmp3, 0);

AudioConnection          patchCord25(coilAmp1, 0, i2s_quad2, 0);
AudioConnection          patchCord26(coilAmp2, 0, i2s_quad2, 1);
AudioConnection          patchCord27(coilAmp3, 0, i2s_quad2, 2);

AudioConnection          patchCord28(mix1, 0, mix3, 0);
AudioConnection          patchCord29(mix2, 0, mix3, 1);
AudioConnection          patchCord30(mix3, 0, i2s_quad2, 3);


//---Audio Module bundles
AudioEffectEnvelope       *envs1[nStr] = {
  &envelope1, &envelope2, &envelope3
};

AudioEffectDelay          *coilDels[nStr] = {
  &coilDel1, &coilDel2, &coilDel3
};

AudioAmplifier            *preamps[nStr] = {
  &preamp1, &preamp2, &preamp3
};

AudioAmplifier            *envAmps[nStr] = {
  &envAmp1, &envAmp2, &envAmp3
};

AudioAmplifier            *coilAmps[nStr] = {
  &coilAmp1, &coilAmp2, &coilAmp3
};

AudioEffectWaveshaper     *coilShps[nStr] = {
  &coilShp1, &coilShp2, &coilShp3
};

// GUItool: end automatically generated code


void setup() {
  Serial.begin(115200);
  Serial1.begin(115200); 
  // Audio connections require memory to work.  For more
  // detailed information, see the MemoryAndCpuUsage example
  AudioMemory(400);

  usbMIDI.setHandleNoteOn(nOn);
  usbMIDI.setHandleNoteOff(nOff);
  usbMIDI.setHandleControlChange(ccCh);
  usbMIDI.setHandleStop(mStop);

  // Enable the first audio shield, select input, and enable output
  sgtl5000_1.setAddress(LOW);
  sgtl5000_1.enable();
  sgtl5000_1.inputSelect(myInput);
  sgtl5000_1.volume(1);

  // Enable the second audio shield, select input, and enable output
  sgtl5000_2.setAddress(HIGH);
  sgtl5000_2.enable();
  sgtl5000_2.inputSelect(myInput);
  sgtl5000_2.volume(1);

  for(int s=0;s<nStr;s++){
    chCoilDel(s, coilDel[s]);
  }

//  mix1.gain(0,0.5);
//  mix1.gain(1,1.2);
//  mix1.gain(2,1.0);




  for (int i=0; i<nStr; i++) {
    preamps[i]->gain(strGain[i]);
  }
  
  for (int i=0; i<nStr; i++) {
    coilAmps[i]->gain(0.0001);
  }

  for (int i=0; i<nStr; i++) {
    envAmps[i]->gain(1);
  }

  for (int i=0; i<nStr; i++) {
    envs1[i]->delay(envP[0]);
    envs1[i]->attack(envP[1]);
    envs1[i]->hold(envP[2]);
    envs1[i]->decay(envP[3]);
    envs1[i]->sustain(envP[4]);
    envs1[i]->release(envP[5]);
    envs1[i]->releaseNoteOn(envP[6]);
  }

  for (int i=0; i<nStr; i++) {
    coilShps[i]->shape(shpStr,9);
  }

//  envelope1.noteOn();
//  envelope2.noteOn();
//  envelope3.noteOn();
}

void loop() {
  usbMIDI.read();
  
//---Kickup
  for(int s=0;s<nStr;s++){
    if(kickOn[s]!=lastKickOn[s]){
      if(kickOn[s]==1 ){
          envs1[s]->noteOn();
          }   
      if(kickOn[s]==0){
        envs1[s]->noteOff();
      }
      lastKickOn[s]=kickOn[s];
    }  
  }

//---Motors
  for(int s=0;s<nStr;s++){
    if(motorGain[s]!=lastMotorGain[s]||motorOn[s]!=lastMotorOn[s]){
      motor(s,motorGain[s]*motorGain[3]);
      lastMotorGain[s]=motorGain[s];
      lastMotorVel[s]=motorVel[s];
    }
  }
    if(motorGain[3]!=lastMotorGain[3]){
      motor(0,motorGain[0]*motorGain[3]);
      motor(1,motorGain[1]*motorGain[3]);
      motor(2,motorGain[2]*motorGain[3]);
      lastMotorGain[3]=motorGain[3];
    }

//---Coils
  for(int s=0;s<nStr;s++){
    if(coilGain[s]!=lastCoilGain[s]||coilOn[s]!=lastCoilOn[s]){
      coil(s,coilGain[s]*coilGain[3]);
      lastCoilGain[s]=coilGain[s];
    }
  }
    if(coilGain[3]!=lastCoilGain[3]){
      coil(0,coilGain[0]*coilGain[3]);
      coil(1,coilGain[1]*coilGain[3]);
      coil(2,coilGain[2]*coilGain[3]);
      lastCoilGain[3]=coilGain[3];
    }

//---Voice Maker
  noteCnt=nCnt();
  if(noteCnt!=lastNCnt){
    lastNCnt=noteCnt;
    if(noteCnt==3){
      mkVoicing();
    }
  }
}
