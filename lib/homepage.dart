import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_final_project/initalize.dart';

class HomePage extends StatelessWidget{
  HomePage({super.key});
  DefaultSettings defaultSettings = DefaultSettings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Dungeon Game!',textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Press Start 2P',fontSize: 45,height: 1,color: Colors.amber)
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(fontSize: 30,fontFamily: 'Jost'),
                  )
                ),
              onPressed: () {
                Navigator.pushNamed(context,'/game',arguments: defaultSettings);
              }, 
              child: const Text('Play')
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(fontSize: 30,fontFamily: 'Jost'),
                  ) 
                ),
              onPressed: () {
                Navigator.pushNamed(context,'/settings',arguments: defaultSettings);
              }, 
              child: const Text('Settings')
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(fontSize: 30,fontFamily: 'Jost'),
                  ) 
                ),
              onPressed: () {
                SystemNavigator.pop();
              }, 
              child: const Text('Exit')
            )
          ] 
        ),
      )
    );
  }
}