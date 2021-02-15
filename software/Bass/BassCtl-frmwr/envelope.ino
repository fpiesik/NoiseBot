void updEnv(){
    env1.delay(envP[0]);
    env1.attack(envP[1]);
    env1.hold(envP[2]);
    env1.decay(envP[3]);
    env1.sustain(envP[4]);
    env1.release(envP[5]);
    env1.releaseNoteOn(envP[6]);
}
