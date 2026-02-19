extension FastHashExtension on String {
  int fastHash() {
    var hash = 0x811c9dc5;
    for (var i = 0; i < length; i++) {
      hash ^= codeUnitAt(i);
      hash *= 0x01000193;
    }
    return hash;

    // var hash = 0xcbf29ce484222325;
    // var i = 0;
    // while (i < length) {
    //   final codeUnit = codeUnitAt(i++);
    //   hash ^= codeUnit >> 8;
    //   hash *= 0x100000001b3;
    //   hash ^= codeUnit & 0xFF;
    //   hash *= 0x100000001b3;
    // }
    // return hash;
  }
}
