class Owner {
  final String? id;
  final String? name;
  const Owner({
    this.id,
    this.name,
  });
  @override
  String toString() {
    return 'Owner(id: $id, name: $name)';
  }

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json['id'] as String?,
        name: json['name'] as String?,
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
