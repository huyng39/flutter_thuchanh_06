import 'dart:convert';

class Product_Model {
  int? id;
  String? name;
  int? price;
  String? img;
  String? des;
  int? catId;
  //constructor
  Product_Model(
      {this.id, required this.name, this.price, this.img, this.des, this.catId});

  String toJson() => json.encode(toMap());

  factory Product_Model.fromJson(String source) => Product_Model.fromMap(jsonDecode(source));
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data["id"] = id;
  //   data["name"] = name;
  //   data["price"] = price;
  //   data["img"] = img;
  //   data["des"] = des;
  //   data["catId"] = catId;
  //   return data;
  // }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name' : name,
      'price' : price,
      'img' : img,
      'des' : des,
      'catId' : catId,
    };
  }

  factory Product_Model.fromMap(Map<String, dynamic> map) {
    return Product_Model(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      //?
      price: map['price'] ?.toInt(),
      img: map['img'] ?? '',
      des: map['des'] ?? '',
      //?
      catId: map['catId'] ?.toInt(),
    );
  }

  @override
  String toString() => 'Product(id: $id, name: $name, price: $price, img: $img, des: $des, catId: $catId)';
}
