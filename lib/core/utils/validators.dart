import 'package:easy_localization/easy_localization.dart';

import '../utils/regex.dart';

class Validators {
  static String? name(final String? value) {
    if (value == null || value.isEmpty) {
      return 'auth.validation.required'.tr();
    }
    return null;
  }

  /// Validate email format
  static String? email(final String? value) {
    if (value == null || value.isEmpty) {
      return 'auth.validation.required'.tr();
    } else if (!AppRegex.isEmailValid(value)) {
      return 'auth.validation.email'.tr();
    }
    return null;
  }

  /// Validate password with multiple rules
  static String? password(final String? value) {
    if (value == null || value.isEmpty) {
      return 'auth.validation.required'.tr();
    }

    if (!AppRegex.hasMinLength(value)) {
      return 'auth.validation.password_validation_5'.tr();
    }

    return null; // Password is valid
  }

  static String? phoneNumber(final String? value) {
    if (value == null || value.isEmpty || !AppRegex.isPhoneNumberValid(value)) {
      return 'auth.validation.required'.tr();
    } else if (!AppRegex.isPhoneNumberValid(value)) {
      return 'auth.invalid_phone_number'.tr();
    }
    return null;
  }
}
