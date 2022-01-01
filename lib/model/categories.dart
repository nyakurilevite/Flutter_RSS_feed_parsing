class Category {
  final String ? id;
  final String ? categories_name;
  final String ? created_at;

  Category({
    this.id,
    this.categories_name,
    this.created_at
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] as String,
      categories_name:json['categories_name'] as String,
      created_at: json['created_at'] as String,
    );
  }

  @override
  String toString() {
    return 'Category{id: $id, categories_name: $categories_name,created_at:$created_at}';
  }
}