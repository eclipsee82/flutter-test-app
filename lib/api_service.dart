import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:translator/translator.dart'; // Импортируем плагин для перевода

class ApiService {
  static Future<Map<String, String>> fetchQuote() async {
    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/quotes/random'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final quote = data['quote'];
        final author = data['author'];

        // Переводим цитату и автора на русский
        final translatedQuote = await _translateText(quote, 'en', 'ru');
        final translatedAuthor = await _translateText(author, 'en', 'ru');

        return {'quote': translatedQuote, 'author': translatedAuthor};
      } else {
        print('Ошибка: ${response.statusCode}');
        return {'quote': 'Ошибка при загрузке цитаты', 'author': ''};
      }
    } catch (error) {
      print('Ошибка: $error');
      return {'quote': 'Ошибка при загрузке цитаты', 'author': ''};
    }
  }

  static Future<String> _translateText(String text, String sourceLang, String targetLang) async {
    final translator = GoogleTranslator();
    final translation = await translator.translate(text, from: sourceLang, to: targetLang);
    return translation.text ?? '';
  }
}
