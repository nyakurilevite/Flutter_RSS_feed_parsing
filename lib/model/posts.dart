class Posts {
  final String ? id;
  final String ? category_id;
  final String ? name;
  final String ? email;
  final String ? title;
  final String ? contents;
  final bool ? anonymous;
  final String ? approved;
  final String ? created_at;

  Posts({
    this.id,
    this.category_id,
    this.name,
    this.email,
    this.title,
    this.contents,
    this.anonymous,
    this.approved,
    this.created_at
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
        id: json['_id'] as String,
        name:json['name'] as String,
        email:json['email'] as String,
        category_id: json['category_id'] as String,
        title: json['title'] as String,
        contents: json['contents'] as String,
        anonymous: json['anonymous'] as bool,
        approved: json['approved'] as String,
        created_at: json['created_at'] as String,

    );
  }

  @override
  String toString() {
    return 'Posts{id: $id, category_id: $category_id,  name: $name,email: $email,title:$title, contents:$contents,anonymous:$anonymous,approved:$approved,created_at:$created_at}';
  }
}