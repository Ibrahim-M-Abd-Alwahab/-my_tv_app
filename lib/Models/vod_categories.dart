class VodCategories {
  String? categoryId;
  String? categoryName;
  int? parentId;

  VodCategories({this.categoryId, this.categoryName, this.parentId});

  VodCategories.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    parentId = json['parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['parent_id'] = parentId;
    return data;
  }
}
