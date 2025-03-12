import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_playground_4_bloc_two_ss/ui/widgets/text_widget.dart';

import '../../domain/app_constants/app_constants.dart';
import '../../domain/app_constants/app_strings.dart';
import '../../domain/state/app_settings/app_settings_bloc.dart';
import '../../domain/utils_and_services/helpers.dart';
import '../../domain/utils_and_services/overlay_service.dart';

part 'state_shape_toggle_icon.dart';
part 'theme_toggle_icon.dart';

/// 🏠 [HomePage] - The main screen of the application.
/// Provides toggles for switching between light/dark themes and state shape modes
/// (ListenerStateShape / StreamSubscriptionStateShape).
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: const [
          ThemeToggleIcon(),
          StateShapeToggleIcon(),
        ],
      ),
      body: const Center(
        child: TextWidget('Home page', TextType.smallHeadline),
      ),
    ));
  }
}
