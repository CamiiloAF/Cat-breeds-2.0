import 'dart:async';

extension RepeatLastValueExtension<T> on Stream<T> {
  Stream<T> call(final T lastValue) {
    var done = false;
    final currentListeners = <MultiStreamController<T>>{};
    listen(
      (final event) {
        for (final listener in [...currentListeners]) {
          listener.addSync(event);
        }
      },
      onError: (final error, final stack) {
        for (final listener in [...currentListeners]) {
          listener.addErrorSync(error, stack);
        }
      },
      onDone: () {
        done = true;
        for (final listener in currentListeners) {
          listener.closeSync();
        }
        currentListeners.clear();
      },
    );
    return Stream.multi((final controller) {
      if (done) {
        controller.close();
        return;
      }
      currentListeners.add(controller);
      controller.add(lastValue);
      controller.onCancel = () {
        currentListeners.remove(controller);
      };
    });
  }
}

/// [Bloc] es la clase de logica de negocios que derivara el resto de las clases bloc
abstract class Bloc<T> {
  T? _value;

  T get value => _value as T;

  // final StreamController<T> _streamController = BehaviorSubject<T>();
  final StreamController<T> _streamController = StreamController<T>.broadcast();

  Stream<T> get stream => _streamController.stream(value);

  set value(final T val) {
    _streamController.sink.add(val);
    _value = val;
  }

  StreamSubscription? _suscribe;

  bool get isSubscribeActive => !(_suscribe == null);

  void _desuscribeStream() {
    _suscribe?.cancel();
    _suscribe = null;
  }

  void _setStreamSubsciption(final void Function(T event) function) {
    _desuscribeStream();
    _suscribe = stream.listen(function);
  }

  void dispose() {
    _desuscribeStream();
    _streamController.close();
  }
}

abstract class BlocModule {
  FutureOr<void> dispose();
}

class BlocCore {
  final Map<String, BlocGeneral> _injector = {};
  final Map<String, BlocModule> _moduleInjector = {};

  BlocGeneral<T> getBloc<T>(final String key) {
    final tmp = _injector[key.toLowerCase()];
    if (tmp == null) {
      throw Exception('The BlocGeneral were not initialized');
    }
    return _injector[key.toLowerCase()] as BlocGeneral<T>;
  }

  T getBlocModule<T>(final String key) {
    final tmp = _moduleInjector[key.toLowerCase()];
    if (tmp == null) {
      throw Exception('The BlocModule were not initialized');
    }
    return _moduleInjector[key.toLowerCase()] as T;
  }

  void addBlocGeneral<T>(final String key, final BlocGeneral<T> blocGeneral) {
    _injector[key.toLowerCase()] = blocGeneral;
  }

  void addBlocModule<T>(final String key, final BlocModule blocModule) {
    _moduleInjector[key.toLowerCase()] = blocModule;
  }

  void deleteBlocGeneral(final String key) {
    final keyToLowerCase = key.toLowerCase();

    _injector[keyToLowerCase]?.dispose();
    _injector.remove(keyToLowerCase);
  }

  void deleteBlocModule(final String key) {
    final keyToLowerCase = key.toLowerCase();

    _moduleInjector[keyToLowerCase]?.dispose();
    _moduleInjector.remove(keyToLowerCase);
  }

  void dispose() {
    _injector.forEach(
      (final key, final value) {
        value.dispose();
      },
    );
    _moduleInjector.forEach(
      (final key, final value) {
        value.dispose();
      },
    );
  }
}

class BlocGeneral<T> extends Bloc<T> {
  BlocGeneral(final T valueTmp) {
    value = valueTmp;
    _setStreamSubsciption((final event) {
      for (final element in _functionsMap.values) {
        element(event);
      }
    });
  }

  final Map<String, void Function(T val)> _functionsMap = {};

  void addFunctionToProcessTValueOnStream(
    final String key,
    final Function(T val) function,
  ) {
    _functionsMap[key.toLowerCase()] = function;
    // Ejecutamos la funcion instantaneamente con el valor actual
    function(value);
  }

  void deleteFunctionToProcessTValueOnStream(final String key) {
    _functionsMap.remove(key);
  }

  // ignore: always_declare_return_types, type_annotate_public_apis
  get valueOrNull => value;

  void close() {
    dispose();
  }
}
