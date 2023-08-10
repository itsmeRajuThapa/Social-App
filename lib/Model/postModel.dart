import 'package:project/const/import.dart';

class PostModel {
  String postId;
  String userId;
  String createdAt;
  String description;
  File? image;
  List<String> postLikedBy;

  PostModel({
    required this.postId,
    required this.userId,
    required this.createdAt,
    required this.description,
    required this.image,
    required this.postLikedBy,
  });

  // Factory method to create a PostModel from a JSON Map
  factory PostModel.fromJson(Map<String, dynamic> json) {
    String imagePath = json["image"] ?? "";
    return PostModel(
      postId: json['postId'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      description: json['description'],
      image: File(imagePath),
      postLikedBy: List<String>.from(json['postLikedBy']),
    );
  }

  // Method to convert PostModel to a JSON Map
  Map<String, dynamic> toJson() {
    String imagePath = image != null ? image!.path : "";
    return {
      'postId': postId,
      'userId': userId,
      'createdAt': createdAt,
      'description': description,
      'image': imagePath,
      'postLikedBy': postLikedBy
    };
  }
}

List<PostModel> postList = [];
