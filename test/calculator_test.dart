// TYPE OF TEST:
// Unit: Logic of some function
// Widget: button or any functionality related to the widget
// Integretaion: whole system is workin

import 'package:flutter_demo/ui/demos/3_state_management_demo/state_management_manager.dart';
import 'package:flutter_demo/ui/demos/7_testing/calculator_manager.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  test('Default answer is 0', () {
    final manager = CalculatorManager();
    final answer = manager.answerNotifier.value;
    expect(answer, 0);
    
  });



  test('Adding two numbers gives correct asnwer', () {
    final manager = CalculatorManager();
    manager.add('1', '2');
    final answer = manager.answerNotifier.value;
    expect(answer, 3);
    
  });

  test('If the user enters a string then throw exception', () {
    final manager = CalculatorManager();
   
    expect(() =>  manager.add('abc', '2'), throwsFormatException);
  });

}