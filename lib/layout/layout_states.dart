abstract class LayoutStates {
  
}

class LayoutInitialState extends LayoutStates {
  
}



class ChangeBottomNavLayoutState extends LayoutStates {
  
}



class GetUserSuccessState extends LayoutStates {
  
}
class GetUserErrorState extends LayoutStates {
  String error;
  GetUserErrorState({required this.error});
}
class GetUserLoadingState extends LayoutStates {
  
}








class GetBannersLoadingState extends LayoutStates {}
class GetBannersSuccessState extends LayoutStates {}
class GetBannersErrorState extends LayoutStates {}






class GetCategorisSuccessState extends LayoutStates {}
class GetCategorisErrorState extends LayoutStates {}






class GetProductsSuccessState extends LayoutStates {}
class GetProductsErrorState extends LayoutStates {}

class FilteredProductsSuccessStat extends LayoutStates {}






class GetFavoritesSuccessState extends LayoutStates {}
class GetFavoritesErrorState extends LayoutStates {}






class AddOrRemoveFavoritesSuccessState extends LayoutStates {}
class AddOrRemoveFavoritesErrorState extends LayoutStates {}







class GetCartsSuccessState extends LayoutStates {}
class GetCartsErrorState extends LayoutStates {}



class AddToCartSuccessState extends LayoutStates {}
class AddToCartErrorState extends LayoutStates {}







class ChangePasswordErrorState extends LayoutStates {
  String? errormessage;
  ChangePasswordErrorState({this.errormessage});
}
class ChangePasswordSuccessState extends LayoutStates {}
class ChangePasswordLoadingState extends LayoutStates {}







class UpdateUserDataSuccessState extends LayoutStates {}
class UpdateUserDatadLoadingState extends LayoutStates {}
class UpdateUserDatadErrorState extends LayoutStates {
  String? errormessage;
  UpdateUserDatadErrorState({this.errormessage});
}