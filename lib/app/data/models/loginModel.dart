class LoginModel{
  LoginModel({this.username, this.password});
  final String username;
  final String password;

  Map<String,dynamic> toJSON(){
    return {
      'username': username,
      'password': password,
    };
  }

}