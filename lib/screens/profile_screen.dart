import 'package:ecommerce/layout/layout_cubit.dart';
import 'package:ecommerce/layout/layout_states.dart';
import 'package:ecommerce/screens/Change_Password_Screen.dart';
import 'package:ecommerce/screens/update_user_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context, state) {
        
      } ,
      builder: (context, state) {
        var cubit = BlocProvider.of<LayoutCubit>(context);
        if (cubit.userModel == null) cubit.getUserData();

        return Scaffold(
      appBar: AppBar(title: Text('profile'),),
      body: cubit.userModel != null ? Column(
        children: [
          Image.network(cubit.userModel!.image!),
          SizedBox(height: 15,),
            Text(cubit.userModel!.name!),
            SizedBox(height: 10,),
            Text(cubit.userModel!.email!),
            SizedBox(height: 10,),
            MaterialButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder:(context){
                return ChangePasswordScreen();
               }
               ),
               );
            },
            child: Text('change password'),
            ),

             MaterialButton(
              onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder:(context){
                return UpdateUserDataScreen();
               }
               ),
               );
            },
            child: Text('update data'),
            ),
        ],
      ) : Center(
        child: CircularProgressIndicator(),
      )
    );
      }, );
  }
}