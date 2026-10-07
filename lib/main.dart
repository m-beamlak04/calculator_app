import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = '0';

  void inputDigit(String digit) {
    setState(() {
      if (display == '0') {
        display = digit;
      } else {
        display += digit;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: Text(
                display,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => inputDigit('7'),
                        child: const Text('7'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => inputDigit('8'),
                        child: const Text('8'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => inputDigit('9'),
                        child: const Text('9'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('÷'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => inputDigit('4'),
                        child: const Text('4'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => inputDigit('5'),
                        child: const Text('5'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => inputDigit('6'),
                        child: const Text('6'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('×'),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => inputDigit('1'),
                        child: const Text('1'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => inputDigit('2'),
                        child: const Text('2'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => inputDigit('3'),
                        child: const Text('3'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('-'),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => inputDigit('0'),
                        child: const Text('0'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('+'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('='),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
