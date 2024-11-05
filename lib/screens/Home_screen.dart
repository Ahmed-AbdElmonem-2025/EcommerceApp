import 'package:ecommerce/layout/layout_cubit.dart';
import 'package:ecommerce/layout/layout_states.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/screens/auth_screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  
  const HomeScreen({ Key? key }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        return Scaffold(
      body:  ListView(
        children: [
          TextFormField(
            onChanged: (input) {
              cubit.filtereProducts(input: input);
            },
             decoration: InputDecoration(
              prefixIcon:Icon(Icons.search ) ,
              hintText: 'search',
              suffixIcon: Icon(Icons.clear),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),) ,
              contentPadding: EdgeInsets.zero,
              filled:true,
              fillColor: Colors.grey,
             ),
             
          ),
          SizedBox(height: 15,),
        cubit.banners.isEmpty ? Center(child: CupertinoActivityIndicator(), )
         :
        
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(height: 150,width: double.infinity,
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: cubit.banners.length,
              itemBuilder:(context,index){
               return Container(
                margin: EdgeInsets.only(right: 12),
                child: Image.network(cubit.banners[index].url!,fit: BoxFit.fill, ),
               );
              }
              ),
            ),
          ),
          SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children:[
             Text('Categories',style: TextStyle(fontSize: 44,fontWeight: FontWeight.bold,color: Colors.amber),),
             Text('Categories',style: TextStyle(fontSize: 44,fontWeight: FontWeight.bold,color: Colors.black,)),
        ]
            ),
            SizedBox(height: 12,),
      cubit.categories.isEmpty ? Center(child: CupertinoActivityIndicator(), )
         :

         SizedBox(height: 70,width: double.infinity,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: cubit.categories.length,
              separatorBuilder: (context, index) {
                return SizedBox(width: 5,);
              },
              itemBuilder:(context,index){
               return CircleAvatar(
                 radius:35 ,
                backgroundImage: NetworkImage(cubit.categories[index].url!,  ),
               );
              }
              ),
            ),
          
           SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children:[
             Text('products',style: TextStyle(fontSize: 44,fontWeight: FontWeight.bold,color: Colors.amber),),
             Text('view all',style: TextStyle(fontSize: 44,fontWeight: FontWeight.bold,color: Colors.black,)),
        ]
            ),
        cubit.products.isEmpty ? Center(child: CupertinoActivityIndicator(), )
        :
          GridView.builder(
            shrinkWrap:true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cubit.filteredProducts.isEmpty ? cubit.products.length
            : cubit.filteredProducts.length
            ,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 12,

              ), 
            itemBuilder: (context,index){
             return productItem(productModel: cubit.filteredProducts.isEmpty ?
             
              cubit.products[index]
              :
              cubit.filteredProducts[index],

              cubit: cubit,
              );
            }),
        ],
      ),
      );
      }, );
    
  }
}




Widget productItem({required ProductModel productModel,required LayoutCubit cubit}){

 return Stack(
  alignment: Alignment.bottomCenter,
  children: [
    Container(
  color: Colors.grey,
  padding: EdgeInsets.symmetric(vertical: 10,horizontal:12),
  child:Column(
    children: [
      Expanded(child: Image.network(productModel.image!,),),
    SizedBox(height: 10,),
     Text(productModel.name!,style: TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),),
    SizedBox(height: 7,),
     Row(
      children:[
       Expanded(
        child:  Row(
          children:[
          Text("${productModel.price!} \$",style: TextStyle(fontSize: 14),),
          SizedBox(width: 5,),
          Text("${productModel.oldPrice!} \$",style: TextStyle(fontSize: 13,decoration: TextDecoration.lineThrough),),
          ],
        ),

        ),
      
      GestureDetector(
        child: Icon(Icons.favorite,size: 20,color:
         
        cubit.favoritesId.contains(productModel.id.toString()) ?  Colors.red  : Colors.grey,
         
         ),
        onTap: () {
          // Add or Remove
          cubit.addOrRemoveFromFavorites(id: productModel.id.toString());
        },
      ),
      ],
     ),
    ],
    
  ) ,
 ),

    CircleAvatar(
      backgroundColor: Colors.black,
      child: GestureDetector(
        
        onTap:(){
              cubit.addOrRemoveProductFromCart(id: productModel.id.toString());
        },
        child:Icon(Icons.shopping_cart,
        color: cubit.cartsId.contains(productModel.id.toString()) ?  Colors.red :Colors.white,
        ) , 
      ),
    )


  ],
 );

}