import 'package:ecommerce/layout/layout_cubit.dart';
import 'package:ecommerce/layout/layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  var cubit=  BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context, state) {
        
      } ,
      builder: (context, state) {
        return  Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children:[
             TextFormField(
              decoration:InputDecoration(
                icon: Icon(Icons.search),
                hintText: 'search',
                border: OutlineInputBorder(
                  borderRadius:BorderRadius.circular(50),
                ) ,
              ) ,
             ),
             
             ListView.builder(
              itemCount: cubit.favoritesProducts.length,
              itemBuilder: (context,index){
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10) ,
                  padding: EdgeInsets.all(10),
                  color: Colors.grey,
                  
                  child:Row(
                    children: [
                      Image.network(cubit.favoritesProducts[index].image!,width: 120,height: 100,fit: BoxFit.fill,),
                      SizedBox(width: 10,),
                      Expanded(child: 
                      Column(
                        children: [
                          Text(cubit.favoritesProducts[index].name!),
                          Text("${cubit.favoritesProducts[index].price!} \$",maxLines:1 ,style: TextStyle(fontSize: 18,), ),
                          MaterialButton(
                             onPressed: () {
                               cubit.addOrRemoveFromFavorites(id:cubit.favoritesProducts[index].id.toString() );
                             },
                             
                             child:Text('Remove') ,
                              textColor: Colors.white ,
                              color: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius:BorderRadius.circular(25) ,
                              ) ,
                             )
                        ],
                      ),
                      ),
                    ],
                  ) ,
                );
              }
              ),
        
          ],
        ),
        ) ,
    );
      }, );
  }
}