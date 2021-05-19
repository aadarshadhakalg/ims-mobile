import 'package:flutter/foundation.dart';

class JwtToken {
  final String access;
  final String refresh;


  JwtToken({@required this.access,@required this.refresh});
  
  factory JwtToken.fromJSON(Map<String,dynamic> json){
    return JwtToken(
      access: json['access'],
      refresh: json['refresh']
    );
    
  }
   Map<String,dynamic> toJson() {
      return {
        'access' : this.access, 
        'refresh' : this.refresh
      };
    }

}