part of 'home_page.dart';

/// 🌗 **[ThemeToggleIcon]** - Toggles between light and dark mode.
class ThemeToggleIcon extends StatelessWidget {
  const ThemeToggleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select<AppSettingsBloc, bool>(
      (bloc) => bloc.state.isDarkTheme,
    );

    final themeIcon =
        isDarkMode ? AppConstants.darkModeIcon : AppConstants.lightModeIcon;
    final iconColor = Helpers.getColorScheme(context).primary;

    return IconButton(
      icon: Icon(themeIcon, color: iconColor),
      onPressed: () => _toggleTheme(context),
    );
  }

  /// 🕹️ **Dispatches event to toggle between light and dark mode.**
  void _toggleTheme(BuildContext context) {
    final isDarkMode = context.read<AppSettingsBloc>().state.isDarkTheme;
    context.read<AppSettingsBloc>().add(ToggleThemeEvent(!isDarkMode));

    // 🌟 Show overlay notification with appropriate message and icon
    final overlayMessage =
        isDarkMode ? AppStrings.lightModeEnabled : AppStrings.darkModeEnabled;
    final overlayIcon =
        isDarkMode ? AppConstants.lightModeIcon : AppConstants.darkModeIcon;

    OverlayNotificationService.showOverlay(
      context,
      message: overlayMessage,
      icon: overlayIcon,
    );
  }
}
