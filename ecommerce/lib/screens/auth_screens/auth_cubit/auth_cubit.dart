import 'dart:convert';

import 'package:ecommerce/constants.dart';
import 'package:ecommerce/network/local_network.dart';
import 'package:ecommerce/screens/auth_screens/auth_cubit/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
import 'package:http/http.dart'as http;
import 'package:http/http.dart';

class AuthCubit extends Cubit<AuthStates>{

  AuthCubit() : super(AuthInitialStates());
  
  // Register http | 


  void register({
    required String name, required String email, required String phone, required String password, 
  })
  
  async
  {

 emit(RegisterLoadingState());

   Response response = await http.post(
      Uri.parse('https://student.valuxapps.com/api/register'),
      body: 
      {
          'name' : name,
          'email' : email,
          'phone' : phone,
          'password' : password,
        

      }
    );

    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true ) {
      
      emit(RegisterLoadingState());
    } else {
      emit(RegisterErrorState(message: responseBody['message'] ));
    }
    
  }



  // Login
  void login({
    required String email,
    required String password,
  })async {

    

 try {
   Response response= await   http.post(
      Uri.parse('https://student.valuxapps.com/api/login'),
      body: {
        'email' : email,
        'password' : password,
      }
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) ;
      if (data['status'] == true) {

      await  CacheNetwork.insertToCache(key: 'token',value: data['data']['token']);
      await  CacheNetwork.insertToCache(key: 'password',value: password);
      token = CacheNetwork.getCacheData(key: 'token');
      currentPassword = CacheNetwork.getCacheData(key: 'password');
        emit(LoginSuccssState());
      } else {
        print('errrrrrrror because $data["message"]');
        emit(LoginErrorState(message: data['message'] ));
      }
    } 
 emit(LoginSuccssState());
 } catch (e) {
      
      emit(LoginErrorState(message:e.toString()));
 }


  }
}