enum Difficulty {
  easy,
  normal,
  hard
}

class DefaultSettings {
  String username = "Maceraci";
  int stages = 10;
  Difficulty difficulty = Difficulty.easy;
  GameObject character = Knight(50, 3);
  Enemy enemy = Enemy(10, 2);
}

abstract class GameObject{
  int? health;
  int? damage;
  String imagePath();
  GameObject(this.health, this.damage);
  String getClass();
}

class Elf extends GameObject{
  Elf(super.health, super.damage);

  @override 
  String getClass(){
    return "Elf";
  }
  
  @override
  String imagePath() {
    return 'assets/images/elf.png';
  }
}

class Knight extends GameObject{
  Knight(super.health, super.damage);

  @override 
  String getClass(){
    return "Knight";
  }

  @override
  String imagePath() {
    return 'assets/images/knight.png';
  }
}

class Enemy extends GameObject{
  Enemy(super.health, super.damage);

  @override 
  String getClass(){
    return "Enemy";
  }

  @override
  String imagePath() {
    return 'assets/images/bat.gif';
  }
}