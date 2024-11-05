class BannerModel{
  int? id;
  String? url;

 // Refactoring json
  BannerModel.fromJson({required Map< String,dynamic> json }){
    id =json['id'];
    url=json['image'];

  }
 
}