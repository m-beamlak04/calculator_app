import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: CalculatorPage(onToggleTheme: toggleTheme),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const CalculatorPage({super.key, required this.onToggleTheme});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = '0';
  double accumulator = 0;
  String? pendingOperator;
  bool awaitingOperand = false;

  void inputDigit(String digit) {
    setState(() {
      if (display == 'Error') {
        display = digit;
        accumulator = 0;
        pendingOperator = null;
        awaitingOperand = false;
      } else if (display == '0' || awaitingOperand) {
        display = digit;
        awaitingOperand = false;
      } else {
        display += digit;
      }
    });
  }

  void inputOperator(String operator) {
    if (display == 'Error') {
      return;
    }

    setState(() {
      if (pendingOperator != null && !awaitingOperand) {
        accumulator = calculate(
          accumulator,
          double.parse(display),
          pendingOperator!,
        );
        display = formatResult(accumulator);
        if (display == 'Error') {
          pendingOperator = null;
          awaitingOperand = true;
          return;
        }
      } else if (pendingOperator == null) {
        accumulator = double.parse(display);
      }

      pendingOperator = operator;
      awaitingOperand = true;
    });
  }

  double calculate(double a, double b, String operator) {
    switch (operator) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '×':
        return a * b;
      case '÷':
        if (b == 0) {
          return double.nan;
        }
        return a / b;
      default:
        return b;
    }
  }

  String formatResult(double value) {
    if (!value.isFinite) {
      return 'Error';
    }

    if (value == value.truncateToDouble()) {
      return value.toInt().toString();
    }

    return value.toString();
  }

  void inputEquals() {
    if (pendingOperator == null || awaitingOperand) {
      return;
    }

    setState(() {
      accumulator = calculate(
        accumulator,
        double.parse(display),
        pendingOperator!,
      );

      display = formatResult(accumulator);
      pendingOperator = null;
      awaitingOperand = true;
    });
  }

  void clearCalculator() {
    setState(() {
      display = '0';
      accumulator = 0;
      pendingOperator = null;
      awaitingOperand = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.calculate_outlined),
            SizedBox(width: 8),
            Text('Calculator'),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: widget.onToggleTheme,
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            label: Text(
              Theme.of(context).brightness == Brightness.dark
                  ? 'Dark'
                  : 'Light',
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
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
            child: ElevatedButtonTheme(
              data: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, 66),
                  textStyle: const TextStyle(fontSize: 25),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                    width: .5,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: clearCalculator,
                          child: const Text('AC'),
                        ),
                      ),
                    ],
                  ),
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
                          onPressed: () => inputOperator('÷'),
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
                          onPressed: () => inputOperator('×'),
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
                          onPressed: () => inputOperator('-'),
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
                          onPressed: () => inputOperator('+'),
                          child: const Text('+'),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: inputEquals,
                          child: const Text('='),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
