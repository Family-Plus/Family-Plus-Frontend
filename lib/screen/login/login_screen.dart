import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_plus/screen/signup/signup_screen.dart';
import 'package:family_plus/services/auth_state_changes.dart';
import 'package:family_plus/states/current_user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool obscureText = true;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFEB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //IMAGE COVER
                Image.asset('images/logo.png'),
                const SizedBox(height: 24),

                //SUBTITLE
                const Center(
                  child: Text(
                    'Login to your account',
                    style: TextStyle(
                      color: Colors.black54,
                      //fontWeight: FontWeight.,
                      fontSize: 22,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                //TF EMAIL
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 16),

                //TF PASSWORD
                TextField(
                  controller: _passwordController,
                  obscureText: obscureText,
                  autocorrect: false,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 16),

                //FORGOT PASSWORD
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Forgot Password",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                //BUTTON LOGIN
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const StadiumBorder(),
                    minimumSize: const Size(double.maxFinite, 50),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: () {
                    _loginUser(_emailController.text, _passwordController.text, context);
                  },
                ),
                const SizedBox(height: 16),

                //DEVIDER
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Divider(
                        color: Colors.black,
                      ),
                      Positioned(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 20),
                          color: const Color(0xFFF0EFEB),
                          child: Text(
                            'or',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                //FACEBOOK
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const StadiumBorder(),
                    minimumSize: const Size(double.maxFinite, 50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 16),
                      Text(
                        "Continue with Facebook",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Alert(
                      context: context,
                      type: AlertType.info,
                      title: "Fitur Coming Soon",
                      desc: "Please use SignUp or Login",
                      buttons: [
                        DialogButton(
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                          child: const Text(
                            "Ok",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ],
                    ).show();
                  },
                ),
                const SizedBox(height: 16),

                //GOOGLE
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const StadiumBorder(),
                    minimumSize: const Size(double.maxFinite, 50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 16),
                      Text(
                        "Continue with Google",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Alert(
                      context: context,
                      type: AlertType.info,
                      title: "Fitur Coming Soon",
                      desc: "Please use SignUp or Login",
                      buttons: [
                        DialogButton(
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                          child: const Text(
                            "Ok",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ],
                    ).show();
                  },
                ),
                const SizedBox(height: 32),

                //SIGN UP
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Dont have an account? ",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Create ",
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginUser(String email, String password, BuildContext context) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);

    // showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator()));

    try {
      String returnString = await currentUser.loginWithEmail(email, password);
      if (returnString == 'succes') {
        if(!mounted)return;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const AuthChanges()));
      }else{
        if(!mounted)return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(returnString),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } on FirebaseException catch  (e) {
      if (kDebugMode) {
        print(e);
      }
    }

  }
}
