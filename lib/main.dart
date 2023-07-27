import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '0';
  String _buffer = '';
  String _operator = '';
  double _result = 0;
  void _updateOutput() {
    if (_buffer.isEmpty) {
      _output = '0';
    } else {
      _output = _buffer;
    }
  }
  void _updateScreen(String str){
    setState(() {
      _output=str;
    });
  }

  void _calculate() {
    double num1 = _result;
    double num2 = double.parse(_buffer);

    switch (_operator) {
      case '+':
        _result = num1 + num2;
        break;
      case '-':
        _result = num1 - num2;
        break;
      case '*':
        _result = num1 * num2;
        break;
      case '/':
        _result = num1 / num2;
        break;
    }

    _output = _result.toString();
    _buffer = '';
    _operator = '';
  }

  void _onNumberPressed(String value) {
    setState(() {
      _buffer += value;
      _output = _buffer; // Show inputs in the text box
    });
  }

  void _onOperatorPressed(String value) {
    if (_buffer.isNotEmpty) {
      if (_operator.isNotEmpty) {
        _calculate();
        _output = "$_result $value"; // Show inputs and the current operator
        _buffer = _output;
      } else {
        _result = double.parse(_buffer);
        _buffer = '';
        _output = "$_result $value"; // Show inputs and the current operator
      }
      _operator = value;
    }
  }

  void _onEqualsPressed() {
    if (_buffer.isNotEmpty && _operator.isNotEmpty) {
      _calculate();
      _buffer = _output; // Update _buffer to hold the final result
      _output = _result.toString(); // Update _output to show the final result
      _updateScreen(_output);
    }
  }

  void _onClearPressed() {
    setState(() {
      _output = _buffer;
      _buffer = '';
      _operator = '';
      _result = 0;
    });
  }

  void _onBackspacePressed() {
    if (_buffer.isNotEmpty) {
      setState(() {
        _buffer = _buffer.substring(0, _buffer.length - 1);
        _updateOutput();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.topRight,
              child: Text(_output,
                  style: const TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 230, 223, 223))),
            ),
          ),
          const Divider(
            height: 0,
            color: Colors.blue,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildClearButton(),
              _buildBackspaceButton(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildOperatorButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildOperatorButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildOperatorButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('.'),
              _buildButton('0'),
              _buildEqualsButton(),
              _buildOperatorButton('+'),
            ],
          ),
          const Divider(height: 0),
        ],
      ),
    );
  }

  Widget _buildButton(String value) {
    return ElevatedButton(
      onPressed: () => _onNumberPressed(value),
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 30),
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        minimumSize: const Size.fromRadius(45),
      ),
      child: Text(value),
    );
  }

  Widget _buildOperatorButton(String value) {
    return ElevatedButton(
      onPressed: () => _onOperatorPressed(value),
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 30),
          backgroundColor: Colors.blueGrey,
          shape: const CircleBorder(),
          minimumSize: const Size.fromRadius(45)),
      child: Text(value),
    );
  }

  Widget _buildEqualsButton() {
    return ElevatedButton(
      onPressed: _onEqualsPressed,
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 30),
          backgroundColor: Colors.green,
          minimumSize: const Size.fromRadius(45),
          shape: const CircleBorder()),
      child: const Text('='),
    );
  }

  Widget _buildClearButton() {
    return ElevatedButton(
      onPressed: _onClearPressed,
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 30),
          backgroundColor: Colors.blue,
          shape: const CircleBorder(),
          minimumSize: const Size.fromRadius(45)),
      child: const Icon(Icons.clear),
    );
  }

  Widget _buildBackspaceButton() {
    return ElevatedButton(
      onPressed: _onBackspacePressed,
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 30),
          backgroundColor: Colors.blue,
          shape: const CircleBorder(),
          minimumSize: const Size.fromRadius(45)),
      child: const Icon(Icons.backspace_rounded),
    );
  }
}
