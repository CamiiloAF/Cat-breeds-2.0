import 'dart:convert';

import 'package:flutter/foundation.dart';

abstract class ModelEntity {
  const ModelEntity();

  Map<String, dynamic> toJson() {
    return {};
  }

  ModelEntity fromJson(final Map<String, dynamic> source);

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  Map<String, dynamic> fromString(final String source) {
    var tmp = {} as Map<String, dynamic>;
    try {
      tmp = jsonDecode(source);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return tmp;
  }
}
