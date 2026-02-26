import 'dart:math';

import 'package:flutter/material.dart';

class StateManagementDemo extends StatefulWidget {
  const StateManagementDemo({super.key});

  @override
  State<StateManagementDemo> createState() => _StateManagementDemoState();
}

class _StateManagementDemoState extends State<StateManagementDemo> {
  
  final colors_list = [
    Colors.teal, 
    Colors.deepOrange, 
    Colors.lightGreen, 
    Colors.limeAccent, 
    Colors.cyan, 
    Colors.pinkAccent, 
    Colors.amber, 
    Colors.green, 
    Colors.indigo, 
    Colors.lightBlueAccent];

  final colorIndexNotifier = ValueNotifier(0);
  final numberNotifier = ValueNotifier<int>(1);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('State Management')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
           children: [

              const SizedBox(height: 16),

            ValueListenableBuilder(
              valueListenable: colorIndexNotifier,
              builder: (context, colorIndex, child) {

                return Container(
                  
                  color: colors_list[colorIndex],
                  width: 200,
                  height: 200,
                
                  child: Center( 
                    child: ValueListenableBuilder(
                      valueListenable: numberNotifier,
                      builder: (context, number, child) {
                        return Text('$number', style: TextStyle(fontSize: 24));
                      }
                    ), 
                    ),  
                    
                    
                
                
                 
                );
              }
            ),

            
            


              const SizedBox(height: 16),

            // Buttons for state

            OutlinedButton(onPressed: changeColor, child: Text("Change Color")),

              const SizedBox(height: 16),

             OutlinedButton(onPressed: changeText, child: Text("Change Text")),

           ],
           ),
        ),
      ),
    );
  }





  void changeColor() {

    colorIndexNotifier.value++;
    colorIndexNotifier.value = colorIndexNotifier.value % colors_list.length;

  }

  void changeText() {
    numberNotifier.value++;

  }

}