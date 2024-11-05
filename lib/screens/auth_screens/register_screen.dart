import 'package:ecommerce/screens/Home_screen.dart';
import 'package:ecommerce/screens/auth_screens/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/screens/auth_screens/auth_cubit/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is RegisterSuccssState) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return HomeScreen();
            }));
          } else if(state is RegisterErrorState ) {
            showDialog(context: context, builder: (context){
              return AlertDialog(
                content: Text(state.message),
                backgroundColor: Colors.red,
              );
            });
          }
           
        },
        builder: (context, state) {
          return Scaffold(
            body: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Register',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  textFieldItem(
                      Controller: nameController, hintText: "User Name"),
                  SizedBox(
                    height: 10,
                  ),
                  textFieldItem(Controller: emailController, hintText: "Email"),
                  SizedBox(
                    height: 10,
                  ),
                  textFieldItem(Controller: phoneController, hintText: "phone"),
                  SizedBox(
                    height: 10,
                  ),
                  textFieldItem(
                    isSecure: true,
                    Controller: passwordController, hintText: "password"),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<AuthCubit>(context).register(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            password: passwordController.text);
                      } else {}
                    },
                    child: state is RegisterLoadingState ? CircularProgressIndicator(color: Colors.red,)  : Text('Register'),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    minWidth: double.infinity,
                  ),
                ],
              ),
            ),
          );
        },
      );
  }
}

class textFieldItem extends StatelessWidget {
  textFieldItem({
    Key? key,
    required this.Controller,
    required this.hintText,
    this.isSecure,
  }) : super(key: key);

  final TextEditingController Controller;
  String hintText;
  bool? isSecure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: Controller,
      validator: (Input) {
        if (Controller.text.isEmpty) {
          return "$hintText must be not empty";
        } else {
          return null;
        }
      },
      obscureText: isSecure ?? false ,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}
