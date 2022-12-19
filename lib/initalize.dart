import 'dart:math';

enum Difficulty {
  easy,
  normal,
  hard
}

class DefaultSettings {
  String username = "Maceraci";
  int stages = 10;
  Difficulty difficulty = Difficulty.easy;
  GameObject character = Knight(50, 10);
  Enemy enemy = Enemy(10, 5);
}

abstract class GameObject{
  int? health;
  int? damage;
  String imagePath();
  GameObject(this.health, this.damage);
  int hit();
  int heal();
  String getClass();
}

class Elf extends GameObject{
  Elf(super.health, super.damage);
  
  @override
  int heal() {
    int heal = health!~/3;
    return Random().nextInt(heal+1); 
  }
  
  @override
  int hit() {
    return Random().nextInt(15) + (damage!);
  }

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
  int heal() {
    int heal = health!~/3;
    return Random().nextInt(heal+1);  
  }
  
  @override
  int hit() {
    return Random().nextInt(5) + (damage!);
  }

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
  set health(int? _health) {
    super.health = _health;
  }

  @override
  int heal() {
    int heal = health!~/3;
    return Random().nextInt(heal+1); 
  }

  @override
  int hit() {
    return Random().nextInt(10) + (damage!);
  }

  @override 
  String getClass(){
    return "Enemy";
  }

  @override
  String imagePath() {
    return 'assets/images/bat.gif';
  }
}