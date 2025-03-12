import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'domain/app_constants/app_strings.dart';
import 'domain/config/observer/app_bloc_observer.dart';
import 'domain/state/app_settings/app_settings_bloc.dart';
import 'domain/config/loader/loader_cubit.dart';
import 'ui/pages/home_page.dart';

/// 🚀 **[main] - Application entry point.**
/// - Initializes **HydratedBloc** for state persistence.
/// - Sets up **BlocObserver** for global state monitoring.
/// - Runs the app wrapped with **StateManagementProvider**.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🌐 **Global Loader Cubit** - Manages loading state across the app.
  final globalLoader = GlobalLoaderCubit();

  // 🛠️ **Set up a global BLoC observer**
  Bloc.observer = AppBlocObserver(globalLoaderCubit: globalLoader);

  /// 💾 **Initialize Hydrated Storage** (State Persistence)
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory(
            (await getApplicationDocumentsDirectory()).path),
  );
  HydratedBloc.storage = storage;
  // HydratedBloc.storage.clear(); // ? for test mode

  /// 🏁 **Launch the app**
  runApp(StateManagementProvider(globalLoaderCubit: globalLoader));
}

/// 📦 **[StateManagementProvider] - Provides all BLoC dependencies**
/// - Registers **GlobalLoaderCubit, AppSettingsCubit, Todo Cubits**.
/// - Manages **Listener-based & Stream Subscription-based** state shapes.
class StateManagementProvider extends StatelessWidget {
  final GlobalLoaderCubit globalLoaderCubit;

  const StateManagementProvider({super.key, required this.globalLoaderCubit});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// 🔄 **Global Loader Provider** (Used for async operations)
        BlocProvider(create: (_) => globalLoaderCubit),

        /// 🎨 **App Settings Provider** (Manages Theme & State Shape)
        BlocProvider(create: (_) => AppSettingsBloc()),
      ],
      child: const AppView(),
    );
  }
}

/// 🎨 **[AppView] - Builds the main MaterialApp**
/// - Listens for theme changes via **AppSettingsCubit**.
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      buildWhen: (previous, current) =>
          previous.isDarkTheme != current.isDarkTheme,
      builder: (context, state) {
        return MaterialApp(
          title: AppStrings.appTitle,
          debugShowCheckedModeBanner: false,
          theme: state.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
          home: const HomePage(),
        );
      },
    );
  }
}
