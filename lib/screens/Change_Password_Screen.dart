import 'package:ecommerce/constants.dart';
import 'package:ecommerce/layout/layout_cubit.dart';
import 'package:ecommerce/layout/layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {

  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();

    ChangePasswordScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('update data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: currentPasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText:'current password' ,
              ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText:'New password' ,
              ),
            ),
 
           SizedBox(height: 15,),
           
           BlocConsumer(
            listener: (context, state) {
               if (state is ChangePasswordSuccessState) {
                 showSnackBarItem('updated suuccesfully', context, true);
                 Navigator.pop(context);
               }  
               if (state is ChangePasswordErrorState){
                 showSnackBarItem(state.errormessage!, context, false);
               }
            } ,
            builder: (context, state) {
              return  MaterialButton(onPressed: (){
               if (currentPasswordController.text.trim() == currentPassword) {
                 
                  if (newPasswordController.text.length >= 6)  {
                    cubit.changePassword(userCurrentPassword: currentPasswordController.text.trim() , newtPassword: newPasswordController.text.trim());
                  }else{
                    showSnackBarItem('password must be at least 6 chracters', context, false);
                  }


               } else {
               showSnackBarItem('somthing wronge please try again', context, false);
               }
            },
            child: Text(state is ChangePasswordLoadingState ?  'loading...' : 'update'),
            textColor: Colors.white,
            color: Colors.black,
            minWidth: double.infinity,
            height: 40,
            );
            }, )
          ],
        ),
      ),
    );
  }

  void showSnackBarItem(String message,context,bool forSuccessOrFailure){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),
     backgroundColor: forSuccessOrFailure ? Colors.green : Colors.red,
     ));
  }
}


