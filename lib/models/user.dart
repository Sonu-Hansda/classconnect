class UserModel {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? registrationNumber;
  String? branch;
  int? batch;
  bool? isCR;
  String? profileImage;

  UserModel(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.registrationNumber,
      this.batch,
      this.branch,
      this.isCR,
      this.profileImage});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'registrationNumber': registrationNumber,
      'branch': branch,
      'batch': batch,
      'isCR': isCR,
      'profileImage': profileImage
    };
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    registrationNumber = json['registrationNumber'];
    branch = json['branch'];
    batch = json['batch'];
    isCR = json['isCR'];
    profileImage = json['profileImage'];
  }
}
