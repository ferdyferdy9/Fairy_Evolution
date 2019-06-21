class Fairy extends PVector{
  FairyDNA dna;
  PVector vel = new PVector();
  PVector accel = new PVector();
  String name;
  float hp, hpRegen, maxHP;
  float mana, manaRegen, maxMana;
  float maxSpeed;
  float motivation = 100;
  float timeAlive = 0;
  
  int shotOrder=0;
  float cooldown=0;
  
  Fairy(float x, float y){
    super(x,y);
    dna = new FairyDNA();
    init();
  }
  
  Fairy(float x, float y, FairyDNA dna){
    super(x,y);
    this.dna = dna;
    init();
  }
  
  void init(){
    name     = "Fairy#"+floor(random(1000));
    maxHP    = map(  dna.hpSpeed  , 0, 1, world.minHP     , world.maxHP     );
    hpRegen  = map(1-dna.hpSpeed  , 0, 1, world.hpRegMin  , world.hpRegMax  );
    maxMana  = map(  dna.manaRegen, 0, 1, world.minMana   , world.maxMana   );
    manaRegen= map(1-dna.manaRegen, 0, 1, world.manaRegMin, world.manaRegMax);
    maxSpeed = map(1-dna.hpSpeed  , 0, 1, world.minSpeed  , world.maxSpeed  );
    
    hp = maxHP;
    mana = maxMana;
  }
  
  void shoot(PVector target){
    if(cooldown==0 && mana > calcCost(dna.bullets[shotOrder])){
      world.bulGen.generate(dna.bullets[shotOrder],this,target);
      cooldown = dna.bullets[shotOrder].duration;
      mana -= calcCost(dna.bullets[shotOrder]);
      motivation += 10;
      shotOrder = (shotOrder+1) < dna.bullets.length ? shotOrder+1 : 0;
    }
  }
  
  float calcCost(ShotDNA s){
    float cost;
    cost = s.amount*8-1;
    switch(s.shotType){
      case ODD     :
      case EVEN    : cost *= 2 * map(s.spreadRad, 0, PI, 2, 0.5); break;
      case CIRCULAR: cost *= 0.2; break;
    }
    switch(s.bulletType){
      case ROUND_S: cost *= 0.8; break;
      case ROUND_M: cost *=   1; break;
      case ROUND_B: cost *=   4; break;
      case KUNAI  : cost *= 0.8; break;
    }
    cost*= s.maxSpeed;
    //cost*= map(s.accel.mag(), 0, 0.01, 1, 2);
    
    return cost;
  }
  
  void update(){
    hp += hpRegen;
    mana += manaRegen;
    motivation--;
    timeAlive+=0.1;
    
    cooldown--;
    if(cooldown < 0){
      cooldown=0;
    }
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
