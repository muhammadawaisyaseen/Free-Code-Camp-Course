import 'package:flutter/material.dart' show BuildContext, ModalRoute;

// GetArgument extension is a way to add a new method to the BuildContext class
// that allows you to easily retrieve arguments passed to a Widget.
extension GetArgument on BuildContext {
  T? getArgument<T>() {
    final modalRoute = ModalRoute.of(this);
    if (modalRoute != null) {
      final args = modalRoute.settings.arguments;
      if (args != null && args is T) {
        return args as T;
      }
    }
    return null;
  }
}
