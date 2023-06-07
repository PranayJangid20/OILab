import 'package:flutter/material.dart';

extension DebugPrint on Object? {
  void log() => debugPrint(toString());
}

extension NullOrEmptyCheck on String? {
  bool get isNull => this == null;
  bool get isNuUOrEmpty => isNull || this!.isEmpty;
}

extension SpaceXY on num {
  SizedBox get spaceX => SizedBox(width: toDouble());
  SizedBox get spaceY => SizedBox(height: toDouble());
}

num n = 5;

extension GetNumber on String {
  int get getNumber => int.tryParse(trim().replaceAll(RegExp(r'\D+'), '')) ?? 0;
}