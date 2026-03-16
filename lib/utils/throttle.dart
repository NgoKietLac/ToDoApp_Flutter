import 'dart:async';
import 'package:flutter/material.dart';

class Throttle {
  final Duration delay;
  Timer? _timer;

  Throttle({required this.delay});

  void trigger(VoidCallback action) {
    if (_timer != null) return;

    action();

    _timer = Timer(delay, () {
      _timer = null;
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
