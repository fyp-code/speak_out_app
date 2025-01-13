import 'package:firebase_auth/firebase_auth.dart';
import 'package:speak_out_app/services/shared_pref_service.dart';

class FirebaseAuthService {
  FirebaseAuthService();

  final FirebaseAuth auth = FirebaseAuth.instance;

  bool get isLogin => auth.currentUser != null;
  late AuthStatus _status;
  Future<User> handleSignIn(String email, String password) async {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final User? user = result.user;

    if (user == null) throw 'No current user';
    return user;
  }

  Future<User> handleSignUp(email, password, name) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    if (user == null) throw 'No current user';
    await user.updateProfile(displayName: name);
    return user;
  }

  Future<AuthStatus> handleForgetPassword(String emailAddress) async {
    await auth
        .sendPasswordResetEmail(email: emailAddress)
        .then((value) => _status = AuthStatus.successful);

    return _status;
  }

  Future<void> logout([bool shouldRemoveLocalData = true]) async {
    if (isLogin) {
      await auth.signOut();
    }
    if (shouldRemoveLocalData) {
      await SharedPrefService().clearAllData();
    }
  }

  Future<void> deleteAccount() async {
    await auth.currentUser?.delete();
  }

  Future<String?> accessToken() async {
    return await auth.currentUser?.getIdToken();
  }
}

enum AuthStatus {
  successful,
  wrongPassword,
  emailAlreadyExists,
  invalidEmail,
  weakPassword,
  unknown,
}
