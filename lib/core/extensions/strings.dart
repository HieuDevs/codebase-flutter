import 'dart:math' as math;

import 'package:codebase/shared/models/tagged_text.dart';
import 'package:codebase/utils/diacritics_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _specialCharacters = [
  "。",
  "、",
  '"',
  "'",
  "!",
  '“',
  "@",
  "#",
  "\$",
  "%",
  "^",
  "&",
  "*",
  "(",
  ")",
  "-",
  "_",
  "+",
  "=",
  "[",
  "]",
  "{",
  "}",
  "|",
  "\\",
  ";",
  ":",
  ",",
  "<",
  ".",
  ">",
  "/",
  "?",
];

extension StringExtension on String? {
  String get hardCoded => this ?? '';
  String get orEmpty => this ?? '';
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  String capitalize() {
    if (isNullOrEmpty) return '';
    return "${this![0].toUpperCase()}${this!.substring(1)}";
  }

  String toCamelCase() {
    if (isNullOrEmpty) return '';
    return '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}';
  }

  bool get isSpecialCharacter {
    if (isNullOrEmpty) return false;
    return this == ' ' || this == '　' || _specialCharacters.contains(this);
  }

  String get removeAccents {
    if (isNullOrEmpty) return '';
    return String.fromCharCodes(DiacriticsUtils.replaceCodeUnits(this!.codeUnits));
  }

  /// Converts a number to its word representation
  /// Examples: 1 -> "one", 25 -> "twenty-five", 180 -> "one hundred eighty"
  /// Converts currency format to words with "dollars"
  /// Examples: "$180" -> "one hundred eighty dollars", "$1" -> "one dollar"
  String transformWordToFormNumber() {
    if (isNullOrEmpty) return '';

    String input = this!;

    // Detect and remove currency symbols, support multiple currencies
    final currencyMap = {r'$': 'dollar', '€': 'euro', '£': 'pound', '¥': 'yen', '₩': 'won', '₫': 'dong'};

    String? currencyName;

    for (final symbol in currencyMap.keys) {
      if (input.contains(symbol)) {
        currencyName = currencyMap[symbol];
        input = input.replaceAll(symbol, '').trim();
        break;
      }
    }

    // Try to parse as number
    final number = int.tryParse(input);
    if (number != null) {
      if (currencyName != null) {
        final words = _numberToWords(number);
        // Pluralize currency name if needed
        final currency = number == 1 ? currencyName : '${currencyName}s';
        return '$words $currency';
      } else {
        return _numberToWords(number);
      }
    }

    return this!;
  }

  /// Helper method to convert number to words
  String _numberToWords(int number) {
    if (number == 0) return 'zero';
    if (number < 0) return 'negative ${_numberToWords(-number)}';

    if (number < 20) {
      return _ones[number];
    }

    if (number < 100) {
      if (number % 10 == 0) {
        return _tens[number ~/ 10];
      }
      return '${_tens[number ~/ 10]}-${_ones[number % 10]}';
    }

    if (number < 1000) {
      if (number % 100 == 0) {
        return '${_ones[number ~/ 100]} hundred';
      }
      return '${_ones[number ~/ 100]} hundred ${_numberToWords(number % 100)}';
    }

    if (number < 1000000) {
      if (number % 1000 == 0) {
        return '${_numberToWords(number ~/ 1000)} thousand';
      }
      return '${_numberToWords(number ~/ 1000)} thousand ${_numberToWords(number % 1000)}';
    }

    if (number < 1000000000) {
      if (number % 1000000 == 0) {
        return '${_numberToWords(number ~/ 1000000)} million';
      }
      return '${_numberToWords(number ~/ 1000000)} million ${_numberToWords(number % 1000000)}';
    }

    return number.toString();
  }

  // Static maps for number conversion
  static const List<String> _ones = [
    '',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen',
    'sixteen',
    'seventeen',
    'eighteen',
    'nineteen',
  ];

