import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../domain/app_constants/app_constants.dart';
import '../../domain/app_constants/app_strings.dart';
import '../../domain/models/enums.dart';
import '../../domain/utils_and_services/bloc_exports.dart';
import '../../domain/utils_and_services/debounce.dart';
import '../../domain/utils_and_services/helpers.dart';
import 'text_widget.dart';

/// 🔎 **[SearchAndFilterTodo] - ToDo Search & Filter Widget**
/// - Uses **flutter_hooks** for better state management.
/// - Implements a **debounce mechanism** to optimize search queries.
/// - Provides **filter buttons** for different task categories.

class SearchAndFilterTodo extends HookWidget {
  const SearchAndFilterTodo({super.key});

  @override
  Widget build(BuildContext context) {
    /// ⏳ **Creates a Debounce instance using `useMemoized`**
    final debounce = useMemoized(() => Debounce(milliseconds: 300));

    /// 🔄 **Disposes the debounce timer when widget is destroyed**
    useEffect(() => () => debounce.dispose(), const []);

    return ListView(
      shrinkWrap: true,
      primary: true,
      children: [
        /// 🔍 **Search input field**
        TextField(
          style: Helpers.getTextTheme(context).titleMedium,
          decoration: const InputDecoration(
            labelText: AppStrings.searchTodosLabel,
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (String? newSearchTerm) {
            if (newSearchTerm != null) {
              debounce.run(() {
                context
                    .read<TodoSearchBloc>()
                    .add(SetSearchTermEvent(newSearchTerm: newSearchTerm));
              });
            }
          },
        ),
        const SizedBox(height: 10.0),

        /// 🏷️ **Filter buttons for task categories**
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _filterButton(context, Filter.all, AppStrings.filterAll),
            _filterButton(context, Filter.active, AppStrings.filterActive),
            _filterButton(
                context, Filter.completed, AppStrings.filterCompleted),
          ],
        ),

        /// ➖ **Divider for UI separation**
        Divider(
          color: Helpers.getColorScheme(context).onSurface.withOpacity(0.3),
          thickness: 2.5,
        ),
      ],
    );
  }
}

/// 🔘 [_FilterButton] - Creates a reusable filter button.
Widget _filterButton(BuildContext context, Filter filter, String label) {
  return TextButton(
    onPressed: () => context
        .read<TodoFilterBloc>()
        .add(ChangeFilterEvent(newFilter: filter)),
    child: TextWidget(
      label,
      TextType.titleMedium,
      color: _getTextColor(context, filter),
    ),
  );
}

/// 🎨 [_getTextColor] - Returns the appropriate color for the filter button.
Color _getTextColor(BuildContext context, Filter filter) {
  final currentFilter = context.watch<TodoFilterBloc>().state.filter;
  return currentFilter == filter
      ? AppConstants.activeFilter
      : AppConstants.darkSurfaceColor;
}
