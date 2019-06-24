class Mutate{
  float rate;
  float str;
  
  Mutate(float rate, float str){
    this.rate = rate;
    this.str = str;
  }
  
  Boolean getChance(){
    return random(1) < rate;
  }
}
