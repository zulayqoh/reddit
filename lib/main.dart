import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reddit/core/common/error404.dart';
import 'package:reddit/core/models/user_model.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:reddit/features/auth/screens/signin_screen.dart';
import 'package:reddit/route.dart';
import 'package:reddit/theme/palette.dart';
import 'package:routemaster/routemaster.dart';
import 'core/common/loader.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: RedditCloneApp()),
  );
}

class RedditCloneApp extends ConsumerStatefulWidget {
  const RedditCloneApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RedditCloneAppState();
}

class _RedditCloneAppState extends ConsumerState<RedditCloneApp> {
  UserModel? userModel;

  getUserModel(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userModelProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
        data: (data) {
          return MaterialApp.router(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: Palette.lightModeAppTheme,
            builder: (context, widget) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: ScreenUtilInit(
                designSize: const Size(360, 690),
                minTextAdapt: true,
                builder: (context, _) => widget ?? Container(),
              ),
            ),
            //home: const SignInScreen(),
            routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
              if (data != null) {
                getUserModel(ref, data);
                if (userModel != null) return loggedInRoute;
               }
              return loggedOutRoute;
            }),
            routeInformationParser: const RoutemasterParser(),
          );
        },
        error: (error, stackTrace) => Error404Page(
              error: error.toString(),
            ),
        loading: () => const Loader());
  }
}

   class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStateChangeProvider).when(
        data: (data) {
          return MaterialApp.router(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: Palette.lightModeAppTheme,
            builder: (context, widget) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: ScreenUtilInit(
                designSize: const Size(360, 690),
                minTextAdapt: true,
                builder: (context, _) => widget ?? Container(),
              ),
            ),
            //home: const SignInScreen(),
            routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
              if (data != null) return loggedInRoute;
              return loggedOutRoute;
            }),
            routeInformationParser: const RoutemasterParser(),
          );
        },
        error: (error, stackTrace) => Error404Page(
              error: error.toString(),
            ),
        loading: () => const Loader());
  }
}
