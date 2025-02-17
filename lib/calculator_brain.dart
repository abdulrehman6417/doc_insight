import 'dart:math';

class CalculatorBrain {
  CalculatorBrain({this.weight, this.height});

  final int? height;
  final int? weight;
  late double _bmi;

  String bmiCalculation() {
    _bmi = (weight! / pow(height! / 100, 2));
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25.0) {
      return 'Overweight';
    } else if (_bmi > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getDesc() {
    if (_bmi >= 25.0) {
      return 'Your body weight is more than Normal, perhaps exercise more!';
    } else if (_bmi > 18.5) {
      return 'Congrats! You have a good body Weight.';
    } else {
      return 'Your body weight is less than normal, try to eat more.';
    }
  }
}
