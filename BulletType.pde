enum BulletType{
  ROUND_S(0),
  ROUND_M(1),
  ROUND_B(2),
  KUNAI(3);
  
  int value;
  private BulletType(int x){value = x;}
  static BulletType get(int value){
    switch(value){
      case 0: return ROUND_S;
      case 1: return ROUND_M;
      case 2: return ROUND_B;
      case 3: return KUNAI;
    }
    return null;
  }
}
