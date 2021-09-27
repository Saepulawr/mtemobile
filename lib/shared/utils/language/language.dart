part of 'package:mtelektrik/config/language.dart';

Future<void> loadLanguage(AvailableLanguage language) async {
  switch (language) {
    case AvailableLanguage.english:
      lang = LanguageModel.fromJson(
          jsonDecode(await rootBundle.loadString("assets/language/en.json")));
      break;
    case AvailableLanguage.indonesia:
      lang = LanguageModel.fromJson(
          jsonDecode(await rootBundle.loadString("assets/language/id.json")));
      break;
  }
}
