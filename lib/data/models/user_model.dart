import '../../core/shared/env.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.username,
    required super.name,
    required super.avatar,
    required super.sessionId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String sessionId) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      avatar: AvatarModel.fromJson(json['avatar']),
      sessionId: sessionId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'avatar': AvatarModel(
        gravatar: avatar?.gravatar ?? '',
        tmdb: avatar?.tmdb ?? '',
      ).toJson(),
      'sessionId': sessionId,
    };
  }
}

class AvatarModel extends Avatar {
  AvatarModel({required super.gravatar, required super.tmdb});

  factory AvatarModel.fromJson(Map<String, dynamic> json) {
    return AvatarModel(
      gravatar: Environment.production.mediaUrl + json['gravatar']['hash'],
      tmdb: Environment.production.mediaUrl + json['tmdb']['avatar_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'gravatar': gravatar, 'tmdb': tmdb};
  }
}
