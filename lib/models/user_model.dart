class User {
  final int id;
  final String username;
  final String name;
  final Avatar avatar;
  final String sessionId;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.avatar,
    required this.sessionId,
  });

  factory User.fromJson(Map<String, dynamic> json, String sessionId) {
    return User(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      avatar: Avatar.fromJson(json['avatar']),
      sessionId: sessionId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'avatar': avatar.toJson(),
      'sessionId': sessionId,
    };
  }
}

class Avatar {
  final Gravatar gravatar;
  final Tmdb tmdb;

  Avatar({required this.gravatar, required this.tmdb});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      gravatar: Gravatar.fromJson(json['gravatar']),
      tmdb: Tmdb.fromJson(json['tmdb']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'gravatar': gravatar.toJson(), 'tmdb': tmdb.toJson()};
  }
}

class Gravatar {
  final String? hash;

  Gravatar({this.hash});

  factory Gravatar.fromJson(Map<String, dynamic> json) {
    return Gravatar(hash: json['hash']);
  }

  Map<String, dynamic> toJson() {
    return {'hash': hash};
  }
}

class Tmdb {
  final String? avatarPath;

  Tmdb({this.avatarPath});

  factory Tmdb.fromJson(Map<String, dynamic> json) {
    return Tmdb(avatarPath: json['avatar_path']);
  }

  Map<String, dynamic> toJson() {
    return {'avatar_path': avatarPath};
  }
}
