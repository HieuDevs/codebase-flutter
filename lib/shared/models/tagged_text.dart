import 'dart:convert';

import 'package:equatable/equatable.dart';

class TaggedText extends Equatable {
  final int start; // First index of the text
  final int end; // Last index of the text
  final String tag;
  final String text; // Text between <tag> and </tag>
  const TaggedText(this.text, this.start, this.end, this.tag);

  TaggedText copyWith({String? text, int? start, int? end, String? tag}) {
    return TaggedText(text ?? this.text, start ?? this.start, end ?? this.end, tag ?? this.tag);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'text': text, 'start': start, 'end': end, 'tag': tag};
  }

  factory TaggedText.fromMap(Map<String, dynamic> map) {
    return TaggedText(map['text'] as String, map['start'] as int, map['end'] as int, map['tag'] as String);
  }

  String toJson() => json.encode(toMap());

  factory TaggedText.fromJson(String source) => TaggedText.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [text, start, end, tag];
}
