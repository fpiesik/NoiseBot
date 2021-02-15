/*
 * A simple hardware test which receives audio from the audio shield
 * Line-In pins and send it to the Line-Out pins and headphone jack.
 *
 * This example code is in the public domain.
 */

#include <Audio.h>
#include <Wire.h>
#include <SPI.h>
#include <SD.h>
#include <SerialFlash.h>
//#include "libs/AudioTuner/AudioTuner.h"
#include "libs/AudioTuner/coeff.h"

AudioAnalyzeNoteFrequency tuner;
AudioInputI2S            i2s1;           //xy=200,69
AudioOutputI2S           i2s2;           //xy=365,94
AudioAmplifier           amp1;
AudioEffectEnvelope      env1;
AudioMixer4              bMix;
AudioConnection          patchCord1(i2s1, 0, amp1, 0);
AudioConnection          patchCord2(amp1, 0, env1, 0);
AudioConnection          patchCord3(amp1, 0, bMix, 0);
AudioConnection          patchCord4(env1, 0, bMix, 1);
AudioConnection          patchCord5(bMix, 0, i2s2, 0);
AudioConnection          patchCord7(i2s1, 1, i2s2, 1);
AudioConnection          patchCord8(amp1, 0, tuner, 0);
AudioControlSGTL5000     sgtl5000_1;     //xy=302,184


const int myInput = AUDIO_INPUT_LINEIN;
//const int myInput = AUDIO_INPUT_MIC;

const int nStr=2;
const int nPitch=21;
int root[nStr]={28,28};

int pPos[nPitch]={0,600,1140,1700,2255,2750,3150,3510,3890,4260,4655,4950,5280,5600,5880,6110,6400,6630,6860,7070,7230};

int pickPosC[nStr]={93,95};
int pickDstM[nStr]={2,2};
int pickDstO[nStr]={10,10};
//int pickPosOL[nStr]={85,85};
//int pickPosOR[nStr]={105,105};
//int pickPosML[nStr]={94,94};
//int pickPosMR[nStr]={97,97};
bool pickDir[nStr];

//---envelopes
const byte nEnvP=7;
byte vcaBiasCC=17;
byte env1CC[nEnvP]={10,11,12,13,14,15,16};
float env1Mult[nEnvP]={1.0,2.0,5.0,5.0,1.0/127,5,1.0};
float envP[7]={0,20,50,200,1,80,0};



//int pPos[nPitch)= {20,200,400,

long actPos[nStr];

void setup() {
  Serial1.begin(115200);
  // Audio connections require memory to work.  For more
  // detailed information, see the MemoryAndCpuUsage example
  AudioMemory(150);

  usbMIDI.setHandleNoteOn(nOn);
  usbMIDI.setHandleNoteOff(nOff);
  usbMIDI.setHandleControlChange(ccCh);
  
  
  // Enable the audio shield, select input, and enable output
  sgtl5000_1.enable();
  sgtl5000_1.inputSelect(myInput);
  sgtl5000_1.volume(1);

  Serial1.write(208);
  Serial1.write(1);
  delay(10);
  stpSpd(0,0.3);

  amp1.gain(4);
  //tuner.begin(.2);
  //notefreq.begin(0.1);
  delay(1000);
  go2(0, 0);
  delay(1000);
  goHome(0);
  stpOnOff(0,1);

  updEnv();

//  for(int i=0;i<5;i++){
//    int del=1000;
//    pick(0);
//    delay(del);
//    pick(0);
//    delay(del);
//    pick(0);
//    delay(del);
//    mute(0,1);
//    delay(del);
//    mute(0,0);
//    delay(del);
//  }
  
//  delay(7000); 
//for (int i=0;i<nPitch;i++){
//  scanFor(root[0]+i);
//}
  
}

elapsedMillis volmsec=0;

void loop() {
  usbMIDI.read();
}
