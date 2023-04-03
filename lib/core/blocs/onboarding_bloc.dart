import 'dart:async';

import '../entities/entity_bloc.dart';

class OnboardingBloc extends BlocModule {
  OnboardingBloc(
    final List<FutureOr<void> Function()> listOfOnboardingFunctions,
  ) {
    _blocOnboardingList = listOfOnboardingFunctions;
  }

  static const name = 'onboardingBloc';
  late List<FutureOr<void> Function()> _blocOnboardingList;
  final BlocGeneral<String> _blocMsg = BlocGeneral('Inicializando');

  Stream<String> get msgStream => _blocMsg.stream;

  int addFunction(final FutureOr<void> Function() function) {
    _blocOnboardingList.add(function);
    return _blocOnboardingList.length;
  }

  Future<void> execute(final Duration duration) async {
    await Future.delayed(duration);
    final tmpList = List<FutureOr<void> Function()>.from(_blocOnboardingList);
    var length = tmpList.length;
    for (final f in tmpList) {
      length--;
      await f();
      _blocMsg.value = '$length restantes';
    }
    _blocMsg.value = 'Onboarding completo';
  }

  String get msg => _blocMsg.value;

  @override
  FutureOr<void> dispose() {
    _blocMsg.dispose();
  }
}
