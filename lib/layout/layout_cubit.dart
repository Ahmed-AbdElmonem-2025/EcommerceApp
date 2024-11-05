import 'dart:convert';

import 'package:ecommerce/constants.dart';
import 'package:ecommerce/layout/layout_states.dart';
import 'package:ecommerce/models/banner_model.dart';
import 'package:ecommerce/models/category_model.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/models/usermodel.dart';
import 'package:ecommerce/network/local_network.dart';
import 'package:ecommerce/screens/Home_screen.dart';
import 'package:ecommerce/screens/cart.dart';
import 'package:ecommerce/screens/categories.dart';
import 'package:ecommerce/screens/favorites.dart';
import 'package:ecommerce/screens/profile_screen.dart';
import 'package:flutter/material.dart';
 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http ;
import 'package:http/http.dart';
class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit(): super(LayoutInitialState());


  int currentIndex =0;

  List<Widget> layoutScreens=[
    HomeScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    CartScreen(),
    ProfileScreen(),

  ];
   
  void changeCurrentIndex({required int index }){
   currentIndex = index;
   emit(ChangeBottomNavLayoutState());
  }





List<BannerModel> banners =[];

  void getBannersData()async {
   Response response = await http.get(
      Uri.parse('https://student.valuxapps.com/api/banners')
    );
   var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
     
     for (var banner in responseBody['data']) {
       banners.add(BannerModel.fromJson(json:banner));
     }

      emit(GetBannersSuccessState());
    } else {

      emit(GetBannersErrorState());
    }
  }









List<CategoryModel> categories =[];

  void getCategoriesData()async {
   Response response = await http.get(
      Uri.parse('https://student.valuxapps.com/api/categories')
    );
   var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
     
     for (var category in responseBody['data']['data']) {
       categories.add(CategoryModel.fromJson(json:category));
     }

      emit(GetCategorisSuccessState());
    } else {

      emit(GetCategorisErrorState());
    }
  }





List<ProductModel> products =[];

 void getProducts()async {
   
 Response response = await  http.get(
    Uri.parse('https://student.valuxapps.com/api/home'),
    headers: {
      'Authorization' : token! ,
      'lang' : 'en',
    }
   );
     var responseBody = jsonDecode(response.body);
   if (responseBody['status'] == true) 
   {
     for (var product in responseBody['data']['products']) {
       products.add(ProductModel.fromJson(data:  product));
     }
     emit(GetProductsSuccessState());
   } else {
    emit(GetProductsSuccessState());
   }

 }



 List<ProductModel> filteredProducts=[];
 void filtereProducts ({required String input}){
  filteredProducts = products.where((element) {
    return element.name!.toLowerCase().startsWith(input.toLowerCase());
    }).toList();
    emit(FilteredProductsSuccessStat());
   } 

   /*
   // حل اخر باستخدام for in
   void filterProducts({required String input}) {
  // ببدأ بحلقة for-in على كل منتج في قائمة المنتجات
  for (var product in products) {
    // بشرط إن اسم المنتج يبدأ بالنص اللي المستخدم كتبه
    if (product.name!.toLowerCase().startsWith(input.toLowerCase())) {
      // لو الشرط اتحقق، أضيف المنتج للقائمة الجديدة
      filteredProducts.add(product);
    }
  }
}
   */
 





List<ProductModel> favoritesProducts = [];
Set <String> favoritesId ={}; // هخزن اى دى كل المنتجات هنا عشان اشوف هل المنتج موجود فى الفيفوريتس ولا لا
Future<void> getFavorites()async {
      favoritesProducts.clear();
     Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/favorites'),
        headers: {
          'Authorization' : token!,
        }
      );
      var responseBody = jsonDecode(response.body) ;
      if (responseBody['status'] == true) {

        for (var product in responseBody['data']['data']) {
        favoritesProducts.add(ProductModel.fromJson(data: product['product'],),)  ;
        favoritesId.add(product['product']['id'].toString(),);
        } 
         emit(GetFavoritesSuccessState());
      } else {
        emit(GetFavoritesErrorState());
      }
 }





 void addOrRemoveFromFavorites({required String id})async {
    Response response = await  http.post(
        Uri.parse('https://student.valuxapps.com/api/favorites'),
        headers: {
          'Authorization' : token!,
        },
        body: {
         "product_id" : id,

        }
      );
      var responseBody = jsonDecode(response.body);
      if (responseBody['data']==true) {
        
        if (favoritesId.contains(id)==true) {
          // delete
           favoritesId.remove(id);
        } else {

          //add
          favoritesId.add(id);
        }
        await getFavorites();
        emit(AddOrRemoveFavoritesSuccessState());
      } else {
        emit(AddOrRemoveFavoritesErrorState());
      }
 }









