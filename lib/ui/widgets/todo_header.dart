import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/app_constants/app_constants.dart';
import '../../domain/app_constants/app_strings.dart';
import '../../domain/utils_and_services/bloc_exports.dart';
import 'text_widget.dart';

/// 📌 [TodoHeader] - A common reusable header widget for the ToDo list.
/// Dynamically switches between **Listener-Based** and **Stream Subscription-Based** state shapes.
class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    /// 🔄 Retrieves the current **State Shape Mode** from [AppSettingsCubit].
    final isListenerStateShape = context.select<AppSettingsBloc, bool>(
      (cubit) => cubit.state.isUsingListenerStateShapeForAppFeatures,
    );

    /// 🏷️ Retrieves the correct title based on the selected **State Shape Mode**.
    final appBarTitle = isListenerStateShape
        ? AppStrings.titleForListenerBasedStateShape
        : AppStrings.titleForStreamSubscriptionStateShape;

    return isListenerStateShape
        ? TodoHeaderForListenerStateShape(appBarTitle: appBarTitle)
        : TodoHeaderForStreamSubscriptionStateShape(appBarTitle: appBarTitle);
  }
}

/// ! 🔵 **Header for Stream Subscription-Based State Shape**
class TodoHeaderForStreamSubscriptionStateShape extends StatelessWidget {
  final String appBarTitle;

  const TodoHeaderForStreamSubscriptionStateShape({
    super.key,
    required this.appBarTitle,
  });

  @override
  Widget build(BuildContext context) {
    /// 🎯 Retrieves the **active ToDo count** from the Stream Subscription-based Cubit.
    final activeTodoCount = context
        .watch<ActiveTodoCountBlocWithStreamSubscriptionStateShape>()
        .state
        .activeTodoCount;

    return TodoHeaderContent(
      activeTodoCount: activeTodoCount,
      appBarTitle: appBarTitle,
    );
  }
}

/// ! 🟠 **Header for Listener-Based State Shape**
class TodoHeaderForListenerStateShape extends StatelessWidget {
  final String appBarTitle;

  const TodoHeaderForListenerStateShape({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoListBloc, TodoListStateOnBloc>(
      /// 🔄 Listens for updates in the ToDo list and recalculates the **active ToDo count**.
      listener: (context, state) {
        final activeTodoCount =
            state.todos.where((todo) => !todo.completed).length;

        context.read<ActiveTodoCountBlocWithListenerStateShape>().add(
            CalculateActiveTodoCountEventWithListenerStateShape(
                activeTodoCount: activeTodoCount));
      },
      child: BlocBuilder<ActiveTodoCountBlocWithListenerStateShape,
          ActiveTodoCountStateOnBlocWithListenerStateShape>(
        builder: (context, state) {
          return TodoHeaderContent(
            activeTodoCount: state.activeTodoCount,
            appBarTitle: appBarTitle,
          );
        },
      ),
    );
  }
}

/// 🎨 **Reusable UI component for the Todo Header**.
class TodoHeaderContent extends StatelessWidget {
  final int activeTodoCount;
  final String appBarTitle;

  const TodoHeaderContent({
    super.key,
    required this.activeTodoCount,
    required this.appBarTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextWidget(
          '$activeTodoCount',
          TextType.titleMedium,
          color: AppConstants.errorColor,
        ),
        TextWidget(appBarTitle, TextType.titleMedium),
      ],
    );
  }
}
