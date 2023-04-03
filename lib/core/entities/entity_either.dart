abstract class Either<L, R> {
  T when<T>(
    final T Function(L) left,
    final T Function(R) right,
  ) {
    if (this is Left) {
      return left((this as Left).value);
    }
    return right((this as Right).value);
  }
}

class Left<L, R> extends Either<L, R> {
  Left(this.value);

  final L value;
}

class Right<L, R> extends Either<L, R> {
  Right(this.value);

  final R value;
}
