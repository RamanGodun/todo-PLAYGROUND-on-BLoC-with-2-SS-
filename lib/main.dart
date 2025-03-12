import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'domain/app_constants/app_strings.dart';
import 'domain/config/observer/app_bloc_observer.dart';
import 'domain/utils_and_services/bloc_exports.dart';
import 'ui/pages/home_page.dart';

/// 🚀 **[main] - Application entry point.**
/// - Initializes **HydratedBloc** for state persistence.
/// - Sets up **BlocObserver** for global state monitoring.
/// - Runs the app wrapped with **StateManagementProvider**.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🛠️ **Set up a global BLoC observer**
  Bloc.observer = AppBlocObserver();

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
  runApp(const StateManagementProvider());
}

/// 📦 **[StateManagementProvider] - Provides all BLoC dependencies**
/// - Registers **AppSettingsBloc**.
/// - Manages **Listener-based & Stream Subscription-based** state shapes.
class StateManagementProvider extends StatelessWidget {
  const StateManagementProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// 🎨 **App Settings Provider** (Manages Theme & State Shape)
        BlocProvider(create: (_) => AppSettingsBloc()),
        BlocProvider<TodoListBloc>(create: (context) => TodoListBloc()),
        BlocProvider<TodoFilterBloc>(create: (context) => TodoFilterBloc()),
        BlocProvider<TodoSearchBloc>(create: (context) => TodoSearchBloc()),

        /// 🟧 Providers for "Listeners" state-shape
        BlocProvider<ActiveTodoCountBlocWithListenerStateShape>(
            create: (context) => ActiveTodoCountBlocWithListenerStateShape(
                  todoListBloc: context.read<TodoListBloc>(),
                )),
        BlocProvider<FilteredTodosBlocWithListenerStateShape>(
            create: (context) => FilteredTodosBlocWithListenerStateShape(
                initialTodos: context.read<TodoListBloc>().state.todos)),

        /// 🟦 Providers for "Stream Subscription" state-shape
        BlocProvider<ActiveTodoCountBlocWithStreamSubscriptionStateShape>(
          create: (context) =>
              ActiveTodoCountBlocWithStreamSubscriptionStateShape(
            todoListBloc: BlocProvider.of<TodoListBloc>(context),
          ),
        ),
        BlocProvider<FilteredTodosBlocWithStreamSubscriptionStateShape>(
            create: (context) =>
                FilteredTodosBlocWithStreamSubscriptionStateShape(
                    initialTodos: context.read<TodoListBloc>().state.todos,
                    todoFilterBloc: BlocProvider.of<TodoFilterBloc>(context),
                    todoSearchBloc: BlocProvider.of<TodoSearchBloc>(context),
                    todoListBloc: BlocProvider.of<TodoListBloc>(context))),
      ],
      child: const AppView(),
    );
  }
}

/// 🎨 **[AppView] - Builds the main MaterialApp**
/// - Listens for theme changes via **AppSettingsBloc**.
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
