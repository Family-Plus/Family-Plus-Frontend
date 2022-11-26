import 'package:family_plus/screen/home/home_page.dart';
import 'package:family_plus/screen/signup/signup.dart';
import 'package:family_plus/states/current_user.dart';
import 'package:family_plus/widgets/our_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurLoginForm extends StatefulWidget {
  const OurLoginForm({Key? key}) : super(key: key);

  @override
  State<OurLoginForm> createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return OurContainer(
        child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
          child: Text(
            'Log In',
            style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.alternate_email), hintText: 'Email'),
        ),
        SizedBox(height: 20.0),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline), hintText: 'Password'),
        ),
        SizedBox(height: 20.0),
        RaisedButton(
          onPressed: () {
            _loginUser(
                _emailController.text, _passwordController.text, context);
          },
          padding: EdgeInsets.symmetric(horizontal: 100),
          child: Text(
            'Log In',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OurSignUp(),
              ),
            );
          },
          child: Text('Tidak punya akun ? Daftar disini'),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        )
      ],
    ));
  }

  void _loginUser(String email, String password, BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      if (await _currentUser.logInUser(email, password)) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }else{
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Username atau password anda salah "),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
