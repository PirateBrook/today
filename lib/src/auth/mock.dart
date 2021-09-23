
import 'dart:math';

import 'auth.dart';

class MockAutService implements Auth {

  @override
  Future<bool> get isSignedIn async => false;

  @override
  Future<User> signIn() async {
    var random = Random();
    if (random.nextInt(4) == 0) {
      throw SignInException();
    }
    return MockUser();
  }

  @override
  Future signOut() async {
    throw null;
  }
}

class MockUser implements User {
  @override
  String get uid => "123";

}