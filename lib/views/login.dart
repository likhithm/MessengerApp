import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class Login extends StatefulWidget {
  @override
  State createState() => new LoginState();
}

class _LoginData {
  String phone = '';
  String countryCode = '';
}

class LoginState extends State<Login> {
  TextEditingController phoneC = new TextEditingController();
  _LoginData _data = new _LoginData();

  void _submit() {
    print("New Country selected: " + _data.phone);
    print("New Country selected: " + _data.countryCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Center(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
              child: loginForm())),
    );
  }

  Widget loginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      verticalDirection: VerticalDirection.down,
      children: <Widget>[
        Text(
          "Verify Your Phone Number",
          style: TextStyle(
            color: Colors.teal,
            fontSize: 25.0,
          ),
        ),
        Text(
          "MessengerApp will send you verification code at this number. Please select the country code and give a valid phone number",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center,
        ),
        Form(
            child: Column(children: <Widget>[
          CountryCodePicker(
              onChanged: (CountryCode cc) {
                this._data.countryCode = cc.toString();
              },
              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
              initialSelection: 'US',
              favorite: ['US', '+91'],
              // optional. Shows only country name and flag
              showCountryOnly: false),
          TextField(
            onChanged: (String value){
              this._data.phone = value;
            },
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Verify Your Phone Number',
            ),
          )
        ])),
        RawMaterialButton(
          fillColor: const Color(0xFF1BD741),
          splashColor: const Color(0xFF35BBA0),
          onPressed: _submit,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
