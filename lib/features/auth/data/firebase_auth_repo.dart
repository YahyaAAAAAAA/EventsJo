import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/repos/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> getCurrentUser() async {
    //get current user
    final firebaseUser = firebaseAuth.currentUser;
    //fetch user's name
    final name = await getCurrentUserName();

    //no user logged in
    if (firebaseUser == null) {
      return null;
    }

    //user exists
    return AppUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
      name: name ?? '',
    );
  }

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      //attemps sign in
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      //fetch user's name
      final name = await getCurrentUserName();

      //create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name ?? '',
      );
      return user;
    } catch (e) {
      throw Exception('Login Failed $e');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
      String name, String email, String password) async {
    try {
      //attemps sign up
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      //create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );

      //save user data in firestore
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(user.toJson());

      return user;
    } catch (e) {
      throw Exception('Register Failed $e');
    }
  }

  Future<String?> getCurrentUserName() async {
    //current user
    final firebaseUser = firebaseAuth.currentUser;

    //access users
    final collection = FirebaseFirestore.instance.collection('users');

    //get data fields as json
    final docSnapshot = await collection.doc(firebaseUser!.uid).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;

      return data['name'];
    }

    return '';
  }
}
