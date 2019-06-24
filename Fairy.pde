class Fairy extends PVector{
  FairyDNA dna;
  PVector vel = new PVector();
  PVector accel = new PVector();
  float hp, mana, maxForce;
  float motivation = 100;
  float timeAlive = 0;
  
  int shotOrder=0;
  float cooldown=0;
  Fairy lastHit;
  
  Fairy(float x, float y){
    super(x,y);
    dna = new FairyDNA();
    hp = dna.hp;
    mana = dna.mana;
    maxForce = dna.speed/8;
  }
  
  Fairy(float x, float y, FairyDNA dna){
    super(x,y);
    this.dna = dna;
    hp = dna.hp;
    mana = dna.mana;
    maxForce = dna.speed/8;
  }
  
  void seek(PVector target){
    PVector desire = PVector.sub(target,this);
    float dist = desire.mag();
    desire.normalize();
    
    if(dist < 100){
      desire.mult(map(dist,0,200,0,maxForce));
    } else {
      desire.mult(maxForce);
    }
    
    accel.add(desire);
  }
  
  void dodge(PVector target){
    PVector desire = PVector.sub(this,target);
    accel.add(desire.normalize().mult(maxForce));
  }
  
  void follow(PVector target){
    seek(PVector.add(target,PVector.sub(this,target).normalize().mult(dna.idealDistance)));
  }
  
  void shoot(PVector target){
    if(cooldown==0 && mana > 10){
      Bullet b = new Bullet(this,random(8,10));
      b.vel.set(PVector.sub(target,this).normalize().mult(6));
      b.vel.add(vel);
      world.bullets.add(b);
      
      mana -= 2;
      cooldown += 10;
      motivation += 0.1;
    }
  }
  
  void applyBehaviours(){
    PVector nearest=this;
    float shortest=10000;
    
    for(Fairy f : world.fairies){
      if(f == this) continue;
      if(this.dist(f) < shortest){
        shortest = this.dist(f);
        nearest = f;
      }
    }
    
    follow(nearest);
    shoot(nearest);
    
    for(Bullet b : world.bullets){
      if(b.owner == this) continue;
      if(this.dist(b) < shortest){
        shortest = this.dist(b);
        nearest = b;
      }
    }
    
    if(shortest < 50)
      if(random(1) < 0.8)
        dodge(nearest);
      else
        seek(nearest);
  }
  
  void update(){
    applyBehaviours();
    vel.add(accel);
    vel.limit(dna.speed);
    this.add(vel);
    accel.set(0,0);
    
    hp   += dna.hpRegen;
    mana += dna.manaRegen;
    
    if(hp > dna.hp) hp = dna.hp;
    if(mana > dna.mana) mana = dna.mana;
    
    motivation -= 0.1;
    timeAlive  += 0.1;
    
    if(--cooldown < 0) cooldown=0;
  }
  
  void show(){
    stroke(0);
    fill(lerpColor(color(255,0,0),color(0,255,0),map(hp,0,dna.hp,0,1)));
    ellipse(x,y,10,10);
  }
  
  Boolean isDead(){
    return motivation <= 0 || hp <= 0;
  }
}
