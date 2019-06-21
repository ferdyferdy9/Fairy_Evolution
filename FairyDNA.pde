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
    
    dna = dna.replace("{"," ");
    dna = dna.replace("}"," ");
    dna = dna.replace("["," ");
    dna = dna.replace("]"," ");
    dna = dna.replace(", "," ");
    
    Scanner s = new Scanner(dna);
    hpSpeed   = s.nextFloat();
    manaRegen = s.nextFloat();
    enemyRad  = s.nextFloat();
    idealRad  = s.nextFloat();
    bulletRad = s.nextFloat();
    laserRad  = s.nextFloat();
    
    bullets = new ShotDNA[count];
    for(int i=0;i<count;i++){
      bullets[i] = new ShotDNA();
      bullets[i].amount     = s.nextInt();
      bullets[i].spreadRad  = s.nextFloat();
      bullets[i].shotType   = ShotType.get(s.nextInt());
      bullets[i].bulletType = BulletType.get(s.nextInt());
      bullets[i].maxSpeed   = s.nextFloat();
      bullets[i].accel.x    = s.nextFloat();
      bullets[i].accel.y    = s.nextFloat();
      bullets[i].accel.z    = s.nextFloat();
      bullets[i].c          = s.nextInt();
      bullets[i].duration   = s.nextFloat();
    }
  }
  
  String toString(){
    String text="{";
    text += hpSpeed + ", ";
    text += manaRegen + ", ";
    text += enemyRad + ", ";
    text += idealRad + ", ";
    text += bulletRad + ", ";
    text += laserRad + ", {";
    for(int i=0;i<bullets.length-1;i++)
      text+= bullets[i] + ", ";
    text += bullets[bullets.length-1] + "}}";
    
    return text;
  }
}
