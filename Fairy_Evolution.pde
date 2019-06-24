Camera2D cam;
World world;
Fairy target;

void setup() {
  size(1200, 800);
  cam = new Camera2D();
  world = new World();
  world.add(10);
}

void draw() {
  background(0);
  cam.run();
  
  world.update();
  world.show();
  
  if(target != null){
    cam.follow(target);
    stroke(255);
    noFill();
    ellipse(target.x,target.y,100,100);
  }
  
  //println(frameRate); //<>//
}

void mousePressed(){
  PVector mouse = cam.mouse;
  for(Fairy f : world.fairies)
    if(mouse.dist(f) < 20){
      if(target == null)
        target = f;
      else
        target = null;
    }
}

void keyPressed(){
  if(key == 'c'){
    for(int i=0;i<600;i++){
      world.bullets.clear();
      world.update();
    }
  }
}

void mouseWheel(MouseEvent event){
  cam.scrollMode(event);
}
