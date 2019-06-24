class World {
  ArrayList<Fairy> fairies;
  ArrayList<Bullet> bullets;
  ArrayList<Fairy> masters;
  float bestFit;
  float maxDist = 400;

  World() {
    fairies = new ArrayList<Fairy>();
    bullets = new ArrayList<Bullet>();
    masters = new ArrayList<Fairy>();
    bestFit = 0;
  }
  
  void add(){
    fairies.add(new Fairy(random(-width/2,width/2), random(-height/2,height/2)));
  }
  
  void add(int n){
    while(n-->0)
      fairies.add(new Fairy(random(-width/2,width/2), random(-height/2,height/2)));
  }

  void update() {
    for (Fairy f : fairies) f.update();
    for (Bullet b : bullets) b.update();
    
    for(int i=bullets.size()-1;i>=0;i--)
      if(bullets.get(i).distToOwner() > maxDist)
        bullets.remove(i);
    
    for(Fairy f : fairies)
      for(int i=bullets.size()-1;i>=0;i--)
        if(bullets.get(i).isCollide(f)){
          f.hp -= bullets.get(i).damage;
          f.lastHit = bullets.get(i).owner;
          bullets.remove(i);
        }
    
    for(int i=fairies.size()-1;i>=0;i--)
      if(fairies.get(i).isDead()){
        if(fairies.get(i).lastHit != null)
          fairies.get(i).lastHit.motivation += 100;
        fairies.remove(i);
        add();
      }
  }

  void show() {
    for (Fairy f : fairies) f.show();
    for (Bullet b : bullets)b.show();
  }
}
