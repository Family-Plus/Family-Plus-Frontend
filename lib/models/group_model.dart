import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  String id;
  String name;
  String leader;
  List<String> members;
  List<String> tokens;
  Timestamp groupCreated;


  GroupModel({
    required this.id,
    required this.name,
    required this.leader,
    required this.members,
    required this.tokens,
    required this.groupCreated,
  });


}