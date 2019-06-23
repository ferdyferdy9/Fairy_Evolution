class ShotDNA{
  int amount;
  float spreadRad;
  ShotType shotType;
  BulletType bulletType;
  float maxSpeed;
  PVector accel;
  color c;
  float duration;
  
  ShotDNA(){
    amount     = floor(random(1,6)); // 1-5
    spreadRad  = random(0,PI);
    shotType   = ShotType.get(floor(random(2))); // 0-1
    bulletType = BulletType.get(floor(random(3))); // 0-2
    maxSpeed   = random(0.5,6);
    accel      = PVector.random2D().mult(random(0, 0.01));
    int r = floor(random(256));
    int g = floor(random(256));
    int b = floor(random(256));
    c = color(r,g,b);
    duration   = floor(random(21));
  }
  
  ShotDNA(
    int n,
    float sr,
    ShotType st, 
    BulletType bt, 
    float maxSpeed, 
    PVector accel, 
    color c, 
    float d
  ) {
    amount = n;
    spreadRad = sr;
    shotType = st;
    bulletType = bt;
    this.maxSpeed = maxSpeed;
    this.accel = accel;
    this.c = c;
    duration = d;
  }
  
  ShotDNA copyData(){
    return new ShotDNA(
      amount,
      spreadRad,
      shotType,
      bulletType,
      maxSpeed,
      accel.copy(),
      c,
      duration
    );
  }
  
  void mutate(){
    amount     = floor(random(1,11)); // 1-10
    duration   = floor(random(61));
    
    if(random(1) < 0.25){
      spreadRad  = random(0,PI);
      maxSpeed   = random(0.5,2);
      accel      = PVector.random2D().mult(random(0, 0.01));
    }
    
    if(random(1) < 0.1)
      shotType   = ShotType.get(floor(random(2))); // 0-1
    if(random(1) < 0.1)
      bulletType = BulletType.get(floor(random(3))); // 0-2
  }
  
  String toString(){
    String text="{";
    text += amount + ",";
    text += spreadRad + ",";
    text += shotType.value + ",";
    text += bulletType.value + ",";
    text += maxSpeed + ",";
    text += "["+accel.x+","+accel.y+"],";
    text += c + ",";
    text += duration + "}";
    return text;
  }
}
