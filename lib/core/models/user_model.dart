
class UserModel {
  final String name;
  final String profilePic;
  final String banner;
  final String uid;
  final bool isAuthenticated;
  final int karma;
  final List<String> awards;

  UserModel({
    required this.name,
    required this.profilePic,
    required this.banner,
    required this.uid,
    required this.isAuthenticated,
    required this.karma,
    required this.awards,
  });

  UserModel copyWith({
    String? name,
    String? profilePic,
    String? banner,
    String? uid,
    bool? isAuthenticated,
    int? karma,
    List<String>? awards,
  }) =>
      UserModel(
        name: name ?? this.name,
        profilePic: profilePic ?? this.profilePic,
        banner: banner ?? this.banner,
        uid: uid ?? this.uid,
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        karma: karma ?? this.karma,
        awards: awards ?? this.awards,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    profilePic: json["profilePic"],
    banner: json["banner"],
    uid: json["uid"],
    isAuthenticated: json["isAuthenticated"],
    karma: json["karma"],
    awards: List<String>.from(json["awards"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "profilePic": profilePic,
    "banner": banner,
    "uid": uid,
    "isAuthenticated": isAuthenticated,
    "karma": karma,
    "awards": List<dynamic>.from(awards.map((x) => x)),
  };
}


