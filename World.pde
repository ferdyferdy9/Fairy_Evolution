class World {
  ArrayList<Fairy> fairies;
  ArrayList<Bullet> bullets;
  ArrayList<Fairy> masters;
  float bestFit;
  float maxDist = 200;

  World() {
    fairies = new ArrayList<Fairy>();
    bullets = new ArrayList<Bullet>();
    masters = new ArrayList<Fairy>();
    bestFit = 0;
  }
  
  void add(){
    fairies.add(new Fairy(random(width), random(height)));
  }
  
  void add(int n){
    while(n-->0)
      fairies.add(new Fairy(random(width), random(height)));
  }

  void update() {
    for (Fairy f : fairies) f.update();
    for (Bullet b : bullets) b.update();
  }

  void show() {
    for (Fairy f : fairies) f.show();
    for (Bullet b : bullets) b.show();
  }
}
