class ProgressStatus {
  static final String WAITING    = "WAITING";
  static final String RECEIVED  = "RECEIVED";
  static final String DONE  = "DONE";

  String _value;

  ProgressStatus.from(String v) {
    if (_validate(v) == false) {
      throw Exception("invalid progress status");
    }
    this._value = v;
  }

  String get() {
    return this._value;
  }

  void set(String v) {
    if (_validate(v) == false) {
      throw Exception("invalid progress status");
    }
    this._value = v;
  }

  bool isEqualTo(String v) {
    if (_validate(v) == false) {
      throw Exception("invalid progress status");
    }
    return this._value == v;
  }

  bool _validate(String v) {
    return v == WAITING || v == RECEIVED || v == DONE;
  }
}