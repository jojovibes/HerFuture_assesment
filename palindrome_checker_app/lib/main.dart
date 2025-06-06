import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(
  ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Palindrome Checker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(194, 109, 187, 1),
        ),
      ),
      home: const HomeScreen(),
    ),
  ),
);


// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart'; //shared_preferences for persistent history on web (if other platform was wanted, use path_provider to save to a file)

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
  
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false, //hides debug banner
//       title: 'Palindrome Checker',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(194, 109, 187,1)), //color scheme set to HerFuture color
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final TextEditingController _controller = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//   final List<String> _history = [];
  
//   String _result = '';
  
//   @override
//   void initState() {
//     super.initState();
//     _loadHistory(); //load history from shared preferences
//   }

//   @override 
//   void dispose() {
//     _controller.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }

//   Future<void> _loadHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     final storedHistory = prefs.getStringList('palindrome_history') ?? []; // if history exists, load it, otherwise use an empty list
//     setState(() {
//       _history.addAll(storedHistory);
//     });
//   }

//   Future<void> _saveHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('palindrome_history', _history);
//   }

//   Future<void> _clearHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('palindrome_history');
//     setState(() {
//       _history.clear();
//       _result = '';
//     });
//   }

//   bool _isPalindrome(String input) {
//     final cleaned = input.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), ''); // preprocessing the input (removes all non-alphanumeric characters and converts to lowercase) 
//     return cleaned == cleaned.split('').reversed.join(); //checks if the cleaned string is equal to its reverse

//     // personal note: don't nod is not a palindrome, atleast not according to my dutch teacher. My favorite palindrome is partyboobytrap
//   }

//   void _checkPalindrome() {
//     final input = _controller.text;
//     final isPalindrome = _isPalindrome(input); //actual check
//     final result = isPalindrome ? '✅ "$input" is a palindrome.' : '❌ "$input" is not a palindrome.';

//     setState(() {
//       _history.insert(0, result); //add result to histroy
//       _result = result;
//     }); // updates state

//     _saveHistory(); //save history
//     _controller.clear(); //clears the text field
//     FocusScope.of(context).requestFocus(_focusNode); //sets focus text field
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(

//         appBar: AppBar(
//           backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//           title: const Text('Palindrome Checker'),
//           actions: [
//             TextButton.icon(
//               onPressed: _clearHistory,
//               icon: const Icon(Icons.delete),
//               label: Text('Clear History', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
//             ),
//           ],
//         ),

//         body: Column(
//           children:[

//             TextField(
//               decoration: const InputDecoration(
//                 contentPadding: EdgeInsets.all(16),
//                 labelText: 'Enter text',
//                 hintText: 'Type something...',
//               ),
//               controller: _controller,
//               onSubmitted: (_) => _checkPalindrome(),
//               focusNode: _focusNode,
//             ),

//             SizedBox(height: 16), // spacer
//             ElevatedButton(onPressed: _checkPalindrome, child: const Text('Submit')),

//             Text(_result),
            
//             ListView(
//               shrinkWrap: true,
//               children: _history.map((item) => ListTile(title: Text(item))).toList(),
//             ),
//           ],
//         ),
//       );
//   }
// }
