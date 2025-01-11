import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TermsOfUseBrowser extends ChromeSafariBrowser {
  final VoidCallback onBrowserClosed;

  TermsOfUseBrowser({
    required this.onBrowserClosed,
  });

  @override
  void onClosed() {
    super.onClosed();
    onBrowserClosed();
  }
}
