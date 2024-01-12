String? validateLengthField(String value, String fieldName, int length) {
  if (value.length < length) {
    return "O campo $fieldName deve ter pelo menos $length caracteres.";
  }
  return null;
}

String? validateNullField(String? value, String fieldName) {
  if (value == "") {
    return "Por favor, insira o $fieldName.";
  }
  return null;
}

String? validateEmailFormatRegex(String value) {
  RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final isValid = emailRegex.hasMatch(value ?? '');
  if (!isValid) {
    return "Por favor, insira um email válido.";
  }
}

String? validatePassword(String value, String value2) {
  if (value == null || value == "") {
    return "Por favor, insira a senha.";
  }
  if (value.length < 6) {
    return "A senha deve ter pelo menos 6 caracteres.";
  }
  if (value.length > 20) {
    return "A senha deve ter no máximo 20 caracteres.";
  }
  if (value != value2) {
    return "As senhas não coincidem.";
  }
  return null;
}
