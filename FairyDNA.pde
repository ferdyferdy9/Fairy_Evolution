class FairyDNA{
  float hp, hpRegen;
  float mana, manaRegen;
  float speed;
  float idealDistance;
  
  FairyDNA(){
    hp = 10;
    hpRegen = 0.1;
    mana = 200;
    manaRegen = 0.1;
    speed = random(2,4);
    idealDistance = random(0,400);
  }
}
