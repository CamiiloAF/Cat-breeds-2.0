import 'dart:async';

import 'core/blocs/navigator_bloc.dart';
import 'core/blocs/onboarding_bloc.dart';
import 'core/entities/entity_bloc.dart';
import 'core/http/config/remote_api_constants.dart';
import 'core/http/http_proxy_impl.dart';
import 'features/breeds/data/repositories/breeds_repository.dart';
import 'features/breeds/domain/use_cases/get_breed_image_use_case.dart';
import 'features/breeds/domain/use_cases/get_breeds_use_case.dart';
import 'features/breeds/presentation/blocs/breeds_bloc.dart';
import 'features/splash/presentation/splash_page.dart';
import 'shared/navigation/my_app_navigator_provider.dart';

/// Zona de configuración inicial
final BlocCore blocCore = BlocCore();
bool _init = false;

FutureOr<void> testMe() async {
  await Future.delayed(
    const Duration(seconds: 2),
  );
}

Future<void> onboarding([
  final Duration inaitialDelay = const Duration(seconds: 2),
]) async {
  /// Register modules to use
  /// Inicializamos el responsive y la ux del usuario
  if (!_init) {
    final breedsRepository = BreedsRepository(
      httpClient: HttpProxyImpl('https://api.thecatapi.com/v1').instance(),
      breedsPath: RemoteApiConstants.breedsRoute,
      breedImagesPath: RemoteApiConstants.breedImageRoute,
    );

    blocCore.addBlocModule<BreedsBloc>(
      BreedsBloc.name,
      BreedsBloc(
        getBreedsUseCase: GetBreedsUseCase(breedsRepository),
        getBreedImageUseCase: GetBreedImageUseCase(breedsRepository),
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
