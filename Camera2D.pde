class Camera2D{
  float x;
  float y;
  float scale;
  char panKey;
  char lastKey;
  Boolean isPanKey;
  PVector mouse;
  
  Camera2D(){
    x = width/2;
    y = height/2;
    scale = 1;
    panKey = ' ';
    isPanKey = false;
    mouse = new PVector();
  }
  
  void updateMouse(){
    mouse.x = (mouseX- width/2)/scale +  width/2 - this.x;
    mouse.y = (mouseY-height/2)/scale + height/2 - this.y;
  }
  
  void transPoint(PVector point){
    point.x = (point.x- width/2)/scale +  width/2 - this.x;
    point.y = (point.y-height/2)/scale + height/2 - this.y;
  }
  
  void scrollMode(MouseEvent e){
    if(isPanKey)
      scale -= e.getCount()*0.1*scale;
  }
  
  void run(){
    input();
    update();
  }
  
  void input(){
    if(keyPressed){
      if(lastKey != key)
        if(key == panKey)
          isPanKey = !isPanKey;
      lastKey = key;
    } else {
      isPanKey = false;
      lastKey = 0;
    }
    
    if(isPanKey && mousePressed && mouseButton == LEFT){
      x += (mouseX-pmouseX)/scale;
      y += (mouseY-pmouseY)/scale;
    }
  }
  
  void update(){
    updateMouse();
    translate(width/2,height/2);
    scale(scale);
    translate(-width/2,-height/2);
    translate(x,y);
  }
}
