World world;

void setup() {
  size(1200, 800);
  world = new World();
  world.add(100);
}

void draw() {
  background(0);
  
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
