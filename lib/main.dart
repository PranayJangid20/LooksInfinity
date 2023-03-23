import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lookinfinity/featues/Home/presentation/home.dart';
import 'package:lookinfinity/uttils/logic_data.dart';
import 'common/app_constant.dart';
import 'uttils/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Looks Infinity',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _MyHomePageState extends State<MyHomePage> {
  Color bodyColor = const Color(0XFF111111);

  @override
  Widget build(BuildContext context) {
    return const Splash();
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    dbFetch();
    Timer(const Duration(seconds: 7), () {
      if (dataSet != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        showMyDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: AppConstant.APPBAR_BACKGROUND_COLOR,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "Assets/images/lookanim.gif",
                  width: double.infinity,
                ),
              ],
            ),
          )),
    );
  }
}
