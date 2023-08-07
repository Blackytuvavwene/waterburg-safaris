import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';
import 'package:sizer/sizer.dart';

import 'lib.dart';

// navigator keys
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // use url path strategy
// usePathUrlStrategy();
  // initialize firebase_core
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: Layout(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigatorKey = GlobalKey<NavigatorState>();
    final goRouter = ref.watch(goroutingProvider);

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.from(
            // useMaterial3: true,
            // textTheme: GoogleFonts.dosisTextTheme(
            //   Theme.of(context).textTheme.copyWith(
            //         bodySmall: TextStyle(
            //           color: Theme.of(context).colorScheme.onSurface,
            //         ),
            //       ),
            // ),
            colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: Color(0xFF92ccff),
              onPrimary: Color(0xFF003351),
              primaryContainer: Color(0xFF004b73),
              onPrimaryContainer: Color(0xFFcce5ff),
              secondary: Color(0xFF71dba6),
              onSecondary: Color(0xFF003823),
              secondaryContainer: Color(0xFF005235),
              onSecondaryContainer: Color(0xFF8df7c1),
              error: Color(0xFFffb4ab),
              onError: Color(0xFF690005),
              errorContainer: Color(0xFF93000a),
              onErrorContainer: Color(0xFFffdad6),
              background: Color(0xFF1a1c1e),
              onBackground: Color(0xFFe2e2e5),
              surface: Color(0xFF1a1c1e),
              onSurface: Color(0xFFe2e2e5),
              surfaceVariant: Color(0xFF42474e),
              onSurfaceVariant: Color(0xFFc2c7ce),
              outline: Color(0xFF8c9198),
            ),
          ),
          builder: EasyLoading.init(),
          routerConfig: goRouter,
        );
      },
    );
  }
}


