class ClientDetailsFormValidator {
  static String? requiredField(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return null; // Not required

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(trimmed)) {
      return 'Please enter a valid email address.';
    }

    return null;
  }

  static String? validatePhone(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return null; // Not required

    final phoneRegex = RegExp(r'^\+?[\d\s\-]{7,15}$');
    if (!phoneRegex.hasMatch(trimmed)) {
      return 'Enter a valid phone number.';
    }

    return null;
  }
}
