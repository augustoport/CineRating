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
}

class Avatar {
  final Gravatar gravatar;
  final Tmdb tmdb;

  Avatar({
    required this.gravatar,
    required this.tmdb,
  });
}

class Gravatar {
  final String? hash;

  Gravatar({this.hash});
}

class Tmdb {
  final String? avatarPath;

  Tmdb({this.avatarPath});
}
