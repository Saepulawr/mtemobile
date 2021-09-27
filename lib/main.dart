import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtelektrik/config/routes.dart';
import 'package:mtelektrik/shared/themes/theme.dart';
import 'package:stacked_themes/stacked_themes.dart';

// import 'package:catcher/catcher.dart';
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   // await Firebase.initializeApp();

//   print("Handling a background message: ${message.notification}");
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //load themes
  await ThemeManager.initialise();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// STEP 1. Create catcher configuration.
  /// Debug configuration with dialog report mode and console handler. It will show dialog and once user accepts it, error will be shown   /// in console.
  // CatcherOptions debugOptions =
  //     CatcherOptions(DialogReportMode(), [ConsoleHandler()]);

  // /// Release configuration. Same as above, but once user accepts dialog, user will be prompted to send email with crash to support.
  // CatcherOptions releaseOptions = CatcherOptions(SilentReportMode(), [
  //   EmailManualHandler(["adm.ipul@gmail.com"])
  // ]);

  /// STEP 2. Pass your root widget (MyApp) along with Catcher configuration:
  // Catcher(
  //     rootWidget: MyApp(),
  //     debugConfig: debugOptions,
  //     releaseConfig: releaseOptions);
  _loadController();
  runApp(MyApp());
}

void _loadController() {}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      defaultThemeMode: ThemeMode.light,
      darkTheme: Themes.darkTheme,
      lightTheme: Themes.lightTheme,
      builder: (context, regularTheme, darkTheme, themeMode) => GetMaterialApp(
        /// STEP 3. Add navigator key from Catcher. It will be used to navigate user to report page or to show dialog.
        // navigatorKey: Catcher.navigatorKey,
        debugShowCheckedModeBanner: kDebugMode,
        theme: regularTheme,
        darkTheme: darkTheme,
        themeMode: themeMode!,
        routes: routes,
        routingCallback: routingCallback,
      ),
    );
  }
}
