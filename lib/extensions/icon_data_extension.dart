import 'package:flutter/material.dart';

extension IconDataExtension on IconData {
  Map<String, dynamic> toJson() {
    return {
      'codePoint': codePoint,
      'fontFamily': fontFamily,
      'fontPackage': fontPackage,
      'matchTextDirection': matchTextDirection,
    };
  }

  fromJson(Map<String, dynamic> map) {
    return IconData(
      map['codePoint'],
      fontFamily: map['fontFamily'],
      fontPackage: map['fontPackage'],
      matchTextDirection: map['matchTextDirection'] ?? false,
    );
  }
}
