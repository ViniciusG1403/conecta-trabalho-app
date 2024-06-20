String extractErrorMessage(String error) {
  final RegExp regex = RegExp(r'(?<=: ).*');
  final match = regex.firstMatch(error);
  final String? message = match?.group(0);
  return message?.split(":")[1] ?? 'Erro desconhecido';
}