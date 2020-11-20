class DemoModel {
  final int userId;
  final int id;
  final String title;

  DemoModel({this.userId, this.id, this.title});

  factory DemoModel.fromJson(Map<String, dynamic> json) {
    return DemoModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class LoginResponse {
  int status;
  String message;
  User data;
  LoginResponse();
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    LoginResponse loginResponse = new LoginResponse();
    loginResponse.status = json['status'];
    loginResponse.message = json['message'];
    print(json['data']['user']);
    loginResponse.data = User.fromJson(json['data']['user']);

    return loginResponse;
  }
}

class User {
  String type;
  String id;
  String token_type;
  String expire_in;
  String access_token;
  String profile_image;
  String isset_profile_image;
  String is_superadmin_c;
  String marketing_user_c;
  String factor_auth;
  String UserType;
  String user_level_c;
  String status;
  String first_name;
  String last_name;
  String title;
  String email;
  String primary_address;
  String address_country;
  String address_state;
  String address_city;
  String refresh_token;
  User();
  factory User.fromJson(Map<String, dynamic> json) {
    User user = new User();
    user.type = json['type'];
    user.id = json['id'];
    user.access_token = json['access_token'];
    user.profile_image = json['profile_image'];
    user.factor_auth = json['factor_auth'];
    user.first_name = json['first_name'];
    user.last_name = json['last_name'];
    user.email = json['email'];
    return user;
  }
}

class OtpResponse {
  int status;
  String message;
  Data data;
  OtpResponse();
  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    OtpResponse otpResponse = new OtpResponse();
    otpResponse.status = json['status'];
    otpResponse.message = json['message'];
    print(json['data']);
    otpResponse.data = Data.fromJson(json['data']);

    return otpResponse;
  }
}

class Data {
  String type;
  String id;
  Data();
  factory Data.fromJson(Map<String, dynamic> json) {
    Data data = new Data();
    data.type = json['type'];
    data.id = json['id'];
    return data;
  }
}
