class ValidatorsHelper {
  static String? isEmptyValidator(String name) {
    if (name.trim().isEmpty) {
      return "هذا الحقل مطلوب";
    }
    return null;
  }

  static Object? isEmptyValidatorForObjects(Object? object) {
    if (object == null) {
      return "هذا الحقل مطلوب";
    }
    return null;
  }

  static String? emailValidator(String email) {
    if (!email.contains(".com") || !email.contains("@")) {
      return "أدخل بريد صالح, (example@example.com)";
    }
    return null;
  }

  static String? numbersValidator(String num) {
    if (double.tryParse(num) == null) {
      return "أدخل أرقام فقط";
    }
    return null;
  }

  static String? passwordValidator(String pass) {
    if (pass.trim().length < 6) {
      return "كلمة المرور لا تقل عن 6 حروف أو أرقام";
    } else {
      return null;
    }
  }

  static String? rePasswordValidator(String rePass, String oldPass) {
    if (rePass.isEmpty) {
      return "هذا الحقل مطلوب";
    } else if (rePass.trim() != oldPass.trim()) {
      return "كلمتي المرور غير متطابقتين";
    }
    return null;
  }
}
