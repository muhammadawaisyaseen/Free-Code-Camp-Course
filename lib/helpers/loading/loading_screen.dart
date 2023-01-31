import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freecodecampcourse/helpers/loading/loading_screen_controller.dart';

class LoadingScreen {
  factory LoadingScreen() => _shared;
  static final LoadingScreen _shared = LoadingScreen._shared;
  LoadingScreen._sharedInstance();

  LoadingScreenController? controller;

  LoadingScreenController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final _text = StreamController<String>();
    _text.add(text);

    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
  }
}
