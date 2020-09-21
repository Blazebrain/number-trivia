import 'package:flutter/material.dart';
import 'package:number_trivial/features/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  final String text;
  final int number;

  NumberTriviaModel({
    @required this.text,
    @required this.number,
  });
  // For equatable in place of super constructor
  @override
  List<Object> get props => [text, number];

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      number: (json['number'] as num).toInt(),
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'number': number,
    };
  }
}
