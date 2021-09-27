part of '../../code-gen.dart';

extension CapExtension on String {
  // String get inCaps =>
  //     this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  // String get allInCaps => this.toUpperCase();
  // String get capitalizeFirstofEach => this
  //     .replaceAll(RegExp(' +'), ' ')
  //     .split(" ")
  //     .map((str) => str.inCaps)
  //     .join(" ");
  String get toBase64Decode => utf8.decode(base64.decode(this));
  String get toBase64Encode => base64.encode(utf8.encode(this));
  // String get toCamelCase => this
  //     .toLowerCase()
  //     .replaceAll('"', "")
  //     .capitalizeFirstofEach
  //     .replaceAll(" ", "");
  // String get toCamelCase => this
  //     .toLowerCase()
  //     .replaceAll('"', "")
  //     .capitalizeFirstofEach
  //     .replaceAll(" ", "")
  //     .replaceFirst(this[0].toUpperCase(), this[0].toLowerCase());
  // String get toSnackString => this.replaceAll(" ", "_").toLowerCase();
  String get toCamelCase => ReCase(this).camelCase; //camelCase
  String get toConstantCase => ReCase(this).constantCase; //CONSTANT_CASE
  String get toSentenceCase => ReCase(this).sentenceCase; //Sentence case
  String get toSnakeCase => ReCase(this).snakeCase; //snake_case
  String get toDotCase => ReCase(this).dotCase; //dot.case
  String get toParamCase => ReCase(this).paramCase; //param-case
  String get toPathCase => ReCase(this).pathCase; //path/case
  String get toPascalCase => ReCase(this).pascalCase; //PascalCase
  String get toHeaderCase => ReCase(this).headerCase; //Header-Case
  String get toTitleCase => ReCase(this).titleCase; //Title Case

  String get toColorBlack => "\x1B[30m$this\x1B[0m";
  String get toColorRed => "\x1B[31m$this\x1B[0m";
  String get toColorGreen => "\x1B[32m$this\x1B[0m";
  String get toColorYellow => "\x1B[33m$this\x1B[0m";
  String get toColorBlue => "\x1B[34m$this\x1B[0m";
  String get toColorMagenta => "\x1B[35m$this\x1B[0m";
  String get toColorCyan => "\x1B[36m$this\x1B[0m";
  String get toColorWhite => "\x1B[37m$this\x1B[0m";
}
/*
Black:   \x1B[30m
Red:     \x1B[31m
Green:   \x1B[32m
Yellow:  \x1B[33m
Blue:    \x1B[34m
Magenta: \x1B[35m
Cyan:    \x1B[36m
White:   \x1B[37m
Reset:   \x1B[0m
*/