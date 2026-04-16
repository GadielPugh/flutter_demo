import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/demos/7_testing/calculator_manager.dart';

class CalculatorDemo extends StatefulWidget {
  const CalculatorDemo({super.key});

  @override
  State <CalculatorDemo> createState() =>  CalculatorDemoState();
}

class  CalculatorDemoState extends State<CalculatorDemo> {
  final manager = CalculatorManager();
  final firstController = TextEditingController();
  final secondController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Row(
            children: [
              TextField(
                controller: firstController,
              ), 
              SizedBox(width: 10,),
              Text('+'), 
              SizedBox(width: 10,),
              TextField(
                controller: secondController,
              ), 
              SizedBox(width: 10,),
              Text('='), 
              SizedBox(width: 10,),
              ValueListenableBuilder(
                valueListenable: manager.answerNotifier,
                builder: (context, asnwer, child) {
                  return Text('$asnwer');
                }
              ),
              ElevatedButton(onPressed: (){
                manager.add(firstController.text, secondController.text);
              }, child: Text('Calculated'))
            ],
            
          ),
        ),
    );
  }
}