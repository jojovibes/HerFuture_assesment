import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/palindrome_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider);
    final result = ref.watch(resultProvider);
    final controller = ref.read(palindromeControllerProvider.notifier);
    final textController = TextEditingController();
    final focusNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Palindrome Checker'),
        actions: [
          TextButton.icon(
            onPressed: controller.clearHistory,
            icon: const Icon(Icons.delete),
            label: Text(
              'Clear History',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter text',
                hintText: 'Type something...',
              ),
              controller: textController,
              onSubmitted: (_) {
                controller.checkPalindrome(textController.text);
                textController.clear();
                focusNode.requestFocus();
              },
              focusNode: focusNode,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                controller.checkPalindrome(textController.text);
                textController.clear();
                focusNode.requestFocus();
              },
              child: const Text('Submit'),
            ),
            Text(result),
            Expanded(
              child: ListView(
                children: history
                    .map((item) => ListTile(title: Text(item)))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
