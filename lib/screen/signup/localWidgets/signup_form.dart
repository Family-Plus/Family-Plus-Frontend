import 'package:family_plus/widgets/our_container.dart';
import 'package:flutter/material.dart';

class OurSignUpForm extends StatelessWidget {
  const OurSignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OurContainer(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              'Sign Up',
              style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline), hintText: 'Full Name'),
          ),

          SizedBox(height: 20.0),

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

          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_open), hintText: 'Confirm Password'),
          ),
          SizedBox(height: 20.0),

          RaisedButton(
            onPressed: () {},
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Text(
              'Sign Up',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}
