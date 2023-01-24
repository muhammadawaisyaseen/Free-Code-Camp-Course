// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freecodecampcourse/cloud/cloud_storage_constants.dart';

// ignore: empty_constructor_bodies
@immutable
class CloudNote {
  final String documentId;
  final String ownerUserId;
  final String text;
  const CloudNote({
    required this.documentId,
    required this.ownerUserId,
    required this.text,
  });

// We need to represent a note on cloud firestore
  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapShot)
      : documentId = snapShot.id,
        ownerUserId = snapShot.data()[ownerUserIdFieldName],
        text = snapShot.data()[textFieldName] as String;
}
