Camera2D cam;
World world;

void test(){
  FairyDNA dna = new FairyDNA();
  world.fairies.add(new Fairy(width/2,height/4, dna));
  world.maxDist = 500;
}

void setup() {
  size(1200, 800);
  cam = new Camera2D();
  world = new World();
  //test();
  world.add(100);
}

void draw() {
  background(0);
  cam.run();
  
  world.test();
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
    world.bullets.clear();
    world.isDisabled = true;
    for(int i=0;i<600;i++){
      world.test();
      world.update();
    }
  }
  if(key == 'z'){
    world.scopeMode = !world.scopeMode;
  }
}

void keyReleased(){
  world.isDisabled = false;
}

void mouseWheel(MouseEvent event){
  cam.scrollMode(event);
}
