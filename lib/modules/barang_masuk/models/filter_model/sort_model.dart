class SortModel {
  final String? id;
  final String? name;
  SortModel({this.id, this.name});
  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
      };
}
