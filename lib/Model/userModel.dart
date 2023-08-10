import 'package:project/const/import.dart';

class UserModel {
  String id;
  String? fullName;
  String? email;
  String? mobileNumber;
  String? gender;
  String? dob;
  String? password;
  String? maritialStatus;
  File? image;
  String? imageUrl;

  UserModel(
      {required this.id,
      this.fullName,
      this.email,
      this.mobileNumber,
      this.gender,
      this.dob,
      this.password,
      this.maritialStatus,
      this.image,
      this.imageUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    String imagePath = json["image"] ?? "";
    return UserModel(
      id: json["id"],
      fullName: json["fullName"],
      email: json["email"],
      mobileNumber: json["mobileNumber"],
      gender: json["gender"],
      dob: json["dob"],
      password: json["password"],
      maritialStatus: json["maritialStatus"],
      image: File(imagePath),
      imageUrl: json["imageUrl"],
    );
  }
  Map<String, dynamic> toJson() {
    String imagePath = image != null ? image!.path : "";
    return {
      "id": id,
      "fullName": fullName,
      "email": email,
      "mobileNumber": mobileNumber,
      "gender": gender,
      "dob": dob,
      "password": password,
      "maritialStatus": maritialStatus,
      "image": imagePath,
      "imageUrl": imageUrl
    };
  }

  toLowerCase() {}
}

List<UserModel> signupList = [];
