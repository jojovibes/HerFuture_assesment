import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Palindrome Checker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  bool _isPalindrome(String input) {
    final cleaned = input.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), ''); // preprocessing the input (removes all non-alphanumeric characters and converts to lowercase)
    return cleaned == cleaned.split('').reversed.join(); //checks if the cleaned string is equal to its reverse
  }

  void _checkPalindrome() {
    final input = _controller.text;
    final isPalindrome = _isPalindrome(input); //actual check
    final result = isPalindrome ? '✅ "$input" is a palindrome.' : '❌ "$input" is not a palindrome.';

    setState(() {
      _result = result;
    }); // updates state

    _controller.clear(); //clears the text field
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Palindrome Checker'),
      ),
      body: Column(
        children:[
          TextField(
            controller: _controller,
          ),
          ElevatedButton(onPressed: _checkPalindrome, child: const Text('Submit')),
          Text(_result),
        ],
      ),
    );
  }
}
