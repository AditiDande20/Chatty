import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

Future<UserCredential?> registerWithEmailAndPassword(
    String email, String password, BuildContext context) async {
  try {
    var userCredentials =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredentials;
  } on FirebaseAuthException catch (e) {
    showErrorCommonModal(
        context: context,
        heading: e.message.toString(),
        description: '',
        buttonName: ConstantsData.ok);
  }
  return null;
}

Future<UserCredential?> signInWithEmailAndPassword(
    String email, String password, BuildContext context) async {
  try {
    var userCredentials =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredentials;
  } on FirebaseAuthException catch (e) {
    var message = ConstantsData.somethingWentWrong;
    switch (e.code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        message = ConstantsData.notRegistered;
    }
    showErrorCommonModal(
        context: context,
        heading: message.toString(),
        description: '',
        buttonName: ConstantsData.ok);
  }
  return null;
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

Future<String?> uploadImagetoFirebaseStorage(
    File file, BuildContext context) async {
  try {
    var storageAuth = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child('${FirebaseAuth.instance.currentUser?.uid}.jpg');
    await storageAuth.putFile(file);
    String imageURL = await storageAuth.getDownloadURL();
    return imageURL;
  } on FirebaseException {
    // showErrorCommonModal(
    //     context: context,
    //     heading: e.message.toString(),
    //     description: '',
    //     buttonName: ConstantsData.ok);
  }
  return null;
}

saveDatatoFirestoreDatabase(
    String collectionName, String id, dynamic map, BuildContext context) async {
  try {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .set(map);
  } on FirebaseException catch (e) {
    showErrorCommonModal(
        context: context,
        heading: e.message.toString(),
        description: '',
        buttonName: ConstantsData.ok);
  }
}

updateDatatoFirestoreDatabase(
    String collectionName, String id, dynamic map, BuildContext context) async {
  try {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .update(map);
  } on FirebaseException catch (e) {
    showErrorCommonModal(
        context: context,
        heading: e.message.toString(),
        description: '',
        buttonName: ConstantsData.ok);
  }
}

deleteDatatoFirestoreDatabase(
    String collectionName, String id,  BuildContext context) async {
  try {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .delete();
  } on FirebaseException catch (e) {
    showErrorCommonModal(
        context: context,
        heading: e.message.toString(),
        description: '',
        buttonName: ConstantsData.ok);
  }
}

Future<DocumentSnapshot<Map<String, dynamic>>?> getDataFromFirestoreDatabase(
    String collectionName, BuildContext context) async {
  try {
    var response = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    return response;
  } on FirebaseException catch (e) {
    showErrorCommonModal(
        context: context,
        heading: e.message.toString(),
        description: '',
        buttonName: ConstantsData.ok);
  }
  return null;
}

Future<QuerySnapshot<Map<String, dynamic>>?> getListFromFirestoreDatabase(
    String collectionName, BuildContext context, String orderByField) async {
  try {
    var response;
    if (orderByField.isNotEmpty) {
      response = await FirebaseFirestore.instance
          .collection(collectionName)
          .orderBy(orderByField, descending: true)
          .get();
    } else {
      response =
          await FirebaseFirestore.instance.collection(collectionName).get();
    }

    return response;
  } on FirebaseException catch (e) {
    showErrorCommonModal(
        context: context,
        heading: e.message.toString(),
        description: '',
        buttonName: ConstantsData.ok);
  }
  return null;
}
