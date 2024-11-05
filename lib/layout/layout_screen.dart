import 'package:ecommerce/layout/layout_cubit.dart';
import 'package:ecommerce/layout/layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener:  (context, state) {
        
      },
      builder:  (context, state) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.amber,
          title: Text('Shopping',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40, color: Colors.black, ), ),
        ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: cubit.currentIndex,
        selectedItemColor:  Colors.blue ,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          cubit.changeCurrentIndex(index: index);
        },
        items: 
     const [
        BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home',),
        BottomNavigationBarItem(icon: Icon(Icons.category,),label: 'category',),
        BottomNavigationBarItem(icon: Icon(Icons.favorite,),label: 'favorite',),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'shopping_cart',),
        BottomNavigationBarItem(icon: Icon(Icons.person,),label: 'person',),
      ]
      ),
      body: cubit.layoutScreens[cubit.currentIndex],
    );
      },
      );
  }
}