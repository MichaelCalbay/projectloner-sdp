class UserStats {
  int? status;
  Data? data;

class UserStats {
  final baseUrl = "https://api.henrikdev.xyz";

  UserStats.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currenttier;
  String? currenttierpatched;
  Images? images;
  int? rankingInTier;
  int? mmrChangeToLastGame;
  int? elo;
  String? name;
  String? tag;
  bool? old;

  Data(
      {this.currenttier,
      this.currenttierpatched,
      this.images,
      this.rankingInTier,
      this.mmrChangeToLastGame,
      this.elo,
      this.name,
      this.tag,
      this.old});

  Data.fromJson(Map<String, dynamic> json) {
    currenttier = json['currenttier'];
    currenttierpatched = json['currenttierpatched'];
    images =
        json['images'] != null ? new Images.fromJson(json['images']) : null;
    rankingInTier = json['ranking_in_tier'];
    mmrChangeToLastGame = json['mmr_change_to_last_game'];
    elo = json['elo'];
    name = json['name'];
    tag = json['tag'];
    old = json['old'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currenttier'] = this.currenttier;
    data['currenttierpatched'] = this.currenttierpatched;
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    data['ranking_in_tier'] = this.rankingInTier;
    data['mmr_change_to_last_game'] = this.mmrChangeToLastGame;
    data['elo'] = this.elo;
    data['name'] = this.name;
    data['tag'] = this.tag;
    data['old'] = this.old;
    return data;
  }
}

class Images {
  String? small;
  String? large;
  String? triangleDown;
  String? triangleUp;

  Images({this.small, this.large, this.triangleDown, this.triangleUp});

  Images.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    large = json['large'];
    triangleDown = json['triangle_down'];
    triangleUp = json['triangle_up'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['large'] = this.large;
    data['triangle_down'] = this.triangleDown;
    data['triangle_up'] = this.triangleUp;
    return data;
  }
}
