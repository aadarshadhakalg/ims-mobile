import 'dart:convert';

String jwtConvertString(String str){

  // string will be in this format
  // eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.
  // ec0MzIzLCJqdGkiOiJlMjhmMWVjNTY9.
  // s1SK74C7xpQLVk9UAbIfUoFNiIEkVi7l0NwT2G6ktZw
  // seperated by .
  // we only want middle part

  str = str.split('.')[1];
  var padding = '';

  if(str.length % 4 != 0){
    padding = str.length % 4 == 3 ? '=' : '==';
  }

  var base64Str = utf8.decode(base64.decode(str + padding));
  return base64Str.toString();

}

Map<String,dynamic> jwtToJSON(String jwtString){
  return jsonDecode(jwtString);
}

bool checkIfAccessTokenIsExpiredFromJSON(Map<String,dynamic> jwtJson){
 /*
 jwt will be in this form

 {"token_type":"access",
 "exp":1621075535,
 "jti":"5005d342db7f4cccab33ea7016675ec2","user_id":1}
 */
  return jwtJson['exp']*1000 < DateTime.now().millisecondsSinceEpoch;
}


