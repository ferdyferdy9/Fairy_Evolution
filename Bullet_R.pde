class Bullet_R extends Bullet{
  float radius;
  color c;
  
  Bullet_R(Fairy owner, float damage, float radius, color c){
    super(owner,damage);
    this.radius = radius;
    this.c = c;
  }
  
  Bullet_R(Fairy owner, float damage, String formation, float radius, color c){
    super(owner,damage,formation);
    this.radius = radius;
    this.c = c;
  }
  
  Boolean isCollide(Fairy o){
    
    return false;
  }
  
  void show(){
    stroke(255);
    fill(c);
    ellipse(x,y,radius*2,radius*2);
  }
  
  Bullet copyData(){
    return new Bullet_R(owner, damage, formation, radius, c);
  }
}
