abstract class Bullet extends PVector{
  PVector vel = new PVector();
  PVector accel = new PVector();
  Fairy owner;
  String formation;
  float damage;
  float minSpeed =  1;
  float maxSpeed = 10;
  
  Bullet(Fairy owner, float damage){
    this.owner = owner;
    this.damage= damage;
    this.set(owner);
  }
  
  Bullet(Fairy owner, float damage, String formation){
    this.owner = owner;
    this.damage= damage;
    this.formation = formation;
    this.set(owner);
  }
  
  abstract Boolean isCollide(Fairy o);
  abstract void show();
  abstract Bullet copyData();
  
  void update(){
    vel.add(accel);
    this.add(vel);
  }
  
  float distToOwner(){
    return this.dist(owner);
  }
  
  String toString(){
    String text = "{";
    text += "Owner: " + owner.name + ", ";
    text += "Location: [" + x + ", " + y + "], ";
    text += "Formation: " + formation;
    
    return text + "}";
  }
}
