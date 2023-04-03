import 'package:flutter/material.dart';

import '../../../../app_config.dart';
import '../../../../core/blocs/bloc_user_notifications.dart';
import '../../../../core/exceptions/failure.dart';
import '../../domain/entities/breeds_state_model.dart';
import '../blocs/breeds_bloc.dart';
import '../widgets/breeds_list.dart';

class BreedsPage extends StatefulWidget {
  const BreedsPage({super.key});

  @override
  State<BreedsPage> createState() => _BreedsPageState();
}

class _BreedsPageState extends State<BreedsPage> {
  late BreedsBloc breedsBloc;

  @override
  void initState() {
    breedsBloc = blocCore.getBlocModule<BreedsBloc>(
      BreedsBloc.name,
    );

    WidgetsBinding.instance
        .addPostFrameCallback((final _) async => _loadBreeds());
    super.initState();
  }

  Future<void> _loadBreeds() async {
    try {
      await breedsBloc.getBreeds();
    } on Failure catch (e) {
      blocCore
          .getBlocModule<UserNotificationsBloc>(
            UserNotificationsBloc.name,
          )
          .showSnackBar(
            context,
            SnackBar(
              content: Text(e.message),
            ),
          );
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Catbreeds'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadBreeds,
        child: StreamBuilder<BreedsStateModel>(
          stream: breedsBloc.stateStream,
          builder: (final context, final snapshot) {
            if (snapshot.data?.isLoading ?? true) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData && snapshot.data!.hasError) {
              return const Offstage();
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BreedsList(breeds: snapshot.data!.breeds),
            );
          },
        ),
      ),
    );
  }
}
