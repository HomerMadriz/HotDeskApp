import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hot_desk_app/models/user.dart';

class UserProvider with ChangeNotifier {
  final _userRef = FirebaseFirestore.instance.collection('Users').withConverter(
        fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  User? _user;
  User? get getUser => _user;

  List<QueryDocumentSnapshot<User>>? _users;
  List<QueryDocumentSnapshot<User>>? get getUsers => _users;

  void getAllUsers() async {
    _users = await _requestUsers();
    notifyListeners();
  }

  void getUserById(String id) async {
    _user = await _requestUser(id);
    notifyListeners();
  }

  Future<List<QueryDocumentSnapshot<User>>?> _requestUsers() async {
    try {
      return await _userRef.get().then((value) => value.docs);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> _requestUser(String id) async {
    try {
      return _userRef.doc(id).get().then((value) => value.data()!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
