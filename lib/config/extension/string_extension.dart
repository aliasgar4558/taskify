extension StringExtension on String? {
  bool get isNullOrEmpty {
    if (this == null) {
      return true;
    } else {
      final newValue = this?.trim();
      return newValue?.isEmpty ?? true;
    }
  }
}
