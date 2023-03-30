class Failure implements Exception {
  final String message;

  Failure([this.message = 'Ocurrió un error inesperado']);
}
