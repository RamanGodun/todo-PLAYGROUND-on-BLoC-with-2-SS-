import 'package:flutter_bloc/flutter_bloc.dart';

/// 🛠️ **[AppBlocObserver]** - Custom observer for monitoring BLoC lifecycle.

/// This observer logs key lifecycle events:
/// - 🟢 **onCreate**: When a BLoC/Cubit is initialized.
/// - 📨 **onEvent**: When an event is added to a BLoC.
/// - 🔄 **onChange**: When there is a state change in a BLoC/Cubit.
/// - ➡️ **onTransition**: When a BLoC processes a transition (event → state).
/// - ❌ **onError**: When an error occurs in a BLoC/Cubit.
/// - 🔴 **onClose**: When a BLoC/Cubit is closed and disposed.

class AppBlocObserver extends BlocObserver {
  /// ⏳ **Generates a timestamp** for log messages.
  String _timestamp() => DateTime.now().toIso8601String();

  /// 🟢 **Called when a BLoC is created.**
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('🟢 [${_timestamp()}] onCreate -- ${bloc.runtimeType}');
  }

  /// 📨 **Called when an event is added to a BLoC.**
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('📨 [${_timestamp()}] onEvent -- ${bloc.runtimeType}: $event');
  }

  /// 🔄 **Called when there is a state change in a BLoC.**
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('🔄 [${_timestamp()}] onChange -- ${bloc.runtimeType}: $change');
  }

  /// ➡️ **Called when a BLoC processes a transition (event → state).**
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(
        '➡️ [${_timestamp()}] onTransition -- ${bloc.runtimeType}: $transition');
  }

  /// ❌ **Called when an error occurs in a BLoC.**
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(
        '❌ [${_timestamp()}] onError -- ${bloc.runtimeType}: $error\n$stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  /// 🔴 **Called when a BLoC is closed and disposed.**
  @override
  void onClose(BlocBase bloc) {
    print('🔴 [${_timestamp()}] onClose -- ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
