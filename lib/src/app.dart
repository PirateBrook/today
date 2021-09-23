import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today/src/api/api.dart';
import 'package:today/src/api/mock.dart';
import 'package:today/src/auth/auth.dart';
import 'package:today/src/auth/mock.dart';
import 'package:today/src/pages/home.dart';
import 'package:today/src/pages/sign_in.dart';

/// The global state the app.
class AppState {
  TodayApi api;
  final Auth auth;
  AppState(this.auth);
}

typedef ApiBuilder = TodayApi Function(User user);

class TodayApp extends StatefulWidget {
  static TodayApi _mockApiBuilder(User user) =>
      MockTodayApi()..fillWithMockData();

  final Auth auth;
  final ApiBuilder apiBuilder;

  TodayApp.mock() :
        auth = MockAutService(),
        apiBuilder = _mockApiBuilder;

  @override
  State<StatefulWidget> createState() => _TodayAppState();
}

class _TodayAppState extends State<TodayApp> {
  AppState _appState;

  @override
  void initState() {
    super.initState();
    _appState = AppState(widget.auth);
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: _appState,
      child: MaterialApp(
        home: SignInSwitcher(
          appState: _appState,
          apiBuilder: widget.apiBuilder,
        ),
      ),
    );
  }
}

class SignInSwitcher extends StatefulWidget {
  final AppState appState;
  final ApiBuilder apiBuilder;
  const SignInSwitcher({
    @required this.appState,
    this.apiBuilder,
  });

  @override
  State<StatefulWidget> createState() => _SignInSwitcherState();
}

class _SignInSwitcherState extends State<SignInSwitcher> {
  bool _isSignedIn = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeOut,
      duration: const Duration(milliseconds: 200),
      child: _isSignedIn
          ? HomePage(
              onSignOut: _handleSignOut,
            )
          : SignInPage(
              auth: widget.appState.auth,
              onSuccess: _handleSignIn,
            ),
    );
  }

  Future _handleSignOut() async {
    await widget.appState.auth.signOut();
    setState(() {
      _isSignedIn = false;
    });
  }

  void _handleSignIn(User user) {
    widget.appState.api = widget.apiBuilder(user);

    setState(() {
      _isSignedIn = true;
    });
  }
}
