class Bullet extends PVector{
  PVector vel = new PVector();
  PVector accel = new PVector();
  Fairy owner;
  float damage;
  float minSpeed =  1;
  float maxSpeed = 10;
  
  Bullet(Fairy owner, float damage){
    super(owner.x,owner.y);
    this.owner = owner;
    this.damage= damage;
    this.set(owner);
  }
  
  Boolean isCollide(Fairy o){
    if(owner == o) return false;
    return this.dist(o) < 5;
  }
  
  float distToOwner(){
    return this.dist(owner);
  }
  
  void update(){
    vel.add(accel);
    this.add(vel);
    accel.set(0,0);
  }
  
  void show(){
    fill(255,0,0); 
    ellipse(x,y,10,10);
  }
}
