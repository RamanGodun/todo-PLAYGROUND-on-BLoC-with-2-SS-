import 'package:flutter/material.dart';


/// 💬 **[DialogService]** - A service providing reusable dialogs throughout the app.
abstract class DialogService {
  /// 🔄 **Shows a loading dialog with a centered `CircularProgressIndicator`.**
  ///
  /// This dialog is **non-dismissible**, preventing unintended closures.
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // ❌ Prevents accidental closing
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// ❌ **Closes any open dialogs.**
  ///
  /// Ensures a safe dismissal of dialogs if possible.
  static void closeDialog(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
