abstract class Either<L, R> {
  T when<T>(
    T Function(L) left,
    T Function(R) right,
  ) {
    if (this is Left) {
      return left((this as Left).value);
    }
    return right((this as Right).value);
  }
}

class Left<L, R> extends Either<L, R> {
  final L value;
  Left(this.value);
}

class Right<L, R> extends Either<L, R> {
  final R value;
  Right(this.value);
}
