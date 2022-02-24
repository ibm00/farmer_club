// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> ar = {
    "VALIDATION_ERROR": "هذا الحقل مطلوب",
    "EMAIL_VALIDATION_ERROR_MESSAGE": "أدخل بريد إلكتروني صالح"
  };
  static const Map<String, dynamic> en = {
    "VALIDATION_ERROR": "This field is required",
    "EMAIL_VALIDATION_ERROR_MESSAGE": "Enter a valid email"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "ar": ar,
    "en": en
  };
}
