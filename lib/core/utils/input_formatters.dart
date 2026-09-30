import 'package:flutter/services.dart';

/// Formatea teléfono venezolano: 0412-1234567
class VenezuelanPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Solo números
    final text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (text.isEmpty) {
      return const TextEditingValue();
    }

    // Máximo 11 dígitos (0412-1234567)
    final trimmed = text.length > 11 ? text.substring(0, 11) : text;

    String formatted;
    if (trimmed.length <= 4) {
      formatted = trimmed;
    } else {
      formatted = '${trimmed.substring(0, 4)}-${trimmed.substring(4)}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Formatea teléfono fijo venezolano: 0212-1234567
class VenezuelanLandlineFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (text.isEmpty) {
      return const TextEditingValue();
    }

    // Máximo 11 dígitos (0212-1234567)
    final trimmed = text.length > 11 ? text.substring(0, 11) : text;

    String formatted;
    if (trimmed.length <= 4) {
      formatted = trimmed;
    } else {
      formatted = '${trimmed.substring(0, 4)}-${trimmed.substring(4)}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Formatea cédula venezolana: V-1.234.567 o RIF: J-12345678-9
class VenezuelanDocumentFormatter extends TextInputFormatter {
  final String prefix; // V, J, E

  VenezuelanDocumentFormatter(this.prefix);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (text.isEmpty) {
      return const TextEditingValue();
    }

    String formatted;

    if (prefix == 'J' || prefix == 'G') {
      // RIF: J-12345678-9 (máximo 9 dígitos)
      final trimmed = text.length > 9 ? text.substring(0, 9) : text;
      if (trimmed.length <= 8) {
        formatted = '$prefix-${_addDots(trimmed)}';
      } else {
        formatted =
            '$prefix-${_addDots(trimmed.substring(0, 8))}-${trimmed.substring(8)}';
      }
    } else {
      // Cédula: V-1.234.567 o E-12345678 (máximo 8 dígitos)
      final trimmed = text.length > 8 ? text.substring(0, 8) : text;
      formatted = '$prefix-${_addDots(trimmed)}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _addDots(String text) {
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && (text.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(text[i]);
    }
    return buffer.toString();
  }
}

/// Capitaliza la primera letra de cada palabra mientras el usuario escribe
class CapitalizeWordsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) {
      return newValue;
    }

    final words = text.split(' ');
    final capitalized = words
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');

    return TextEditingValue(
      text: capitalized,
      selection: TextSelection.collapsed(offset: capitalized.length),
    );
  }
}
