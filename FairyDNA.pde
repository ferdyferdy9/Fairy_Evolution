class FairyDNA{
  float hpSpeed;
  float manaRegen;
  float enemyRad;
  float idealRad;
  float bulletRad;
  float laserRad;
  ShotDNA[] bullets;
  
  FairyDNA(){
    hpSpeed   = random(1);
    manaRegen = random(1);
    enemyRad  = random(100);
    idealRad  = random(100);
    bulletRad = random(100);
    laserRad  = random(100);
    
    bullets = new ShotDNA[world.bulletVar];
    for(int i=0;i<bullets.length;i++){
      bullets[i] = new ShotDNA();
    }
  }
  
  FairyDNA(
    float hpSpeed,
    float manaRegen,
    float enemyRad,
    float idealRad,
    float bulletRad,
    float laserRad,
    ShotDNA[] bullets
  ) {
    this.hpSpeed = hpSpeed;
    this.manaRegen = manaRegen;
    this.enemyRad  = enemyRad;
    this.idealRad  = idealRad;
    this.bulletRad = bulletRad;
    this.laserRad  = laserRad;
    this.bullets = new ShotDNA[bullets.length];
    for(int i=0;i<bullets.length;i++){
      this.bullets[i] = bullets[i].copyData();
    }
  }
  
  FairyDNA copyData(){
    return new FairyDNA(
      hpSpeed,
      manaRegen,
      enemyRad,
      idealRad,
      bulletRad,
      laserRad,
      bullets
    );
  }
  
  FairyDNA mutate(){
    hpSpeed   = random(1);
    manaRegen = random(1);
    for(int i=0; i<bullets.length;i++)
      if(random(1) < 0.25)
        bullets[i].mutate();
    return this;
  }
  
  FairyDNA(String dna){
    int count=-2;
    int dnaLength=dna.length();
    for(int i=0; i<dnaLength; i++)
      if(dna.charAt(i) == '{')
        count++;
    
    String[] list = splitTokens(dna, " ,[]{}" );
    
    hpSpeed   = float(list[0]);
    manaRegen = float(list[1]);
    enemyRad  = float(list[2]);
    idealRad  = float(list[3]);
    bulletRad = float(list[4]);
    laserRad  = float(list[5]);
    
    bullets = new ShotDNA[count];
    for(int i=0;i<count;i++){
      bullets[i] = new ShotDNA();
      bullets[i].amount     = int  (list[6+i*9]);
      bullets[i].spreadRad  = float(list[7+i*9]);
      bullets[i].shotType   = ShotType.get  (int(list[8+i*9]));
      bullets[i].bulletType = BulletType.get(int(list[9+i*9]));
      bullets[i].maxSpeed   = float(list[10+i*9]);
      bullets[i].accel.x    = float(list[11+i*9]);
      bullets[i].accel.y    = float(list[12+i*9]);
      bullets[i].c          = int  (list[13+i*9]);
      bullets[i].duration   = float(list[14+i*9]);
    }
  }
  
  String toString(){
    String text="{";
    text += hpSpeed + ",";
    text += manaRegen + ",";
    text += enemyRad + ",";
    text += idealRad + ",";
    text += bulletRad + ",";
    text += laserRad + ",{";
    for(int i=0;i<bullets.length-1;i++)
      text+= bullets[i] + ",";
    text += bullets[bullets.length-1] + "}}";
    
    return text;
  }
}
