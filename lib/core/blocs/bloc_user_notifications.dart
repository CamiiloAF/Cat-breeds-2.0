import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/entities/entity_bloc.dart';

class UserNotificationsBloc extends BlocModule {
  UserNotificationsBloc(final BuildContext context) {
    _context = context;
  }

  static const name = 'userNotificationsBloc';
  final BlocGeneral _userNotificationsBloc = BlocGeneral<String>('');

  late BuildContext _context;

  set context(final BuildContext context) {
    _context = context;
  }

  void showGeneralAlert(final String msg) {
    try {
      showAlert(_context, Text(msg));
    } catch (e) {
      debugPrint('Imposible Ejecutar el alerta del usuario');
    }
  }

  void showGeneralSsnackBar(
    final String msg,
  ) {
    try {
      final snackBar = SnackBar(
        content: Text(msg),
      );
      showSnackBar(_context, snackBar);
    } catch (e) {
      debugPrint('Imposible presentar el Snack Bar');
    }
  }

  void showSnackBar(final BuildContext context, final SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showAlert(final BuildContext context, final Widget widget) {
    showDialog(
      context: _context,
      builder: (final context) => AlertDialog(
        content: widget,
      ),
    );
  }

  @override
  FutureOr<void> dispose() {
    _userNotificationsBloc.dispose();
  }
}
