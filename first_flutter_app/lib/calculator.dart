import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "";
  String _input = "";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _input = '';
        _output = '0';
      } else if (buttonText == "=") {
        _output = _calculateResult(_input);
      } else {
        _input += buttonText;
      }
    });
  }

  String _calculateResult(String input) {
    try {
      input = input.replaceAll('x', '*').replaceAll('÷', '/');

      final result = _evaluateExpression(input);

      return result.toString();
    } catch (e) {
      return "Error";
    }
  }

  double _evaluateExpression(String expression) {

    final regExp = RegExp(r'(\d+\.?\d*)([+\-*/÷])(\d+\.?\d*)');
    while (regExp.hasMatch(expression)) {
      final match = regExp.firstMatch(expression);
      if (match != null) {
        double num1 = double.parse(match.group(1)!);
        String operator = match.group(2)!;
        double num2 = double.parse(match.group(3)!);

        double result;
        if (operator == '+') {
          result = num1 + num2;
        } else if (operator == '-') {
          result = num1 - num2;
        } else if (operator == '*') {
          result = num1 * num2;
        } else if (operator == '/') {
          result = num1 / num2;
        } else {
          throw FormatException('Invalid operator');
        }

        expression = expression.replaceRange(match.start, match.end, result.toString());
      }
    }

    return double.parse(expression);
  }

  Widget calculatorButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => buttonPressed(buttonText),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(30),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _input,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _output,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(height: 2),
          Row(
            children: <Widget>[
              calculatorButton("7"),
              calculatorButton("8"),
              calculatorButton("9"),
              calculatorButton("÷"),
            ],
          ),
          Row(
            children: <Widget>[
              calculatorButton("4"),
              calculatorButton("5"),
              calculatorButton("6"),
              calculatorButton("x"),
            ],
          ),
          Row(
            children: <Widget>[
              calculatorButton("1"),
              calculatorButton("2"),
              calculatorButton("3"),
              calculatorButton("-"),
            ],
          ),
          Row(
            children: <Widget>[
              calculatorButton("0"),
              calculatorButton("."),
              calculatorButton("="),
              calculatorButton("+"),
            ],
          ),
          Row(
            children: <Widget>[
              calculatorButton("C"),
            ],
          ),
        ],
      ),
    );
  }
}
