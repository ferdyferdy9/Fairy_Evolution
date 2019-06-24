class World {
  ArrayList<Fairy> fairies;
  ArrayList<Bullet> bullets;
  BulletGenerator bulGen;
  ArrayList<Fairy> masters;
  float bestFit;
  Boolean isDisabled=false;
  Boolean scopeMode =false;
  
  // Starting baseline
  float hp      =  100;
  float hpReg   =    0.1;
  float speed   =    1;
  float mana    = 1000;
  float manaReg =    0.01;
  int bulletVar =    5;
  float maxDist =  200;
  
  float hpmin    =   10;
  float hpmax    = 2000;
  float hpRegMin =    0;
  float hpRegMax =   10;
  float speedMin =    0;
  float speedMax =    2;
  float manaMin  =  200;
  float manaMax  = 5000;
  float manaRegMin = 0.05;
  float manaRegmax = 0.2;
  
  // mutation zone
  Mutate hpMutate        = new Mutate(0.25 , 5);
  Mutate hpRegMutate     = new Mutate(0.25 , 5);
  Mutate speedMutate     = new Mutate(0.25 , 5);
  Mutate manaMutate      = new Mutate(0.25 , 5);
  Mutate manaRegMutate   = new Mutate(0.25 , 5);
  Mutate enemyRadMutate  = new Mutate(0.25 , 5);
  Mutate idealRadMutate  = new Mutate(0.25 , 5);
  Mutate bulletRadMutate = new Mutate(0.25 , 5);
  Mutate laserRadMutate  = new Mutate(0.25 , 5);
  Mutate bulletMutate    = new Mutate(0.005, 5);
  
  Mutate amountMutate     = new Mutate(0.25 , 5);
  Mutate spreadRadMutate  = new Mutate(0.25 , 5);
  Mutate shotTypeMutate   = new Mutate(0.25 , 5);
  Mutate bulletTypeMutate = new Mutate(0.25 , 5);
  Mutate maxSpeedMutate   = new Mutate(0.25 , 5);
  Mutate accelMutate      = new Mutate(0.25 , 5);
  Mutate durationMutate   = new Mutate(0.25 , 5);
  
  float hpRegtohp = 0.01;
  float speedtohp = 0.01;
  float manaRegtomana = 0.0001;
  
  World() {
    fairies = new ArrayList<Fairy>();
    bullets = new ArrayList<Bullet>();
    bulGen = new BulletGenerator();
    masters = new ArrayList<Fairy>();
    bestFit = 0;
  }
  
  void add(int n){
    while(n-->0){
      fairies.add(new Fairy(random(width*2), random(height*2)));
    }
  }
  
  void add(){
    float chance = random(1);
    if(chance < 0.25 || masters.size() == 0)
      fairies.add(new Fairy(random(width*2), random(height*2)));
    else
      fairies.add(new Fairy(random(width*2), random(height*2), masters.get((int)random(masters.size())).dna.copyData().mutate()));
  }

  void update() {
    for (Fairy f : fairies) f.update();
    for (Bullet b : bullets) b.update();

    int end;
    
    end = bullets.size()-1;
    for (int i=end; i>=0; i--) {
      if (bullets.get(i).distToOwner() > maxDist)
        bullets.remove(i);
    }
    
    end = fairies.size()-1;
    for (int i=end; i>=0; i--) {
      if (fairies.get(i).timeAlive > bestFit){
        if(!masters.contains(fairies.get(i)))
          masters.add(fairies.get(i));
        fill(255,100,0,60);
        ellipse(fairies.get(i).x,fairies.get(i).y, 20,20);
      }
      if (fairies.get(i).isDead()){
        if(fairies.get(i).timeAlive > bestFit){
          bestFit = fairies.get(i).timeAlive;
          for(int k=masters.size()-1;k>=0;k--)
            if(masters.get(k).timeAlive < bestFit)
              masters.remove(k);
          println("DNA : " + fairies.get(i).dna);
          println("Duration : " + world.bestFit);
        }
        fairies.remove(i);
        add();
      }
    }
  }

  void show() {
    //for (Fairy f : fairies) f.show();
    //for (Bullet b : bullets) b.show();
    
    Fairy closest = fairies.get(0);
    
    for (Fairy f : fairies) {
      f.show();
      if(f.dist(cam.mouse) < closest.dist(cam.mouse))
        closest = f;
    }
    
    if(!scopeMode){
      for(Bullet b : bullets)
        if(b.owner == closest)
          b.show();
    }else{
      for(Bullet b : bullets)
        if(b.dist(cam.mouse) < maxDist)
          b.show();
    }
  }

  void test() {
    for (Fairy f : fairies)
      f.shoot(cam.mouse);
  }
}
