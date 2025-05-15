import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final historyProvider = StateProvider<List<String>>((ref) => []);
final resultProvider = StateProvider<String>((ref) => '');

final palindromeControllerProvider =
    StateNotifierProvider<PalindromeController, void>((ref) {
  return PalindromeController(ref);
});

class PalindromeController extends StateNotifier<void> {
  final Ref ref;
  PalindromeController(this.ref) : super(null) {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('palindrome_history') ?? [];
    ref.read(historyProvider.notifier).state = stored;
  }

  Future<void> _saveHistory(List<String> history) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('palindrome_history', history);
  }

  void checkPalindrome(String input) {
    final cleaned = input.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    final isPalindrome = cleaned == cleaned.split('').reversed.join();
    final result = isPalindrome
        ? '✅ "$input" is a palindrome.'
        : '❌ "$input" is not a palindrome.';

    final updatedHistory = [result, ...ref.read(historyProvider)];
    ref.read(historyProvider.notifier).state = updatedHistory;
    ref.read(resultProvider.notifier).state = result;
    _saveHistory(updatedHistory);
  }

  void clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('palindrome_history');
    ref.read(historyProvider.notifier).state = [];
    ref.read(resultProvider.notifier).state = '';
  }
}