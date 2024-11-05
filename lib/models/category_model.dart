class CategoryModel{
  int? id;
  String? url;
  String? title;
  
 // Refactoring json
  CategoryModel.fromJson({required Map< String,dynamic> json }){
    id =json['id'];
    url=json['image'];
    title =json['name'];
  }
 
}