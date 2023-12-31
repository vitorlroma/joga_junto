import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/core/common/error_text.dart';
import 'package:joga_junto/core/common/loader.dart';
import 'package:joga_junto/features/auth/controller/auth_controller.dart';
import 'package:joga_junto/firebase_options.dart';
import 'package:joga_junto/models/user_model.dart';
import 'package:joga_junto/router.dart';
import 'package:joga_junto/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack,);
  runApp(const ProviderScope(
      child: MyApp(),
    )
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;
  
  void getData(WidgetRef ref, User data) async {
    userModel = await ref.watch(authControllerProvider.notifier).getUserData(data.uid).first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
      data: (data) => MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: Pallete.darkModeAppTheme,
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) {
          if (data!=null) {
            getData(ref, data);
            if (userModel != null ) {
              return loggedInRoute;
            }
          }
          return loggedOutRoute;
        }
      ),
      routeInformationParser: const RoutemasterParser(),
      ), 
      error: (error, stackTrace) => ErrorText(error: error.toString()), 
      loading: () => const Loader(),
    );
  }
}

