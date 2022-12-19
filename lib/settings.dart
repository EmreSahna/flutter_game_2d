import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_project/initalize.dart';

class SettingsScreen extends StatefulWidget{
  const SettingsScreen({super.key});
  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formAnahtari = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var defaultSettings = ModalRoute.of(context)!.settings.arguments as DefaultSettings;
    bool isKnightSelected = defaultSettings.character.getClass() == "Knight" ? true : false;
    Knight p1 = Knight(50, 3);
    Elf p2 = Elf(40, 4);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formAnahtari,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            defaultSettings.character = p1;
                            isKnightSelected = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(3)),
                            color: isKnightSelected ? Colors.green : Colors.black,
                          ),
                          child: Column(
                            children: [
                              Image.asset(p1.imagePath(),scale: 0.25),
                            ]
                          ),
                        )
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            defaultSettings.character = p2;
                            isKnightSelected = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(3)),
                            color: isKnightSelected ? Colors.black : Colors.green,
                          ),
                          child: Column(
                            children: [
                              Image.asset(p2.imagePath(),scale: 0.25),
                            ]
                          ),
                        )
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            defaultSettings.difficulty = Difficulty.easy;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(3)),
                            color: defaultSettings.difficulty == Difficulty.easy ? Colors.green : Colors.transparent,
                          ),
                          child: Column(
                            children: const [
                              Text('Easy',style: TextStyle(color: Colors.white, fontSize: 25)),
                            ]
                          ),
                        )
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            defaultSettings.difficulty = Difficulty.normal;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(3)),
                            color: defaultSettings.difficulty == Difficulty.normal ? Colors.green : Colors.transparent,
                          ),
                          child: Column(
                            children: const [
                              Text('Normal',style: TextStyle(color: Colors.white, fontSize: 25)),
                            ]
                          ),
                        )
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            defaultSettings.difficulty = Difficulty.hard;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(3)),
                            color: defaultSettings.difficulty == Difficulty.hard ? Colors.green : Colors.transparent,
                          ),
                          child: Column(
                            children: const [
                              Text('Hard',style: TextStyle(color: Colors.white, fontSize: 25)),
                            ]
                          ),
                        )
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 250,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.green),
                          borderRadius: BorderRadius.all(Radius.circular(3))
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        hintText: "Enter your username",
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.face,color: Colors.white),
                        filled: true,
                        fillColor: Colors.green
                      ),
                      initialValue: defaultSettings.username,
                      onSaved: (newValue) {
                        setState(() {
                          defaultSettings.username = newValue!;
                        });
                      },
                    )
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 250,
                    child: SpinBox(
                      decoration: const InputDecoration(fillColor: Colors.green,filled: true),
                      min: 1,
                      max: 25,
                      value: defaultSettings.stages.toDouble(),
                      onChanged: (value) => setState(() {
                        defaultSettings.stages = value.toInt();
                      }),
                    )
                  )
                ],
              )
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(fontSize: 30,fontFamily: 'Jost'),
                ),
              ),
              onPressed: () {
                _formAnahtari.currentState!.save();
                Navigator.pop(context);
              }, 
              child: const Text('Save'),
            ),
          ]
        )
      ),
    );
  }
}