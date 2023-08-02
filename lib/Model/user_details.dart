import 'dart:convert';

UserDetails userDetailsFromJson(String str) =>
    UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  List<User>? users;

  UserDetails({
    this.users,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class User {
  int? id;
  BasicInfo? basicInfo;
  List<WorkExperience>? workExperience;
  List<Hobby>? skills;
  List<Hobby>? hobbies;
  List<Hobby>? languages;
  String? status;
  List<Education>? education;
  ContactInfo? contactInfo;
  List<SocialMedia>? socialMedia;

  User({
    this.id,
    this.basicInfo,
    this.workExperience,
    this.skills,
    this.hobbies,
    this.languages,
    this.status,
    this.education,
    this.contactInfo,
    this.socialMedia,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["Id"],
        basicInfo: json["BasicInfo"] == null
            ? null
            : BasicInfo.fromJson(json["BasicInfo"]),
        workExperience: json["WorkExperience"] == null
            ? []
            : List<WorkExperience>.from(
                json["WorkExperience"]!.map((x) => WorkExperience.fromJson(x))),
        skills: json["Skills"] == null
            ? []
            : List<Hobby>.from(json["Skills"]!.map((x) => Hobby.fromJson(x))),
        hobbies: json["Hobbies"] == null
            ? []
            : List<Hobby>.from(json["Hobbies"]!.map((x) => Hobby.fromJson(x))),
        languages: json["Languages"] == null
            ? []
            : List<Hobby>.from(
                json["Languages"]!.map((x) => Hobby.fromJson(x))),
        status: json["Status"],
        education: json["Education"] == null
            ? []
            : List<Education>.from(
                json["Education"]!.map((x) => Education.fromJson(x))),
        contactInfo: json["ContactInfo"] == null
            ? null
            : ContactInfo.fromJson(json["ContactInfo"]),
        socialMedia: json["SocialMedia"] == null
            ? []
            : List<SocialMedia>.from(
                json["SocialMedia"]!.map((x) => SocialMedia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "BasicInfo": basicInfo?.toJson(),
        "WorkExperience": workExperience == null
            ? []
            : List<dynamic>.from(workExperience!.map((x) => x.toJson())),
        "Skills": skills == null
            ? []
            : List<dynamic>.from(skills!.map((x) => x.toJson())),
        "Hobbies": hobbies == null
            ? []
            : List<dynamic>.from(hobbies!.map((x) => x.toJson())),
        "Languages": languages == null
            ? []
            : List<dynamic>.from(languages!.map((x) => x.toJson())),
        "Status": status,
        "Education": education == null
            ? []
            : List<dynamic>.from(education!.map((x) => x.toJson())),
        "ContactInfo": contactInfo?.toJson(),
        "SocialMedia": socialMedia == null
            ? []
            : List<dynamic>.from(socialMedia!.map((x) => x.toJson())),
      };
}

class BasicInfo {
  CoverImage? imageModel;
  CoverImage? coverImage;
  String? summary;
  String? gender;
  String? dob;
  String? maritalStatus;

  BasicInfo({
    this.imageModel,
    this.coverImage,
    this.summary,
    this.gender,
    this.dob,
    this.maritalStatus,
  });

  factory BasicInfo.fromJson(Map<String, dynamic> json) => BasicInfo(
        imageModel: json["ImageModel"] == null
            ? null
            : CoverImage.fromJson(json["ImageModel"]),
        coverImage: json["CoverImage"] == null
            ? null
            : CoverImage.fromJson(json["CoverImage"]),
        summary: json["Summary"],
        gender: json["Gender"],
        dob: json["Dob"],
        maritalStatus: json["MaritalStatus"],
      );

  Map<String, dynamic> toJson() => {
        "ImageModel": imageModel?.toJson(),
        "CoverImage": coverImage?.toJson(),
        "Summary": summary,
        "Gender": gender,
        "Dob": dob,
        "MaritalStatus": maritalStatus,
      };
}

class CoverImage {
  bool? isNetworkUrl;
  String? imagePath;

  CoverImage({
    this.isNetworkUrl,
    this.imagePath,
  });

  factory CoverImage.fromJson(Map<String, dynamic> json) => CoverImage(
        isNetworkUrl: json["Is_network_url"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "Is_network_url": isNetworkUrl,
        "image_path": imagePath,
      };
}

class ContactInfo {
  String? mobileNo;

  ContactInfo({
    this.mobileNo,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) => ContactInfo(
        mobileNo: json["MobileNo"],
      );

  Map<String, dynamic> toJson() => {
        "MobileNo": mobileNo,
      };
}

class Education {
  int? id;
  String? level;
  String? summary;
  String? organizationName;
  String? startDate;
  String? endDate;
  List<Accomplishment>? accomplishments;

  Education({
    this.id,
    this.level,
    this.summary,
    this.organizationName,
    this.startDate,
    this.endDate,
    this.accomplishments,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        id: json["Id"],
        level: json["Level"],
        summary: json["Summary"],
        organizationName: json["OrganizationName"],
        startDate: json["StartDate"],
        endDate: json["EndDate"],
        accomplishments: json["Accomplishments"] == null
            ? []
            : List<Accomplishment>.from(json["Accomplishments"]!
                .map((x) => Accomplishment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Level": level,
        "Summary": summary,
        "OrganizationName": organizationName,
        "StartDate": startDate,
        "EndDate": endDate,
        "Accomplishments": accomplishments == null
            ? []
            : List<dynamic>.from(accomplishments!.map((x) => x.toJson())),
      };
}

class Accomplishment {
  int? id;
  String? title;
  String? description;
  String? date;

  Accomplishment({
    this.id,
    this.title,
    this.description,
    this.date,
  });

  factory Accomplishment.fromJson(Map<String, dynamic> json) => Accomplishment(
        id: json["Id"],
        title: json["Title"],
        description: json["Description"],
        date: json["Date"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "Description": description,
        "Date": date,
      };
}

class Hobby {
  int? id;
  String? title;

  Hobby({
    this.id,
    this.title,
  });

  factory Hobby.fromJson(Map<String, dynamic> json) => Hobby(
        id: json["Id"],
        title: json["Title"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
      };
}

class SocialMedia {
  int? id;
  String? title;
  String? url;
  String? type;

  SocialMedia({
    this.id,
    this.title,
    this.url,
    this.type,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
        id: json["Id"],
        title: json["Title"],
        url: json["Url"],
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "Url": url,
        "Type": type,
      };
}

class WorkExperience {
  int? id;
  String? jobTitle;
  String? summary;
  String? organizationName;
  String? startDate;
  String? endDate;

  WorkExperience({
    this.id,
    this.jobTitle,
    this.summary,
    this.organizationName,
    this.startDate,
    this.endDate,
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json) => WorkExperience(
        id: json["Id"],
        jobTitle: json["Job_title"],
        summary: json["Summary"],
        organizationName: json["OrganizationName"],
        startDate: json["StartDate"],
        endDate: json["EndDate"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Job_title": jobTitle,
        "Summary": summary,
        "OrganizationName": organizationName,
        "StartDate": startDate,
        "EndDate": endDate,
      };
}
