import 'package:ecommerce/screens/Home_screen.dart';
import 'package:ecommerce/screens/auth_screens/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/screens/auth_screens/auth_cubit/auth_states.dart';
import 'package:ecommerce/screens/auth_screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
    LoginScreen({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        height: double.infinity,
        decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage('images/b.webp'),fit: BoxFit.fill),
      
      
      
        ),
      child: Form(
        key: formKey, 
        child: BlocConsumer<AuthCubit,AuthStates>(
           listener: (context, state) {
             if (state is LoginSuccssState) {
              Navigator.pop(context); // alertdialog عشان يخرج من 
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen(), ),);
             }
             if (state is LoginErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(
                alignment: Alignment.center,
                height: 50,
               child: Text(state.message),
              )));
                
             }
           },
           builder: (context, state) {
             return Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: 50) ,
                  child: Text('Login to continue proccess',style: TextStyle(color: Colors.amber ,fontWeight: FontWeight.bold,fontSize: 20 ),),
                )
              
              ),
              
              Expanded(
                flex: 2,
                child: 
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: Container(
                width: double.infinity,
                padding:EdgeInsets.symmetric(horizontal: 35, ) ,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                 Text('Login',style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.bold, ), ),
                 SizedBox(height: 10,),
                 textFieldItem(Controller:emailController , hintText: 'Email'),
                 SizedBox(height: 10, ),
                 textFieldItem(Controller:passwordController , hintText: 'password',isSecure: true,),
                 SizedBox(height: 10, ),
                 MaterialButton(
                  onPressed:(){
                        if (formKey.currentState!.validate() == true) {
                          BlocProvider.of<AuthCubit>(context).
                          login(email: emailController.text, password: passwordController.text);
                        }  
                 },
                 minWidth: double.infinity,
                 color: Colors.red ,
                 textColor: Colors.white,
                 
                 child: Text(state is LoginLoadingState ? 'loading' : 'Login'),
                 ),
                   SizedBox(height: 15,),
                   RichText(text: 
                    TextSpan(
                      children: [
                               
                               TextSpan(text: 'forgot your password?',style: TextStyle(color:Colors.white,), ),
                               
                               TextSpan(text:' Click here',style: TextStyle(color:Colors.yellow,) ),
                      ],
                    ),
                    ),
                  ]
                ),
               ),
             ),
              ),
            ],
          );
           },
        ),
      ) ,
      ) ,
    );
  }
}