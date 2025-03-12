part of 'home_page.dart';

/// 🔄 **[StateShapeToggleIcon]** - Toggles between Listener-Based and StreamSubscription-Based state propagation.
class StateShapeToggleIcon extends StatelessWidget {
  const StateShapeToggleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final isListenerStateShape = context.select<AppSettingsBloc, bool>(
      (bloc) => bloc.state.isUsingListenerStateShapeForAppFeatures,
    );

    final stateShapeIcon = isListenerStateShape
        ? AppConstants.syncIcon
        : AppConstants.changeCircleIcon;
    final iconColor = Helpers.getColorScheme(context).primary;

    return IconButton(
      icon: Icon(stateShapeIcon, color: iconColor),
      onPressed: () => _toggleStateShape(context),
    );
  }

  /// 🔄 **Dispatches event to toggle between Listener-Based and StreamSubscription-Based state propagation.**
  void _toggleStateShape(BuildContext context) {
    context.read<AppSettingsBloc>().add(ToggleStateShapeEvent());

    // 🌟 Show overlay notification with appropriate message and icon
    final isListenerStateShape = context
        .read<AppSettingsBloc>()
        .state
        .isUsingListenerStateShapeForAppFeatures;

    final overlayMessage = isListenerStateShape
        ? AppStrings.statePropagationLSS
        : AppStrings.statePropagationSSS;

    final overlayIcon = isListenerStateShape
        ? AppConstants.syncIcon
        : AppConstants.changeCircleIcon;

    OverlayNotificationService.showOverlay(
      context,
      message: overlayMessage,
      icon: overlayIcon,
    );
  }
}
