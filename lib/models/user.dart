import 'package:pocketbase/pocketbase.dart';

class User {
  String name;
  String avatar;
  String id;
  String created;
  String updated;

  User({
    required this.name,
    this.avatar = '',
    this.id = '',
    this.created = '',
    this.updated = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'avatar': avatar,
    };
  }
}

User rmToUser(RecordModel rm) {
  return User(
    name: rm.getDataValue<String>('name', ''),
    avatar: rm.getDataValue<String>('avatar', ''),
    id: rm.id,
    created: rm.created,
    updated: rm.updated,
  );
}
