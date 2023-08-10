import 'package:project/const/import.dart';

UsersList usersListFromJson(String str) => UsersList.fromJson(json.decode(str));

String usersListToJson(UsersList data) => json.encode(data.toJson());

class UsersList {
  int? id;
  String? name;
  String? email;
  String? password;

  UsersList({
    this.id,
    this.name,
    this.email,
    this.password,
  });

  factory UsersList.fromJson(Map<String, dynamic> json) => UsersList(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
      };
}
