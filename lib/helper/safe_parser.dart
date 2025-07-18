import 'package:flutter/widgets.dart';

T? safeParser<T>(dynamic value, String fieldName) {
  try {
    if (value is T) return value;
    if (T == int) return int.tryParse(value.toString()) as T?;
    if (T == double) return double.tryParse(value.toString()) as T?;
    if (T == bool) {
      final v = value.toString().toLowerCase();
      if (v == 'true') return true as T;
      if (v == 'false') return false as T;
    }
    if (T == String) return value.toString() as T;
  } catch (e) {
    debugPrint('Error parsing $fieldName: $e');
  }
  debugPrint('Failed to parse $fieldName, returning null');
  return null;
}
