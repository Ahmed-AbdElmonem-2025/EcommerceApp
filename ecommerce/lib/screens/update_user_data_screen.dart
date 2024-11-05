import 'package:ecommerce/layout/layout_cubit.dart';
import 'package:ecommerce/layout/layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserDataScreen extends StatelessWidget {
   var emailController = TextEditingController();
  var nameController = TextEditingController();
   var phoneController = TextEditingController();
  
    UpdateUserDataScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    emailController.text = cubit.userModel!.email!;
    phoneController.text = cubit.userModel!.phone!;
    nameController.text = cubit.userModel!.name!;
    return Scaffold(
       appBar: AppBar(
        title: Text('update data'),
      ),
      body: Column(
        children:[
          TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText:'user name ' ,
              ),
            ),


            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText:'phone' ,
              ),
            ),



            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText:'email' ,
              ),
            ),


            
            BlocConsumer<LayoutCubit,LayoutStates>(
              listener:  (context, state) {
                if (state is UpdateUserDataSuccessState) {
                  showSnackBarItem('user data updated successfully', context, true);
                  Navigator.pop(context);
                } 
                if (state is UpdateUserDatadErrorState) {
                  showSnackBarItem(state.errormessage!, context, false);
                }
              },
              builder: (context, state) {
                return  MaterialButton(
              onPressed: (){
                
                if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty && emailController.text.isNotEmpty) {
                  cubit.updateUserData(name: nameController.text, phone: phoneController.text, email: emailController.text);
                } else {

                  showSnackBarItem('somthine wrong please try again', context, false);
                }
            },
            child:  Text(state is UpdateUserDatadLoadingState ? 'loading...'  : 'update'),
            );
              }, ),
        ],
      ),
    );
  }
}





  void showSnackBarItem(String message,context,bool forSuccessOrFailure){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),
     backgroundColor: forSuccessOrFailure ? Colors.green : Colors.red,
     ));
  }
