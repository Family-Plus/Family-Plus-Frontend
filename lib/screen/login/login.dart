import 'package:family_plus/screen/login/localWidgets/login_form.dart';
import 'package:flutter/material.dart';

class OurLogin extends StatelessWidget {
  const OurLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(20.0),
            children: [
              Padding(
                padding: EdgeInsets.all(40.0),
                child: Image.network(
                    "https://w7.pngwing.com/pngs/306/829/png-transparent-logo-family-freeform-family-material-love-png-material-text.png"),
              ),
              SizedBox(height: 20.0),
              OurLoginForm(),
            ],
          ))
        ],
      ),
    );
  }
}
