void moEnv(bool on, float a, float d, float s, float r, float){
static long eT;
static int eP;
static float lvl;
static int aMT=100;
static int dMT=100;
static int rMT=200;

a=a*aMT;
d=d*dMT;
r=r*rMT;

  if(on==1){
    
    if(eP==1)lvl=1.0/a*eT;
    
    if(eP==2)lvl=0;
    
    eT++;
  }
  
}
