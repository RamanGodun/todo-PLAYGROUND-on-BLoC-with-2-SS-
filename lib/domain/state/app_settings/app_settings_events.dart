part of 'app_settings_bloc.dart';

/// 🏷️ **[AppSettingsEvent]** - Defines events for [AppSettingsBloc].
sealed class AppSettingsEvent extends Equatable {
  const AppSettingsEvent();

  @override
  List<Object> get props => [];
}

/// 🔄 **Toggles between Listener and StreamSubscription state shape.**
class ToggleStateShapeEvent extends AppSettingsEvent {}

/// 🌗 **Toggles between Light and Dark mode.**
class ToggleThemeEvent extends AppSettingsEvent {
  final bool isDarkMode;

  const ToggleThemeEvent(this.isDarkMode);

  @override
  List<Object> get props => [isDarkMode];
}
