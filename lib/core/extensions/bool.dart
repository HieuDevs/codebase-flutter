extension BoolExtension on bool? {
  bool get isTrue => this == true;
  bool get isFalse => this == false;
  bool get orFalse => this ?? false;
  bool get orTrue => this ?? true;
}
