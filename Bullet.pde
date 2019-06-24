class Bullet extends PVector{
  PVector vel = new PVector();
  PVector accel = new PVector();
  Fairy owner;
  float damage;
  float minSpeed =  1;
  float maxSpeed = 10;
  
  Bullet(Fairy owner, float damage){
    this.owner = owner;
    this.damage= damage;
    this.set(owner);
  }
  
  Boolean isCollide(Fairy o){
    
    return false;
  }
  
  float distToOwner(){
    return this.dist(owner);
  }
  
  void update(){
    vel.add(accel);
    this.add(vel);
  }
  
  void show(){
    
  }
}
