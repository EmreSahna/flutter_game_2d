import 'package:flutter/material.dart';
import 'initalize.dart';
import 'dart:math';

class Game extends StatefulWidget{
  const Game({super.key});
  @override
  State<StatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends State<Game>{
  var currentStage = 1;
  bool isGameEnded = true;
  bool isGameEndedWithWon = true;

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    var defaultSettings = ModalRoute.of(context)!.settings.arguments as DefaultSettings;

    bool checkStage(){
      return defaultSettings.stages < currentStage ? true : false;
    }

    bool checkCharacter(){
      return defaultSettings.character.health! > 0 ? true : false;
    }

    bool checkMob(){
      return defaultSettings.enemy.health! > 0 ? true : false;
    }

    void gameLogic1(){
      setState(() {
        defaultSettings.enemy.health = defaultSettings.enemy.health! - defaultSettings.character.damage!;
      });
      if(!checkMob()){
        setState(() {
          defaultSettings.enemy.health = 10;
          currentStage = currentStage + 1;
        });
        if(checkStage()){
          setState(() {
            isGameEnded = false;
            isGameEndedWithWon = true;
          });
        }
      }
    }

    void gameLogic2(){
      if(Random().nextInt(2) == 1){
        setState(() {
          defaultSettings.character.health = defaultSettings.character.health! - (defaultSettings.enemy.damage! + defaultSettings.difficulty.index);        
        });
      }else{
        setState(() {
          defaultSettings.enemy.health = defaultSettings.enemy.health! + (defaultSettings.enemy.damage! + defaultSettings.difficulty.index);        
        });
      }
      if(!checkCharacter()){
        setState(() {
          isGameEnded = false;
          isGameEndedWithWon = false;
        });
      }
    }

    void gameLogic3(){
      setState(() {
        defaultSettings.character.health = defaultSettings.character.health! + defaultSettings.character.damage!;
      });
    }

    void doAttack(){
      gameLogic1();
      gameLogic2();
    }

    void doHeal(){
      gameLogic3();
      gameLogic2();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: isGameEnded ? Column(
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
                      doHeal();
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
      ) 
      : 
      Center(
        child: ( Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isGameEndedWithWon ? const Text('You Won!', style: TextStyle(color: Colors.amber, fontSize: 55)) : const Text('You Lose!', style: TextStyle(color: Colors.amber, fontSize: 55)),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(fontSize: 30,fontFamily: 'Jost'),
                  ),
                ),
                onPressed: () {
                  if(defaultSettings.character.getClass() == 'Knight'){
                    defaultSettings.character = Knight(50, 3);
                  }else{
                    defaultSettings.character = Elf(45, 4);
                  }
                  setState(() {
                    defaultSettings.enemy.health = 10;
                  });
                  Navigator.pop(context);
                }, 
                child: const Text('Main Menu'),
              ),
            ]
          )
        ),
      ) 
    );
  }
}