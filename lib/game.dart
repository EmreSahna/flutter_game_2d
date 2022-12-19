import 'package:flutter/material.dart';
import 'initalize.dart';

class Game extends StatefulWidget{
  const Game({super.key});
  @override
  State<StatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends State<Game>{

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    var defaultSettings = ModalRoute.of(context)!.settings.arguments as DefaultSettings;
    var currentStage = 1;

    bool checkStage(){
      return defaultSettings.stages <= currentStage ? true : false;
    }

    bool checkCharacter(){
      return defaultSettings.character.health! > 0 ? true : false;
    }

    bool checkMob(){
      return defaultSettings.enemy.health! > 0 ? true : false;
    }

    void gameLogic(){
      if(checkCharacter()){
        if(checkMob()){
          print('mob alive');
        }else{
          print('you kill mob');
          defaultSettings.enemy.health = 10;
          if(checkStage()){
            print('finished game');
          }else{
            print('still playing');
          }
        }
      }else{
        print('reset game');
      }
    }

    void doAttack(){
      defaultSettings.enemy.health = defaultSettings.enemy.health! - defaultSettings.character.damage!;
      gameLogic();
      setState(() {
        currentStage = currentStage + 1;      
        print(currentStage);
      });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: _height * 0.3,
            width: _width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/top.webp'),
                fit: BoxFit.fill,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(defaultSettings.character.health.toString(), 
                  style: const TextStyle(color: Colors.red, 
                    fontSize: 55,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Column(
                  children: [
                    Text(currentStage.toString(),
                      style: const TextStyle(color: Colors.amber,
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(defaultSettings.username,
                      style: const TextStyle(color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
                Text(defaultSettings.enemy.health.toString(),
                  style: const TextStyle(color: Colors.red,
                    fontSize: 55,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ]
            ),
          ),
          Container(
            height: 240.0,
            width: 420.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/middle.webp'),
                fit: BoxFit.fill,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding:  EdgeInsets.only(bottom: _height * 0.025),
                  child: Image.asset(defaultSettings.character.imagePath(),scale: 0.3),
                ),
                Image.asset(defaultSettings.enemy.imagePath(), scale: 1.3,)
              ]
            ),
          ),  
          Container(
            padding: const EdgeInsets.only(bottom: 10,left: 10),
            height: _height * 0.3,
            width: _width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bottom.webp'),
                fit: BoxFit.fill,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    doAttack();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: _height*0.15,
                    width: _width*0.3,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(60)
                    ),
                    child: const Center(child: Text("Attack",style: TextStyle(color: Colors.black, fontSize: 30))),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                    });
                  },
                  child: Container(
                    height: _height*0.15,
                    width: _width*0.3,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(60)
                    ),
                    child: const Center(child: Text("Heal",style: TextStyle(color: Colors.black, fontSize: 30))),
                  ),
                ),
              ]
            ),
          )  
        ],
      ),
    );
  }
}