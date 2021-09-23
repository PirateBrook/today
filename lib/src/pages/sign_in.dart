import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:today/src/auth/auth.dart';

class SignInPage extends StatelessWidget {
  final Auth auth;
  final ValueChanged<User> onSuccess;

  const SignInPage({@required this.auth, @required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SignInButton(auth: auth, onSuccess: onSuccess),
      ),
    );
  }
}

class SignInButton extends StatefulWidget {
  final Auth auth;
  final ValueChanged<User> onSuccess;

  const SignInButton({@required this.auth, @required this.onSuccess});

  @override
  State<StatefulWidget> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  Future<bool> _checkSignInFuture;

  Future<bool> _checkIfSignedIn() async {
    var alreadySignedIn = await widget.auth.isSignedIn;
    if (alreadySignedIn) {
      var user = await widget.auth.signIn();
      widget.onSuccess(user);
    }
    return alreadySignedIn;
  }

  Future<void> _signIn() async {
    try {
      var user = await widget.auth.signIn();
      widget.onSuccess(user);
    } on SignInException {
      _showError();
    }
  }

  void _showError() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Unable to sign in."),
    ));
  }

  @override
  void initState() {
    super.initState();
    this._checkSignInFuture = _checkIfSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkSignInFuture,
      builder: (context, snapshot) {
        var alreadySignedIn = snapshot.data;
        if (snapshot.connectionState != ConnectionState.done ||
            alreadySignedIn == true) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          _showError();
        }

        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/images/sun.png'),
                ),
              ),
            ),
            buildSigninForm()
          ],
        );
      },
    );
  }

  Widget buildSigninForm() {
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.bottomCenter,
      constraints: BoxConstraints.loose(const Size(600, 600)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Username',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
        ],
      ),
    );
  }
}
