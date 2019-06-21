class BulletGenerator{
  ShotDNA dna;
  Bullet b;
  Bullet[] ls;
  Fairy owner;
  PVector target;
  
  void generate(ShotDNA dna, Fairy owner, PVector target){
    if(world.isDisabled)
      return;
    
    this.dna = dna;
    this.owner = owner;
    this.target = target;
    
    b = null;
    switch(dna.bulletType){
      case ROUND_S: b = new Bullet_R(owner, 1, 1,dna.c); break;
      case ROUND_M: b = new Bullet_R(owner, 4, 4,dna.c); break;
      case ROUND_B: b = new Bullet_R(owner, 8, 8,dna.c); break;
      //case KUNAI  : b = new Bullet_K(owner, dna.c);
    }
    b.vel = PVector.sub(target,owner).normalize().mult(dna.maxSpeed/2);
    if(b.mag() == 0){
      b.vel = PVector.random2D().mult(dna.maxSpeed/2);
    }
    
    switch(dna.shotType){
      case ODD     : ls = odd();       break;
      case EVEN    : ls = even();      break;
      case CIRCULAR: ls = circular();  break;
    }
    world.bullets.addAll(Arrays.asList(ls));
  }
  
  Bullet[] odd(){
    b.formation = "ODD";
    
    Bullet[] bullets = new Bullet[dna.amount*2-1];
    int middle = (bullets.length-1)/2; // 1-9 -> 5; then -1 cuz index 0
    float step = dna.spreadRad/(bullets.length-1);
    
    for(int i=0; i<middle;i++){
      bullets[i] = b.copyData();
      bullets[i].vel = b.vel.copy();
      bullets[i].vel.rotate(step*(i+1));
    }
    bullets[middle] = b;
    for(int i=bullets.length-1; i>middle;i--){
      bullets[i] = b.copyData();
      bullets[i].vel = b.vel.copy();
      bullets[i].vel.rotate(-step*(i-middle));
    }
    
    return bullets;
  }
  
  Bullet[] even(){
    b.formation = "EVEN";
    b.vel.rotate(-dna.spreadRad/2);
    
    Bullet[] bullets = new Bullet[dna.amount*2];
    float step = dna.spreadRad/(bullets.length-1);
    
    bullets[0] = b;
    for(int i=1; i<bullets.length;i++){
      bullets[i] = b.copyData();
      bullets[i].vel = b.vel.copy();
      bullets[i].vel.rotate(step*i);
    }
    
    return bullets;
  }
  
  Bullet[] circular(){
    
    return null;
  }
}
