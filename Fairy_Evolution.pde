Camera2D cam;
World world;

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
  
  //println(frameRate);
}

void mousePressed(){
  PVector mouse = new PVector(mouseX,mouseY);
  for(Fairy f : world.fairies)
    if(mouse.dist(f) < 20)
      println(f.dna); //<>//
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
