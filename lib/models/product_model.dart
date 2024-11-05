class ProductModel {
  
  int? id;
  String? name;
  String? description;
  String? image;
  int? price;
  int? oldPrice;
  int? discount;


  ProductModel.fromJson({required Map<String , dynamic> data}){
    id = data['id'].toInt();
    name = data['name'];
    description = data['description'];
    price = data['price'].toInt();
    oldPrice = data['old_Price'].toInt();
    discount = data['discount'].toInt();
    image = data['image'];

  }
}