import 'package:family_plus/screen/login/login_screen.dart';
import 'package:family_plus/screen/signup/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/bg_splash.png'), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/logo_splash.png'),

            const SizedBox(
              height: 50,
            ),

            //TITLE
            const Center(
              child: Text(
                'Welcome',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            //SUBTITLE
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Create your family habits better. Let’s start your family journey',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),

            //SIGN UP
            SizedBox(
              width: 300,
              height: 44,
              child: OutlinedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const SignUpScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            //FACEBOOK
            SizedBox(
              width: 300,
              height: 45,
              child: OutlinedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  shape: const StadiumBorder(),
                ),
                icon: const FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Colors.white,
                  size: 28,
                ),
                label: const Text(
                  'Continue with Facebook',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            //GOOGLE
            SizedBox(
              width: 300,
              height: 45,
              child: OutlinedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  shape: const StadiumBorder(),
                ),
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                  size: 28,
                ),
                label: const Text(
                  'Continue with Google',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            //LOGIN
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    text: 'Login',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
