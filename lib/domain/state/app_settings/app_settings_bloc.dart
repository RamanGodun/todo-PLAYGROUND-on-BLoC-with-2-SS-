import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/enums.dart';

part 'app_settings_events.dart';
part 'app_settings_state.dart';

/// ⚙️ **[AppSettingsBloc]** - Manages application settings.
/// - 🎨 **Theme Mode**: Light / Dark.
/// - 🔄 **State Shape Mode**: Listener vs. StreamSubscription.
/// - 💾 **State persistence** using `HydratedBloc`.
class AppSettingsBloc extends HydratedBloc<AppSettingsEvent, AppSettingsState> {
  /// 🆕 **Initializes the Bloc with the persisted or default state.**
  AppSettingsBloc() : super(AppSettingsState.initial()) {
    on<ToggleStateShapeEvent>(_onToggleStateShape);
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  /// 🔄 **Handles toggling between Listener and StreamSubscription state shape.**
  void _onToggleStateShape(
      ToggleStateShapeEvent event, Emitter<AppSettingsState> emit) {
    final newStateShape = state.isUsingListenerStateShapeForAppFeatures
        ? AppStateShapeManagement.withStreamSubscription
        : AppStateShapeManagement.withListener;

    emit(state.copyWith(stateShapeManagement: newStateShape));
  }

  /// 🎨 **Handles toggling between Light and Dark mode.**
  void _onToggleTheme(ToggleThemeEvent event, Emitter<AppSettingsState> emit) {
    emit(state.copyWith(isDarkTheme: event.isDarkMode));
  }

  /// 💾 **Serializes the state to JSON for persistence.**
  @override
  Map<String, dynamic>? toJson(AppSettingsState state) {
    return {
      'isUsingListenerStateShapeForAppFeatures':
          state.isUsingListenerStateShapeForAppFeatures,
      'isDarkTheme': state.isDarkTheme,
    };
  }

  /// 💾 **Restores the state from JSON after app restart.**
  @override
  AppSettingsState? fromJson(Map<String, dynamic> json) {
    return AppSettingsState(
      stateShapeManagement:
          (json['isUsingListenerStateShapeForAppFeatures'] as bool? ?? true)
              ? AppStateShapeManagement.withListener
              : AppStateShapeManagement.withStreamSubscription,
      isDarkTheme: json['isDarkTheme'] as bool? ?? false,
    );
  }
}
