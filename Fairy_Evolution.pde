Camera2D cam;
World world;

void test(){
  FairyDNA dna = new FairyDNA("{0.42830604, 0.050981462, 48.70207, 58.332855, 5.9533, 12.699574, {{1, 2.9078753, 1, 0, 1.4027231, [ -0.005460527, 0.0016177746], -4078773, 14.0}, {5, 0.773199, 0, 1, 0.99101895, [ 0.0019397188, -0.0024558392], -13943821, 0.0}, {1, 3.0072289, 0, 2, 1.4168035, [ -0.001231754, 9.102346E-4], -3411040, 9.0}, {1, 0.8172938, 1, 1, 0.98876524, [ 0.006510358, 0.0030304282], -3469624, 14.0}, {6, 3.1303005, 0, 1, 0.7048396, [ 0.00228679, -0.0013869371], -7884174, 12.0}, {1, 2.7207222, 1, 0, 1.4017172, [ 0.0025593925, -0.0038606094], -4558103, 5.0}, {3, 2.7210689, 1, 2, 1.0728428, [ -0.005793395, 0.008106453], -13736829, 2.0}, {1, 0.6031655, 1, 1, 0.9011619, [ 9.297383E-4, -0.001934014], -12409846, 12.0}, {1, 2.292132, 1, 0, 1.5813677, [ 0.0055161254, -0.008280028], -3310101, 17.0}, {2, 2.2537427, 0, 0, 1.7598054, [ -0.009676784, 3.1316918E-4], -13120090, 4.0}}}");
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