List<ProductModel> carts=[];
int totalPrice =0;
Set cartsId ={};
 Future<void> getCarts() async{
  carts.clear();
 Response response = await  http.get(
    Uri.parse('https://student.valuxapps.com/api/carts'),
    headers: {
      'Authorization' : token!,
    }

  );
  var responseBody = jsonDecode(response.body);
  totalPrice = responseBody['data']['total'].toInt(); 
  if (responseBody['status'] == true) {
    
    for (var product in responseBody['data']['cart_items']) {
      cartsId.add(product['product']['id'].toString());
     carts.add(ProductModel.fromJson(data: product['product'])) ;
    }
    emit(GetCartsSuccessState());
  } else {
    emit(GetCartsErrorState());
  }
 }




 void addOrRemoveProductFromCart({required String id})async{
    
   Response response = await http.post(
      Uri.parse('https://student.valuxapps.com/api/carts'),
      body: {
        "product_id" : id,
      },
      headers: {
        "Authorization" : token!
      },
    );
     
     var responseBody = jsonDecode(response.body) ;
     if (responseBody['status'] == true){
      // السطر جا مش ضرورى لانها كدا كدا بتتحدث ولكن بيخلى تجربة المستخدم اسرع وانه اتعمل فى اللحظة
      cartsId.contains(id) == true ? cartsId.remove(id) : cartsId.add(id);

     await getCarts();
       emit(AddToCartSuccessState());
     } else {
      emit(AddToCartErrorState());
     }

 }







 void changePassword({required String userCurrentPassword,required String newtPassword,})async {
     
   emit(ChangePasswordLoadingState());
  Response response = await  http.post(
     Uri.parse('https://student.valuxapps.com/api/change-password') ,
      headers: {
        'Authorization' : token! ,
      },
      body: {
          'current_password' : userCurrentPassword,
          'new_password' : newtPassword,
      },
    );
  var responseBody =  jsonDecode(response.body);
   
  if (responseBody['status'] == true) {
    await CacheNetwork.insertToCache(key: 'password',value: newtPassword);
                       // دى قيمة الباسوورد الجديدة
    currentPassword =  CacheNetwork.getCacheData(key: 'password'); // or newtPassword;
    emit(ChangePasswordSuccessState());
  } else {
    emit(ChangePasswordErrorState(errormessage: responseBody['message']));
  }
 
 }





 void updateUserData({required String name,required String phone,required String email})async {
     
   emit(UpdateUserDatadLoadingState());
 try {
    Response response = await  http.put(
     Uri.parse('https://student.valuxapps.com/api/update-profile') ,
      headers: {
        'Authorization' : token! ,
      },
      body: {
          'name' : name,
          'email' : email,
          'phone' :phone,
      },
    );
  var responseBody =  jsonDecode(response.body);
   
  if (responseBody['status'] == true) {
   await getUserData();
                       
    
    emit(UpdateUserDataSuccessState());
  } else {
    emit(ChangePasswordErrorState(errormessage: responseBody['message']));
  }
 } catch (e) {
   emit(ChangePasswordErrorState(errormessage: e.toString()));
 }
 
 }



 UserModel? userModel;

  Future<void> getUserData()async {
    emit(GetUserLoadingState());
    Response response = await http.get(Uri.parse('https://student.valuxapps.com/api/profile'),
      headers: {
        'Authorization' : token!,
      }
      
      );
       
      var responseData = jsonDecode(response.body);
      if (responseData['status']==true) {
        UserModel.fromJson(json: responseData['data']);
        
        emit(GetUserSuccessState());
      } else {
        emit(GetUserErrorState(error: responseData['message']));
      }

  }
}