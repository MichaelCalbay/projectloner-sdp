import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class LonerUser extends Equatable {
  final String? id;
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final List<dynamic> imageUrls;
  final String ign;
  final String valTag;
  final String server;
  final String mainRole;
  final List<String>? swipedLeft;
  final List<String>? swipedRight;
  final List<Map<String, dynamic>>? matches;

  const LonerUser({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.imageUrls,
    required this.ign,
    required this.valTag,
    required this.server,
    required this.mainRole,
    this.swipedLeft,
    this.swipedRight,
    this.matches,
  });

  // bool isDataEmpty(){
  //   if(this.firstName == '' || this.lastName == '' || this.age == 0 || )
  // }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        age,
        gender,
        imageUrls,
        ign,
        valTag,
        server,
        mainRole,
        swipedLeft,
        swipedRight,
        matches,
      ];

  static LonerUser fromSnapshot(DocumentSnapshot snap) {
    LonerUser user = LonerUser(
      id: snap.id,
      firstName: snap['firstName'],
      lastName: snap['lastName'],
      age: snap['age'],
      gender: snap['gender'],
      imageUrls: snap['imageUrls'],
      ign: snap['ign'],
      valTag: snap['valTag'],
      server: snap['server'],
      mainRole: snap['mainRole'],
      swipedLeft: (snap['swipedLeft'] as List)
          .map((swipedLeft) => swipedLeft as String)
          .toList(),
      swipedRight: (snap['swipedRight'] as List)
          .map((swipedRight) => swipedRight as String)
          .toList(),
      matches: (snap['matches'] as List)
          .map((matches) => matches as Map<String, dynamic>)
          .toList(),
    );

    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'imageUrls': imageUrls,
      'ign': ign,
      'valTag': valTag,
      'server': server,
      'mainRole': mainRole,
      'swipedLeft': swipedLeft,
      'swipedRight': swipedRight,
      'matches': matches,
    };
  }

  LonerUser copyWith({
    String? id,
    String? firstName,
    String? lastName,
    int? age,
    String? gender,
    List<dynamic>? imageUrls,
    String? ign,
    String? valTag,
    String? server,
    String? mainRole,
    List<String>? swipedLeft,
    List<String>? swipedRight,
    List<Map<String, dynamic>>? matches,
  }) {
    return LonerUser(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      imageUrls: imageUrls ?? this.imageUrls,
      ign: ign ?? this.ign,
      valTag: valTag ?? this.valTag,
      server: server ?? this.server,
      mainRole: mainRole ?? this.mainRole,
      swipedLeft: swipedLeft ?? this.swipedLeft,
      swipedRight: swipedRight ?? this.swipedRight,
      matches: matches ?? this.matches,
    );
  }
}
