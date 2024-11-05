import 'package:ecommerce/layout/layout_cubit.dart';
import 'package:ecommerce/layout/layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      body:  BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context, state) {
          
        } ,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
        children: [
            Expanded(child: 
        cubit.carts.isNotEmpty ?
            ListView.separated(
              separatorBuilder: (context,index){
                return SizedBox(height: 5,);
              },
              itemCount: cubit.carts.length,
              itemBuilder:(context,index){
              
              return Container(
                decoration: BoxDecoration(
                  color: Colors.amber ,

                ),
                child: Row(
                  children: [
                    Image.network(cubit.carts[index].image!,height: 100,width: 100,fit: BoxFit.fill,),
                    Expanded(child: 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cubit.carts[index].name!),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Text("${cubit.carts[index].price!} \$"),
                            SizedBox(width: 5,),
                            Text("${cubit.carts[index].oldPrice!} \$"),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(onTap: (){
                            cubit.addOrRemoveFromFavorites(id: cubit.carts[index].id.toString());
                            },
                            child: Icon(Icons.favorite,
                            color:
                            cubit.favoritesId.contains(cubit.carts[index].id.toString()) ? Colors.red :
                             Colors.grey
                            ),
                            ),

                            GestureDetector(
                              onTap: () {
                                cubit.addOrRemoveProductFromCart(id: cubit.carts[index].id.toString());
                              },
                            ),
                            
                            Icon(Icons.delete,color: Colors.red,)
                          ],
                        ),
                      ],
                    )
                    )
                  ],
                ) ,
              );
            })
            :
             Center(child: Text('loading...')),
            )
      
        ,Container(
            child: Text('total price ${cubit.totalPrice}'),
        )
        ],
      ),
          ); 
        }, )
    );
  }
}