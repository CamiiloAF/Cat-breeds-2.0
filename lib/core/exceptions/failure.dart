class Failure implements Exception {

  Failure([this.message = 'Ocurrió un error inesperado']);

  final String message;
}
