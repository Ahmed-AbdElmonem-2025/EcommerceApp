import 'package:ecommerce/layout/layout_cubit.dart';
import 'package:ecommerce/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoriesData = BlocProvider.of<LayoutCubit>(context).categories;

    return Scaffold(
      body: Padding(padding:const EdgeInsets.symmetric(vertical: 8,horizontal:12),
      child: GridView.builder(
        itemCount: categoriesData.length,
        gridDelegate:(
       const   SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 10,

            )
        ) ,
        
        itemBuilder: (context,index){
          return  Container(
            child: Column(
              children: [
                 Expanded(child: Image.network(categoriesData[index].url!,fit: BoxFit.fill,)),
                const SizedBox(height: 10,),
                 Text(categoriesData[index].title!),

              ],
            ),
          );
        }),
      ) ,
    );
  }
}