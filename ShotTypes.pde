enum ShotType{
  ODD(0),
  EVEN(1),
  CIRCULAR(2);
  
  int value;
  private ShotType(int x){value = x;}
  static ShotType get(int value){
    switch(value){
      case 0: return ODD;
      case 1: return EVEN;
      case 2: return CIRCULAR;
    }
    return null;
  }
}
