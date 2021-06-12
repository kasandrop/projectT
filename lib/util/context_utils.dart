import 'package:flutter/material.dart';

class ContextUtils {
  // Takes a key, and in 1 frame, returns the size of the context attached to the key
  static void getFutureSizeFromGlobalKey(
      {required GlobalKey key, required Function(Size size) callback}) {
    Future.microtask(() {
      var size = getSizeFromContext(key.currentContext) ?? Size.zero;
      callback(size);
    });
  }

  // Shortcut to get the renderBox size from a context
  static Size getSizeFromContext(BuildContext? context) {
    var rb = context?.findRenderObject() as RenderBox;
    return rb?.size ?? Size.zero;
  }

  // Shortcut to get the global position of a context
  static Offset? getOffsetFromContext(BuildContext context, [Offset? offset]) {
    var rb = context.findRenderObject() as RenderBox;
    return rb?.localToGlobal(offset ?? Offset.zero);
  }
}
