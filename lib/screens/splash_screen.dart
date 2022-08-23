import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:whatsapp_clone/pages/loginPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //height: MediaQuery.of(context).size.height,
        //width: MediaQuery.of(context).size.width,
        children: [
          SafeArea(
            child: Column(
              children: const [
                SizedBox(
                  height: 150,
                ),
                Center(
                  child: Text(
                    "Welcome to Whatsapp Clone",
                    style: TextStyle(
                      fontSize: 26,
                      color: Color.fromARGB(255, 3, 239, 7),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Agree to accept the Whatsapp Clone Terms & Conditions",
                    style: TextStyle(
                      fontSize: 26,
                      color: Color.fromARGB(255, 199, 45, 238),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Agree and Continue",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.deepOrange[200],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 125,
          ),
          const SizedBox(
            width: 250,
            height: 250,
            child: RiveAnimation.asset(
                'lib/animations/2193-4329-message-icon.riv'),
          ),
        ],
      ),
    );
  }
}
