import 'package:ecommerce/constants.dart';
import 'package:ecommerce/layout/layout_cubit.dart';
import 'package:ecommerce/network/local_network.dart';
import 'package:ecommerce/screens/Home_screen.dart';
import 'package:ecommerce/screens/auth_screens/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/screens/auth_screens/login_screen.dart';
import 'package:ecommerce/screens/auth_screens/register_screen.dart';
import 'package:ecommerce/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

 await CacheNetwork.cacheinit();
 token = CacheNetwork.getCacheData(key: 'token');
 currentPassword = CacheNetwork.getCacheData(key: 'password');
  runApp(const  MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AuthCubit(),),
        BlocProvider(create: (context)=>LayoutCubit()..getCarts()..getFavorites()..getBannersData()..getCategoriesData()..getProducts(),),
      ],
       child:
      MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         
        primarySwatch: Colors.blue,
      ),
      home: token != null && token !='' ? HomeScreen() : LoginScreen() ,
    ),
      );
  }
}
 