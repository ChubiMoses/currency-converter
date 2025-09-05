    import 'dart:async';
    import 'package:flutter/foundation.dart';

    class Debouncer {
      final int milliseconds;
      Timer? timer;

      Debouncer({this.milliseconds = 500});

      run(VoidCallback action) {
        if (timer != null) {
          timer!.cancel();
        }
        timer = Timer(Duration(milliseconds: milliseconds), action);
      }
    }