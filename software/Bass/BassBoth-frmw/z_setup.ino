void setup() 
{                
  Serial.begin(38400);
  setMidiHandles();
  MIDI.begin(MIDI_CHANNEL_OMNI);
  MIDI.turnThruOff();
  
  pinMode(home1_pin, INPUT);
  
  pinMode(step1_stpPin, OUTPUT);
  pinMode(step1_dirPin, OUTPUT);
  pinMode(step1_enblPin, OUTPUT);
  
  pinMode(step2_stpPin, OUTPUT);
  pinMode(step2_dirPin, OUTPUT);
  pinMode(step2_enblPin, OUTPUT);
  
  pinMode(mosfet1_pin, OUTPUT);
  pinMode(mosfet2_pin, OUTPUT);
  
  
  digitalWrite(home1_pin, HIGH);
  step1_homeState = digitalRead(home1_pin);
  
  digitalWrite(home2_pin, HIGH);
  step2_homeState = digitalRead(home2_pin);
  
  
  
  digitalWrite(step1_stpPin, LOW);
  digitalWrite(step1_dirPin, LOW);
  digitalWrite(step1_enblPin, HIGH);
  
  digitalWrite(step2_stpPin, LOW);
  digitalWrite(step2_dirPin, LOW);
  digitalWrite(step2_enblPin, HIGH);
  
  digitalWrite(mosfet1_pin, LOW);
  digitalWrite(mosfet2_pin, LOW);
  
  
  mkPPos();
  //step_home(2);
  
  //uncomment to reset eeprom
//  for(int i=0;i<nPitch;i++){
//     EEPROM.update(i,127);
//  }
  
  stepEnbl(1,1);
  step_home(1);
  
  
  
  
}
