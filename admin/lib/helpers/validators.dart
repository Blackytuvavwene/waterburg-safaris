// form validation

class CustomFormValidators {
  // only allow numbers
  static String? onlyNumbers(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    final n = num.tryParse(value);
    if (n == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  // only allow double
  static String? onlyDouble(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    final n = double.tryParse(value);
    if (n == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  // email validation
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}

class EmailValidator {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static bool validate(String value) {
    return _emailRegExp.hasMatch(value);
  }
}

// function to create slug
String createSlug({
  required String text,
}) {
  // non numeric regex
  final nonNumericRegExp = RegExp(r'[^\w\s-]');

  // space regex
  final spacesRegex = RegExp(r'\s+');

  // remove trailing and leading hyphens regex
  final hyphensRegex = RegExp(r'(^-*)|(-*$)');

  // convert to lower case
  String lowerCaseText = text.toLowerCase();

  // replace non-alphanumeric characters with spaces
  lowerCaseText = lowerCaseText.replaceAll(
    nonNumericRegExp,
    ' ',
  );

  // replace the spaces
  lowerCaseText = lowerCaseText.replaceAll(
    spacesRegex,
    '-',
  );

  // remove leading and trailing hyphens
  final slugText = lowerCaseText.trim().replaceAll(
        hyphensRegex,
        '',
      );

  return slugText;
}
