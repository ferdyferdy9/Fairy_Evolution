class Fairy extends PVector{
  FairyDNA dna;
  PVector vel = new PVector();
  PVector accel = new PVector();
  float hp, mana, maxSpeed;
  float motivation = 2000;
  float timeAlive = 0;
  
  int shotOrder=0;
  float cooldown=0;
  
  Fairy(float x, float y){
    super(x,y);
    dna = new FairyDNA();
    hp = dna.hp;
    mana = dna.mana;
    maxSpeed = dna.speed;
  }
  
  Fairy(float x, float y, FairyDNA dna){
    super(x,y);
    this.dna = dna;
    hp = dna.hp;
    mana = dna.mana;
    maxSpeed = dna.speed;
  }
  
  void shoot(PVector target){
    if(cooldown==0 && mana > 10){
      mana -= 10;
      motivation += 30;
    }
  }
  
  void update(){
    hp   += dna.hpRegen;
    mana += dna.hpRegen;
    
    if(hp > dna.hp) hp = dna.hp;
    if(mana > dna.mana) mana = dna.mana;
    
    motivation -= 0.1;
    timeAlive  += 0.1;
    
    if(--cooldown < 0) cooldown=0;
  }
  
  void show(){
    stroke(0);
    fill(255);
    ellipse(x,y,10,10);
  }
  
  Boolean isDead(){
    return motivation <= 0 || hp <= 0;
  }
}
