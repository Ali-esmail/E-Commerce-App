import 'package:firebase_auth/firebase_auth.dart';

class Auth{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future <UserCredential>Signup(String email, String password) async{
    final authresult=  await _auth.createUserWithEmailAndPassword(email:
    email.trim(),
        password: password.trim());
    return authresult;
  }

  Future<UserCredential> Signin(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(email: email.trim(),
        password: password.trim());
    return result;
  }

  Future<FirebaseUser> getUser() async {
    final user= await _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

}