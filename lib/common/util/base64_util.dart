import 'dart:convert';

class Base64Util {
  static String encodeUrlSafeBase64(String input) {
    return base64Encode(utf8.encode(input))
        .replaceAll("+", "-")
        .replaceAll("/", "_")
        .replaceAll("=", "");
  }

  static String normalizeBase64(String base64) {
    String normalized = base64.replaceAll("-", "+").replaceAll("_", "/");

    while (normalized.length % 4 != 0) {
      normalized += "=";
    }

    return normalized;
  }
}
