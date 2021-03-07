extension StringExt on String {
  bool get isValid {
    return this != null && this.trim().isNotEmpty;
  }

  toCapitalCase() {
    return this.substring(0, 1).toUpperCase() + this.substring(1);
  }
}
