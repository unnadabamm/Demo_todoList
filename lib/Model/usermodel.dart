class UserModel {
  String id;
  String username;
  String password;
  String name;
  String sexs;
  String bOD;
  String phone;
  String email;
  String createDate;
  String updateDate;
  String userState;
  String avatar;
  String age;

  UserModel(
      {this.id,
      this.username,
      this.password,
      this.name,
      this.sexs,
      this.bOD,
      this.phone,
      this.email,
      this.createDate,
      this.updateDate,
      this.userState,
      this.avatar,
      this.age});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    name = json['name'];
    sexs = json['sexs'];
    bOD = json['BOD'];
    phone = json['phone'];
    email = json['email'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    userState = json['userState'];
    avatar = json['avatar'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['name'] = this.name;
    data['sexs'] = this.sexs;
    data['BOD'] = this.bOD;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    data['userState'] = this.userState;
    data['avatar'] = this.avatar;
    data['age'] = this.age;
    return data;
  }
}
