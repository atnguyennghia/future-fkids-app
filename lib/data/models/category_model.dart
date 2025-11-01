class CategoryModel {
  dynamic categoryId;
  dynamic categoryName;
  dynamic contentType;
  dynamic contentTypeName;
  dynamic point;
  dynamic percentComplete;

  CategoryModel(
      {this.categoryId,
      this.categoryName,
      this.contentType,
      this.contentTypeName});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    contentType = json['content_type'].toString();
    contentTypeName = json['content_type_name'];
    point = json['point'];
    percentComplete = json['percent_complete'];
  }
}
