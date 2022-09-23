import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

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
  });

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
    );

    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'imageUrls': imageUrls,
      'interests': interests,
      'server': server,
      'mainRole': mainRole,
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
    );
  }

  //SAMPLE DATA FOR TESTING.
  static List<LonerUser> users = [
    const LonerUser(
      id: '1',
      firstName: 'Robin',
      lastName: 'Chwuan',
      age: 23,
      gender: 'Female',
      imageUrls: [
        'https://preview.redd.it/du7sbn27xs491.jpg?auto=webp&s=decc60fec16eb5ade184ac10c70520b64a7482e5',
        'https://cdn.worldcosplay.net/760194/rhwvvffvohquiewsbgrjaeeigkasdcvzfuwwadyd-740.jpg',
        'https://img-9gag-fun.9cache.com/photo/a2ZmVQZ_460s.jpg',
        'https://pbs.twimg.com/media/DeetJ5VXUAA5-5V.jpg',
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
  ];
  //   const LonerUser(
  //     id: 2,
  //     firstName: 'Albedo',
  //     lastName: 'Chan',
  //     age: 26,
  //     //     imageUrls: [
  //     //       'https://ae01.alicdn.com/kf/Hae0d895688ae42cdb30faae0338e43621/Sexy-Albedo-Evil-Demon-Girl-Canvas-Painting-Custom-Print-Anime-Video-Game-Comics-Art-Poster-Wall.jpg',
  //     //       'https://ae01.alicdn.com/kf/He60794cb310e44eea50d2c978b7567afJ/Print-Canvas-Video-Games-Tsunade-Overlord-Albedo-Sexy-Girl-Art-Poster-40x60-50x70-60x90-Custom-Living.jpg_Q90.jpg_.webp',
  //     //       'https://i.pinimg.com/736x/8b/43/e6/8b43e6f2d04267e220cc0f848b137631.jpg',
  //     //       'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/80523949-0a8c-4eb6-9c68-3fcee69d2c3b/dee4g3d-5d976c42-1b82-469f-a187-69d68c1c8f4b.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzgwNTIzOTQ5LTBhOGMtNGViNi05YzY4LTNmY2VlNjlkMmMzYlwvZGVlNGczZC01ZDk3NmM0Mi0xYjgyLTQ2OWYtYTE4Ny02OWQ2OGMxYzhmNGIuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.3C2VbtRLtrEBoO9sweC9PRQ3eufpJIgUmkKtfVu5T_g',
  //     //     ],
  //     //     // interests: [
  //     //     //   'AINS',
  //     //     //   'SKELETONS',
  //     //     //   'SORCERER KING',
  //     //     //   'WORLD DOMINATION',
  //     //     //   'CLOTHES',
  //     //     //   'DESSERT',
  //     //     // ],
  //     server: 'APAC',
  //     role: 'Initiator',
  //   ),
  //   const LonerUser(
  //     id: 3,
  //     firstName: 'Yor',
  //     lastName: 'Sugoi',
  //     age: 21,
  //     imageUrls: [
  //       'https://cdn.oneesports.gg/cdn-data/2022/04/SpyxFamily_YorForgerCosplayKitaroCosCloseUp-1024x576.webp',
  //       'https://aphrodite.gmanetwork.com/entertainment/articles/900_675_New_MainImage_2021_-20220509111041.jpg',
  //       'https://i0.wp.com/noticias.animeonegai.com/wp-content/uploads/2022/06/SPYxFAMILY_NICKY2-1200x1500-1.jpg?resize=819%2C1024&ssl=1',
  //       'https://pbs.twimg.com/media/FTdXcSAXEAA36TA.jpg:large',
  //     ],
  //     //     // interests: [
  //     //     //   'CHILDREN',
  //     //     //   'SWORDS',
  //     //     //   'KNIVES',
  //     //     //   'TORTURE',
  //     //     //   'ASSASSINATION',
  //     //     //   'MOVIES',
  //     //     //   'SPORTS',
  //     //     // ],
  //     server: 'APAC',
  //     role: 'Duelist',
  //   ),
  //   const LonerUser(
  //     id: 4,
  //     firstName: 'Lin Lin',
  //     lastName: 'Charlotte',
  //     age: 62,
  //     //     imageUrls: [
  //     //       'https://cdn.worldcosplay.net/146450/nfutledcmvzfuvusednbkongkoxilnzjgdtrwevw-740.jpg',
  //     //       'https://pm1.narvii.com/6456/6a3d42231eaa868021336ede1ff87551cc87eef9_hq.jpg',
  //     //       'https://preview.redd.it/7bivfmtyeaa21.jpg?auto=webp&s=d4cc4a57ab415b1ac12f890c766ef38decbd9659',
  //     //       'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/21e32f5c-5edb-4656-946b-1c0936ff4284/dbvbj6q-63cd15c5-54b3-4d88-9537-aa800fbe174f.jpg/v1/fill/w_1024,h_683,q_75,strp/big_mom_and_her_little_friends_by_loveless_thing_dbvbj6q-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NjgzIiwicGF0aCI6IlwvZlwvMjFlMzJmNWMtNWVkYi00NjU2LTk0NmItMWMwOTM2ZmY0Mjg0XC9kYnZiajZxLTYzY2QxNWM1LTU0YjMtNGQ4OC05NTM3LWFhODAwZmJlMTc0Zi5qcGciLCJ3aWR0aCI6Ijw9MTAyNCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.L0Rl5WvghYvZ8nrFXOGh-97Um1D42zNuDVE8l5xhCB0',
  //     //     ],
  //     //     // interests: [
  //     //     //   'FOOD',
  //     //     //   'FAMILY',
  //     //     //   'CAKES',
  //     //     //   'ICE CREAM',
  //     //     //   'CHOCOLATES',
  //     //     // ],
  //     server: 'APAC',
  //     role: 'Sentinel',
  //   ),
  //   const LonerUser(
  //     id: 5,
  //     firstName: 'Sporky',
  //     lastName: 'Taba',
  //     age: 26,
  //     //     imageUrls: [
  //     //       'https://scontent.fhlz2-1.fna.fbcdn.net/v/t1.15752-9/306609660_1275399656567492_3540750187771009109_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=7b7923&_nc_ohc=2R6fV1HBwu8AX85U2K0&_nc_ht=scontent.fhlz2-1.fna&oh=03_AVLB2A9y1c-5XJPWrvu4Bs-MfoTvdFm9fnlOREIEvAf8IQ&oe=634D5273',
  //     //       'https://scontent.fakl5-1.fna.fbcdn.net/v/t31.18172-8/823349_565351646816630_660560163_o.jpg?_nc_cat=106&ccb=1-7&_nc_sid=de6eea&_nc_ohc=PAxP614bZt4AX9ZbZVt&_nc_ht=scontent.fakl5-1.fna&oh=00_AT8D7BYmyBzrzFeXrFFhXSQM8MKO5qUZ3GPzrfuOpQ7YVQ&oe=634A2807',
  //     //       'https://scontent.fakl5-1.fna.fbcdn.net/v/t1.18169-9/162911_173053356046463_3240373_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=de6eea&_nc_ohc=pEubHctSOrcAX_OGYxb&_nc_ht=scontent.fakl5-1.fna&oh=00_AT-yxc2Z_At8SP_gaTsG5y-8xa4Z10-mauXhdmDUrKzqMQ&oe=6348F08C',
  //     //       'https://scontent.fakl5-1.fna.fbcdn.net/v/t31.18172-8/887107_726116480734754_61911895_o.jpg?_nc_cat=107&ccb=1-7&_nc_sid=cdbe9c&_nc_ohc=qSlM9wBcGQEAX_onh8C&_nc_ht=scontent.fakl5-1.fna&oh=00_AT9l-7cnElNwOY9cRBS6_ZXE-soQFQFXbKWqPiRoMdujQg&oe=634A94FA',
  //     //     ],
  //     //     // interests: [
  //     //     //   'HOT BOYS',
  //     //     //   'MUSCLES',
  //     //     //   'GUYS',
  //     //     //   'HANDSOME GUYS',
  //     //     //   'ARAB ROYAL BLOODS',
  //     //     // ],
  //     server: 'APAC',
  //     role: 'Controller',
  //   ),
  //   const LonerUser(
  //     id: 6,
  //     firstName: 'Nami',
  //     lastName: 'Swan',
  //     age: 22,
  //     imageUrls: [
  //       'https://images.squarespace-cdn.com/content/v1/58918d6cb3db2b849f86ab84/1567654030046-X6VH0LH8E9WDTDBIJRH1/Nami+15.jpg?format=1000w',
  //       'https://preview.redd.it/t8wutrjazzh71.jpg?auto=webp&s=3f019d1b425cf5645f0fcfbc9cfb23f970b2d71c',
  //       'https://preview.redd.it/5f3paz3za2l61.jpg?auto=webp&s=ec1e5d591e5923b70c511200ec9bbcea7e416c76',
  //       'https://gamek.mediacdn.vn/133514250583805952/2020/4/6/photo-1-15861640354561403539112.jpg',
  //     ],
  //     //     // interests: [
  //     //     //   'MUSIC',
  //     //     //   'GAMES',
  //     //     //   'SPORTS',
  //     //     //   'MOVIES',
  //     //     // ],
  //     server: 'APAC',
  //     role: 'Sentinel',
  //   ),
  // ];
}
