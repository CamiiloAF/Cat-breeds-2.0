import 'dart:async';

import 'package:aleteo_triqui/core/http/http_proxy_impl.dart';
import 'package:aleteo_triqui/modules/breeds/blocs/breeds_bloc.dart';
import 'package:aleteo_triqui/modules/splash/splash_page.dart';
import 'package:aleteo_triqui/services/breeds_service.dart';

import 'blocs/navigator_bloc.dart';
import 'blocs/onboarding_bloc.dart';
import 'core/http/config/remote_api_constants.dart';
import 'entities/entity_bloc.dart';
import 'providers/my_app_navigator_provider.dart';

/// Zona de configuración inicial
final BlocCore blocCore = BlocCore();
bool _init = false;

FutureOr<void> testMe() async {
  await Future.delayed(
    const Duration(seconds: 2),
  );
}

void onboarding([
  Duration initialDelay = const Duration(seconds: 2),
]) async {
  /// Register modules to use
  /// Inicializamos el responsive y la ux del usuario
  if (!_init) {
    blocCore.addBlocModule<BreedsBloc>(
      BreedsBloc.name,
      BreedsBloc(
        breedsService: BreedsService(
          httpClient: HttpProxyImpl('https://api.thecatapi.com/v1').instance(),
          breedsPath: RemoteApiConstants.breedsRoute,
          breedImagesPath: RemoteApiConstants.breedImageRoute,
        ),
      ),
    );

    /// register onboarding
    blocCore.addBlocModule(
      OnboardingBloc.name,
      OnboardingBloc(
        [
          () async {
            await Future.delayed(const Duration(milliseconds: 200), () {
              blocCore
                  .getBlocModule<NavigatorBloc>(NavigatorBloc.name)
                  .update();
            });
          }
        ],
      ),
    );

    blocCore.addBlocModule(
      NavigatorBloc.name,
      NavigatorBloc(
        myPageManager,
        const SplashPage(),
      ),
    );

    _init = true;
  }
}
