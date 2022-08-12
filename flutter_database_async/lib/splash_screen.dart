import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future delay() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pushNamed("/cadastro");
    });
  }

  @override
  void initState() {
    delay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Image.asset('assets/carrefy.png')],
      ),
    ));
  }
}
