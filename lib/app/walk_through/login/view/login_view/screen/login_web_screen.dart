import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class LoginBrowser extends ChromeSafariBrowser {
  final VoidCallback onBrowserClosed;

  LoginBrowser({
    required this.onBrowserClosed,
  });

  @override
  void onClosed() {
    super.onClosed();
    onBrowserClosed();
  }
}
