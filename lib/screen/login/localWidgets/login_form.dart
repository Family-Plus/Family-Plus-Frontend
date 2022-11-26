import 'package:family_plus/screen/signup/signup.dart';
import 'package:family_plus/widgets/our_container.dart';
import 'package:flutter/material.dart';

class OurLoginForm extends StatelessWidget {
  const OurLoginForm({Key? key}) : super(key: key);

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
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.alternate_email), hintText: 'Email'),
        ),
        SizedBox(height: 20.0),
        TextFormField(
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline), hintText: 'Password'),
        ),
        SizedBox(height: 20.0),
        RaisedButton(
          onPressed: () {},
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
}
