import 'package:chatty/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? email;
  String? imageUrl;
  String? userId;
  String? createdDate;

  UserModel(
      {required this.userId,
      required this.name,
      required this.email,
      required this.imageUrl,
      required this.createdDate});

  Map<String, dynamic> toJson() => {
        UserCollection.userId: userId,
        UserCollection.name: name,
        UserCollection.email: email,
        UserCollection.imageUrl: imageUrl,
        UserCollection.createdTime: createdDate,
      };

  UserModel.fromDocument(QueryDocumentSnapshot snapshot) {
    userId = snapshot.get(UserCollection.userId);
    email = snapshot.get(UserCollection.email);
    imageUrl = snapshot.get(UserCollection.imageUrl);
    createdDate = snapshot.get(UserCollection.createdTime);
    name = snapshot.get(UserCollection.name);
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    userId = snapshot.get(UserCollection.userId);
    email = snapshot.get(UserCollection.email);
    imageUrl = snapshot.get(UserCollection.imageUrl);
    createdDate = snapshot.get(UserCollection.createdTime);
    name = snapshot.get(UserCollection.name);
  }
}
