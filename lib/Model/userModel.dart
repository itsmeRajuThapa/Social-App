import 'dart:io';

class userModel {
  String? id;
  String? fullName;
  String? email;
  String? mobileNumber;
  String? gender;
  String? dob;
  String? password;
  String? maritialStatus;
  File? image;

  userModel({
    this.id,
    this.fullName,
    this.email,
    this.mobileNumber,
    this.gender,
    this.dob,
    this.password,
    this.maritialStatus,
    this.image,
  });

  factory userModel.fromJson(Map<String, dynamic> json) {
    File? image;
    if (json["image"] != "") {
      image = File(json["image"]);
    }
    return userModel(
      id: json["id"],
      fullName: json["fullName"],
      email: json["email"],
      mobileNumber: json["mobileNumber"],
      gender: json["gender"],
      dob: json["dob"],
      password: json["password"],
      maritialStatus: json["maritialStatus"],
      image: image!,
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
    };
  }
}

List<userModel> signupList = [];
