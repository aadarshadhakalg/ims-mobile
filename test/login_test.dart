import 'package:inventory_management_system/core/values/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';


void main() async{

Dio dio = Dio();
dio.options.baseUrl = ApiConstants.SERVER_URL;

//first try to login with these credetials.

 var data = {
      'username': 'voidummy',
      'password': 'codingjokers'
    };
    
   var response;
  try{
     response = await dio.post(ApiConstants.LOGIN ,data: FormData.fromMap(data));

  }catch(err){
    if(err.response?.statusCode == 401){
        print('credentials not defined. Now defining them');
        var d = await  createUserAccount(data);
        print(d);
      test('coudn\'t create account', () {
           expect(d,true);
      });
      //try loggin in again
      try{
        response = await dio.post(ApiConstants.LOGIN ,data: FormData.fromMap(data));
      }catch(err){
        test('cannot login', (){
          expect(false,true);
        });
      }
    }
  }

  var accessToken = response.data['access'];
  dio.options.headers['Authorization'] = 'Bearer ' + accessToken;
  print(dio.options.headers);

try{
  await dio.get(ApiConstants.TEST);
}catch(err){
        test('cannot access /test/ endpoint. Problem with bearer token', (){
          expect(false,true);
        });
}

    test('All test passed', (){
          expect(true,true);
    });
}

Future<bool> createUserAccount(Map<String, String> d) async{
  print('get inside');
  Dio dio = Dio();
  dio.options.baseUrl = ApiConstants.SERVER_URL;
  var data  = 
{
    "username": d['username'],
    "password": d['password'],
    "password2": d['password'],
    "email": "dummycc@gmail.com",
    "name": "Ashish Thapa",
    "Landline_number": "014333204",
    "mobile_number": "9841939234",
    "address": "Kirtipur",
    "user_type": "AD"
};

 try{
    await dio.post('/register/',data: FormData.fromMap(data));
    return true;
  }catch(err){
    return false;
  }
}