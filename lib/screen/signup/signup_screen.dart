import 'package:family_plus/screen/login/login_screen.dart';
import 'package:family_plus/states/current_user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool obscureText = true;
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
                //TITLE
                const Center(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                //SUBTITLE
                const Center(
                  child: Text(
                    'Create your account',
                    style: TextStyle(
                      color: Colors.black54,
                      //fontWeight: FontWeight.,
                      fontSize: 22,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                //TF NAMA
                TextField(
                  controller: _fullNameController,
                  keyboardType: TextInputType.name,
                  autocorrect: false,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Name',
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

                //TF EMAIL
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
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
                const SizedBox(height: 40),

                //BUTTON SIGN UP
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const StadiumBorder(),
                    minimumSize: const Size(double.maxFinite, 50),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: () {
                    _signUpUser(
                        _emailController.text, _passwordController.text, context, _fullNameController.text);


                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const LoginScreen(),
                      ),
                    );
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
                  onPressed: () {},
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
                  onPressed: () {},
                ),
                const SizedBox(height: 32),

                //LOGIN
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Login ",
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

  void _signUpUser(String email, String password, BuildContext context, String fullName) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    try {
      String _returnString = await _currentUser.signUpUser(email, password, fullName);
      if (_returnString == 'succes') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen(),
          ),
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_returnString),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

}
