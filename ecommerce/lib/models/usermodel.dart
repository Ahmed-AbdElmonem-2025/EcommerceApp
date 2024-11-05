class UserModel {
  
  String? name ;
  
  String? email ;
  
  String? phone ;
  
  String? image ;
  
  String? token ;

  UserModel(this.name,this.email,this.phone,this.image,this.token);

  UserModel.fromJson({required Map<String,dynamic> json }){
   name= json['name'];
   email= json['email'];
   phone= json['phone'];
   image= json['image'];
   token= json['token'];
  }


}