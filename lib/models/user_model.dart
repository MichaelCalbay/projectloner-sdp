import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String firstName;
  final String lastName;
  final int age;
  // final List<String> imageUrls;
  final String? server;
  final String? role;

  const UserData({
    required this.firstName,
    required this.lastName,
    required this.age,
    // required this.imageUrls,
    required this.server,
    required this.role,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        age,
        // imageUrls,
        server,
        role,
      ];

  static List<UserData> Users = [
    const UserData(
      firstName: 'Albedo',
      lastName: 'Chan',
      age: 26,
      // imageUrls: [
      //   'https://ae01.alicdn.com/kf/Hae0d895688ae42cdb30faae0338e43621/Sexy-Albedo-Evil-Demon-Girl-Canvas-Painting-Custom-Print-Anime-Video-Game-Comics-Art-Poster-Wall.jpg',
      //   'https://ae01.alicdn.com/kf/He60794cb310e44eea50d2c978b7567afJ/Print-Canvas-Video-Games-Tsunade-Overlord-Albedo-Sexy-Girl-Art-Poster-40x60-50x70-60x90-Custom-Living.jpg_Q90.jpg_.webp',
      //   'https://i.pinimg.com/736x/8b/43/e6/8b43e6f2d04267e220cc0f848b137631.jpg',
      //   'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/80523949-0a8c-4eb6-9c68-3fcee69d2c3b/dee4g3d-5d976c42-1b82-469f-a187-69d68c1c8f4b.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzgwNTIzOTQ5LTBhOGMtNGViNi05YzY4LTNmY2VlNjlkMmMzYlwvZGVlNGczZC01ZDk3NmM0Mi0xYjgyLTQ2OWYtYTE4Ny02OWQ2OGMxYzhmNGIuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.3C2VbtRLtrEBoO9sweC9PRQ3eufpJIgUmkKtfVu5T_g',
      // ],
      server: 'APAC',
      role: 'Duelist',
    ),
    const UserData(
      firstName: 'Yor',
      lastName: 'Sugoi',
      age: 21,
      // imageUrls: [
      //   'https://cdn.oneesports.gg/cdn-data/2022/04/SpyxFamily_YorForgerCosplayKitaroCosCloseUp-1024x576.webp',
      //   'https://aphrodite.gmanetwork.com/entertainment/articles/900_675_New_MainImage_2021_-20220509111041.jpg',
      //   'https://i0.wp.com/noticias.animeonegai.com/wp-content/uploads/2022/06/SPYxFAMILY_NICKY2-1200x1500-1.jpg?resize=819%2C1024&ssl=1',
      //   'https://pbs.twimg.com/media/FTdXcSAXEAA36TA.jpg:large',
      // ],
      server: 'APAC',
      role: 'Controller',
    )
  ];
}
