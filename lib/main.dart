import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'domain/app_constants/app_strings.dart';
import 'domain/config/observer/app_bloc_observer.dart';
import 'domain/utils_and_services/bloc_exports.dart';
import 'ui/pages/home_page.dart';

/// 🚀 **[main] - Application Entry Point**
/// - Initializes **HydratedBloc** for state persistence.
/// - Sets up **BlocObserver** for global state monitoring.
/// - Launches the app wrapped with **StateManagementProvider**.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🛠️ **Set up a global BLoC observer** (for debugging & state monitoring)
  Bloc.observer = AppBlocObserver();

  /// 💾 **Initialize Hydrated Storage** (Persistent State Management)
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory(
            (await getApplicationDocumentsDirectory()).path),
  );
  HydratedBloc.storage = storage;
  // HydratedBloc.storage.clear(); // ? Use this for testing with a fresh state

  /// 🏁 **Launch the App**
  runApp(const StateManagementProvider());
}

/// 📦 **[StateManagementProvider] - Provides all BLoC dependencies**
class StateManagementProvider extends StatelessWidget {
  const StateManagementProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// 🎨 **App Settings Provider** (Manages Theme & State Shape)
        BlocProvider(create: (_) => AppSettingsBloc()),

        /// ✅ **Core Business Logic Providers** (ToDo Features)
        BlocProvider<TodoListBloc>(create: (context) => TodoListBloc()),
        BlocProvider<TodoFilterBloc>(create: (context) => TodoFilterBloc()),
        BlocProvider<TodoSearchBloc>(create: (context) => TodoSearchBloc()),

        /// 🟧 **Providers for Listener-Based State Shape**
        BlocProvider<ActiveTodoCountBlocWithListenerStateShape>(
            create: (context) => ActiveTodoCountBlocWithListenerStateShape(
                  todoListBloc: context.read<TodoListBloc>(),
                )),
        BlocProvider<FilteredTodosBlocWithListenerStateShape>(
            create: (context) => FilteredTodosBlocWithListenerStateShape(
                initialTodos: context.read<TodoListBloc>().state.todos)),

        /// 🟦 **Providers for Stream Subscription-Based State Shape**
        BlocProvider<ActiveTodoCountBlocWithStreamSubscriptionStateShape>(
          create: (context) =>
              ActiveTodoCountBlocWithStreamSubscriptionStateShape(
            todoListBloc: context.read<TodoListBloc>(),
          ),
        ),
        BlocProvider<FilteredTodosBlocWithStreamSubscriptionStateShape>(
            create: (context) =>
                FilteredTodosBlocWithStreamSubscriptionStateShape(
                    initialTodos: context.read<TodoListBloc>().state.todos,
                    todoFilterBloc: context.read<TodoFilterBloc>(),
                    todoSearchBloc: context.read<TodoSearchBloc>(),
                    todoListBloc: context.read<TodoListBloc>())),
      ],
      child: const AppView(),
    );
  }
}

/// 🎨 **[AppView] - Builds the Main `MaterialApp`**
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      /// 🚀 **Rebuilds only when the theme changes**
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
