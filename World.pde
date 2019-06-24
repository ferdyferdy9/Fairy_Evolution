class World {
  ArrayList<Fairy> fairies;
  ArrayList<Bullet> bullets;
  BulletGenerator bulGen;
  ArrayList<Fairy> masters;
  float bestFit;
  Boolean isDisabled=false;
  Boolean scopeMode =false;
  
  int bulletVar  =    5;
  float maxDist  =  200;
  float minHP    =   20;
  float maxHP    =  200;
  float minSpeed =    1;
  float maxSpeed =    2;
  float minMana  =  200;
  float maxMana  = 2000;
  float hpRegMin   = 0.01;
  float hpRegMax   = 0.2;
  float manaRegMin =  5;
  float manaRegMax = 10;

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