  static const List<String> _tens = ['', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'];

  bool compareSimilirity(String target, double percent) {
    if (this == null || this!.isEmpty || target.isEmpty) return false;

    // Check if strings contain ' character
    final source = this!.trim().toLowerCase().removeSpecialCharacters;
    final targetStr = target.trim().toLowerCase().removeSpecialCharacters;
    if (source.isEmpty || targetStr.isEmpty) return false;
    // Special cases
    if ((source == "b" && target == "vnd") ||
        (source == "vnd" && target == "b") ||
        (source == "v" && target == "vnd") ||
        (source == "vnd" && target == "v")) {
      return true;
    }

    // Number comparison
    final sourceIsContainNumber = source.contains(RegExp(r'\d'));
    final targetIsContainNumber = targetStr.contains(RegExp(r'\d'));
    if (sourceIsContainNumber || targetIsContainNumber) {
      final sourceNumberWords = source.transformWordToFormNumber();
      final targetNumberWords = targetStr.transformWordToFormNumber();

      return sourceNumberWords.contains(targetNumberWords) || targetNumberWords.contains(sourceNumberWords);
    }

    // Article comparison
    if ((targetStr == "a" && source == "the") || (targetStr == "the" && source == "a")) {
      return true;
    }

    // Length-based comparisons
    final minLen = math.min(source.length, targetStr.length);
    if (minLen == 0 || source[0] != targetStr[0]) return false;

    // First three characters match
    if (minLen >= 3 && source[0] == targetStr[0] && source[1] == targetStr[1] && source[2] == targetStr[2]) {
      return true;
    }

    // Length ratio check
    final maxLen = math.max(source.length, targetStr.length);
    if (maxLen / minLen > 1 / percent) return false;
    // Check if source or target does not contain a number
    if ((!RegExp(r'\d').hasMatch(source) || !RegExp(r'\d').hasMatch(targetStr)) && minLen <= 4) {
      percent = 0.5;
    }
    // Character-by-character comparison
    var matchCount = 0;
    for (var i = 0; i < minLen; i++) {
      if (source[i] == targetStr[i]) {
        matchCount++;
        if (matchCount / minLen >= percent) return true;
      }
    }
    return false;
  }

  bool isSentenceMatch(String sentence) {
    if (this == null || this!.isEmpty || sentence.isEmpty) return false;
    final keyWords = this!.split(" ");
    final matchedWords = sentence.split(" ");

    if (matchedWords.length < keyWords.length) {
      return false;
    }

    int matchScore = 0;

    for (int i = 0; i < keyWords.length; i++) {
      final keyWord = keyWords[i];
      final matchedWord = matchedWords[i];
      if (matchedWord.areWordsSimilar(keyWord)) {
        matchScore++;
      }
    }

    return matchScore >= keyWords.length;
  }

  /// Compares two words for similarity based on content
  bool areWordsSimilar(String word2) {
    if (this == null || this!.isEmpty || word2.isEmpty) return false;
    final containsDigit = this!.contains(RegExp(r'[0-9]')) || word2.contains(RegExp(r'[0-9]'));

    final threshold = containsDigit ? 0.3 : 0.8;

    return this!.compareSimilirity(word2, threshold);
  }

  String get removeSpecialCharacters {
    if (isNullOrEmpty) return '';
    return this!.characters.where((char) => !_specialCharacters.contains(char)).join();
  }

  bool get isContainsEmoji {
    if (isNullOrEmpty) return false;
    return this!.contains(RegExp(r'[\p{Emoji}]', unicode: true));
  }

  String get removeEmoji {
    if (isNullOrEmpty) return '';
    return this!.replaceAll(RegExp(r'[\p{Emoji_Presentation}\p{Emoji_Modifier_Base}\p{Emoji_Modifier}]', unicode: true), '');
  }

  String get removeMultipleSpaces {
    if (isNullOrEmpty) return '';
    return this!.replaceAll(RegExp(r'[ ]{2,}'), ' ').replaceAll(' ️ ', ' ').trim();
  }

  List<String> splitWithKeepSeparator(String separator) {
    if (isNullOrEmpty) return [];
    // Split the input string by '+' symbol with surrounding whitespace
    final textRegex = RegExp('(\\s*\\$separator\\s*)');
    final parts = this!.split(textRegex);

    // Create a result list with alternating parts and '+' symbols
    final result = <String>[];
    for (var i = 0; i < parts.length; i++) {
      final trimmedPart = parts[i].trim();
      if (trimmedPart.isNotEmpty) {
        result.add(trimmedPart);
        // Add '+' after each part except the last one
        if (i < parts.length - 1) {
          result.add(separator);
        }
      }
    }
    return result;
  }

  /// Finds all occurrences of text enclosed in a specific tag and returns them as [TaggedText] objects.
  ///
  /// This method searches for text patterns of the form <tag>text</tag> in the string
  /// and extracts the text along with its position information.
  ///
  /// For example, if the string is "Hello <t>world</t>!" and you call findTaggedTexts("t"),
  /// it will return a list containing a [TaggedText] object with text="world" and appropriate
  /// position information.
  ///
  /// Parameters:
  ///   [tag] - The tag name to search for (without angle brackets)
  ///
  /// Returns:
  ///   A list of [TaggedText] objects containing the text and position information
  ///   for each tagged text found, or an empty list if this string is null or empty
  List<TaggedText> findTaggedTexts(String tag) {
    if (isNullOrEmpty) return [];
    // Create RegExp object with regex pattern, enable dotAll to match newline characters
    final regexPattern = '<$tag>(.*?)</$tag>';
    final regex = RegExp(regexPattern, dotAll: true);
    final List<TaggedText> results = [];

    // Iterate through all matches in the input string
    for (var match in regex.allMatches(this!)) {
      final String text = match.group(1)!;
      // Calculate the start position of the text (skipping the length of <tag>)
      final int start = match.start + tag.length + 2;
      // Calculate the end position of the text (skipping the length of </tag>)
      final int end = match.end - tag.length - 3;
      // Add the result to the list
      results.add(TaggedText(text, start, end, tag));
    }

    // Return the list of results
    return results;
  }

  /// Replaces all occurrences of tagged text with a specified replacement string.
  ///
  /// This method finds all text enclosed in tags of the form <tag>text</tag> and
  /// replaces the entire tag structure (including opening and closing tags) with
  /// the provided replacement string.
  ///
  /// For example, if the string is "Hello <t>world</t>!" and you call
  /// replaceAllTaggedTexts("t", "___"), the result will be "Hello ___!".
  ///
  /// Parameters:
  ///   [tag] - The tag name to search for (without angle brackets)
  ///   [replacement] - The string to replace each tagged text with
  ///
  /// Returns:
  ///   A new string with all tagged texts replaced, or an empty string if this is null
  String replaceAllTaggedTexts(String tag, String replacement) {
    if (isNullOrEmpty) return '';
    String result = this!;
    final taggedTexts = findTaggedTexts(tag);
    for (var tt in taggedTexts) {
      final start = tt.start - tag.length - 2;
      final end = tt.end + tag.length + 3;
      result = result.replaceRange(start, end, replacement);
    }
    return result;
  }

  String formatToGolangCompatibleRFC3339() {
    if (isNullOrEmpty) return '';
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSSSSS+00:00").format(DateTime.parse(this!));
  }

  String cleanJsonFormatFromAI() {
    if (isNullOrEmpty) return '';

    var text = this!;
    // Remove markdown code block syntax (```json and ```)
    if (text.contains('```')) {
      // First remove any ```json or similar language specifiers
      text = text.replaceAll(RegExp(r'```\w*\n*'), '');
      // Then remove any remaining ``` markers
      text = text.replaceAll('```', '');
      // Trim any extra whitespace that might be left
      text = text.trim();
    }

    return text;
  }

  bool get isOnlineLink => this?.startsWith('http') ?? false;
}
