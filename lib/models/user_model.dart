import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:projectloner/blocs/swipe/swipe_bloc.dart';

class LonerUser extends Equatable {
  final String? id;
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final List<dynamic> imageUrls;
  final List<dynamic>? interests;
  final String? server;
  final String mainRole;
  final List<String>? swipedLeft;
  final List<String>? swipedRight;
  final List<String>? matches;

  const LonerUser({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.imageUrls,
    this.interests,
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
        interests,
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
      interests: snap['interests'],
      server: snap['server'],
      mainRole: snap['mainRole'],
      swipedLeft: (snap['swipedLeft'] as List)
          .map((swipedLeft) => swipedLeft as String)
          .toList(),
      swipedRight: (snap['swipedRight'] as List)
          .map((swipedRight) => swipedRight as String)
          .toList(),
      matches: (snap['matches'] as List)
          .map((matches) => matches as String)
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
      'interests': interests,
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
    List<dynamic>? interests,
    String? server,
    String? mainRole,
    List<String>? swipedLeft,
    List<String>? swipedRight,
    List<String>? matches,
  }) {
    return LonerUser(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      imageUrls: imageUrls ?? this.imageUrls,
      interests: interests ?? this.interests,
      server: server ?? this.server,
      mainRole: mainRole ?? this.mainRole,
      swipedLeft: swipedLeft ?? this.swipedLeft,
      swipedRight: swipedRight ?? this.swipedRight,
      matches: matches ?? this.matches,
    );
  }

  //SAMPLE DATA FOR TESTING.
  static List<LonerUser> users = [
    const LonerUser(
      id: '1',
      firstName: 'Robin',
      lastName: 'Nico',
      age: 23,
      gender: 'Female',
      imageUrls: [
        'https://www.gamelivestory.com/images/article/one-piece-10-hilarious-nico-robin-memes-main.webp',
        'https://cdna.artstation.com/p/assets/images/images/039/297/588/large/awn-arts-1625496152134.jpg?1625509976',
        'https://wallpaper.dog/large/20519916.jpg',
        'https://cdna.artstation.com/p/assets/images/images/003/099/812/medium/andrea-villa-sanchez-nico-robin-one-piece-by-andreakiissu-d9aa53m.jpg?1469661018',
      ],
      interests: [
        'MUSIC',
        'BOOKS',
        'SPORTS',
        'MOVIES',
        'FLAMINGOS',
        'COFFEE',
        'FOOD',
        'ANIME',
      ],
      server: 'APAC',
      mainRole: 'Controller',
    ),
    const LonerUser(
      id: '2',
      firstName: 'Boa',
      lastName: 'Hancock',
      age: 22,
      gender: 'Female',
      imageUrls: [
        'https://i.etsystatic.com/20629493/r/il/8bc8b3/1946959776/il_570xN.1946959776_p9mr.jpg',
        'https://images2.alphacoders.com/106/1067611.jpg',
        'https://i.ytimg.com/vi/gLTdzz8gv0Q/maxresdefault.jpg',
        'https://media.comicbook.com/2021/03/one-piece-boa-hancock-1260067.jpeg?auto=webp',
      ],
      interests: ['MUSIC', 'BOOKS', 'Luffy', 'Pirates'],
      server: 'APAC',
      mainRole: 'Controller',
    ),
    const LonerUser(
      id: '3',
      firstName: 'Yor',
      lastName: 'Forger',
      age: 21,
      gender: 'Female',
      imageUrls: [
        'https://en.datosjam.net.pe/wp-content/uploads/2022/05/SPY-x-FAMILY-Yor-Forger-already-qualifies-among-the-most.jpg',
        'https://64.media.tumblr.com/d56dad0f24945a70606128e5b39aa8ed/933880750ec69599-b5/s1280x1920/4616cced58a0e5af0525d08613526d460eb08317.png',
        'https://staticg.sportskeeda.com/editor/2022/06/09d7b-16563276089977-1920.jpg',
        'https://fictionhorizon.com/wp-content/uploads/2022/05/maxresdefault-2-2-1024x576.jpg',
      ],
      interests: [
        'MUSIC',
        'BOOKS',
        'SPORTS',
        'KNIVES',
      ],
      server: 'APAC',
      mainRole: 'Controller',
    ),
    const LonerUser(
      id: '4',
      firstName: 'Lin Lin',
      lastName: 'Charlotte',
      age: 62,
      imageUrls: [
        'https://cdn.worldcosplay.net/146450/nfutledcmvzfuvusednbkongkoxilnzjgdtrwevw-740.jpg',
        'https://pm1.narvii.com/6456/6a3d42231eaa868021336ede1ff87551cc87eef9_hq.jpg',
        'https://preview.redd.it/7bivfmtyeaa21.jpg?auto=webp&s=d4cc4a57ab415b1ac12f890c766ef38decbd9659',
        'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/21e32f5c-5edb-4656-946b-1c0936ff4284/dbvbj6q-63cd15c5-54b3-4d88-9537-aa800fbe174f.jpg/v1/fill/w_1024,h_683,q_75,strp/big_mom_and_her_little_friends_by_loveless_thing_dbvbj6q-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NjgzIiwicGF0aCI6IlwvZlwvMjFlMzJmNWMtNWVkYi00NjU2LTk0NmItMWMwOTM2ZmY0Mjg0XC9kYnZiajZxLTYzY2QxNWM1LTU0YjMtNGQ4OC05NTM3LWFhODAwZmJlMTc0Zi5qcGciLCJ3aWR0aCI6Ijw9MTAyNCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.L0Rl5WvghYvZ8nrFXOGh-97Um1D42zNuDVE8l5xhCB0',
      ],
      gender: 'Female',
      interests: [
        'FOOD',
        'FAMILY',
        'CAKES',
        'ICE CREAM',
        'CHOCOLATES',
      ],
      server: 'APAC',
      mainRole: 'Sentinel',
    ),
  ];
}
