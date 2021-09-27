class DataCardInfiniteScroll {
  final String? id;
  final String? image;
  final String? title;
  final String? organizerName;
  final String? location;
  final String? dateTime;
  final int? quota;
  final int? joinedParticipant;
  const DataCardInfiniteScroll({
    this.id,
    this.image,
    this.title,
    this.organizerName,
    this.location,
    this.dateTime,
    this.quota,
    this.joinedParticipant,
  });
  @override
  String toString() {
    return 'DataCardInfiniteScroll(id: $id, image: $image, title: $title, organizerName: $organizerName, location: $location, dateTime: $dateTime, quota: $quota, joinedParticipant: $joinedParticipant)';
  }

  factory DataCardInfiniteScroll.fromJson(Map<String, dynamic> json) =>
      DataCardInfiniteScroll(
        id: json['id'] as String?,
        image: json['image'] as String?,
        title: json['title'] as String?,
        organizerName: json['organizerName'] as String?,
        location: json['location'] as String?,
        dateTime: json['dateTime'] as String?,
        quota: json['quota'] as int?,
        joinedParticipant: json['joinedParticipant'] as int?,
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'title': title,
        'organizerName': organizerName,
        'location': location,
        'dateTime': dateTime,
        'quota': quota,
        'joinedParticipant': joinedParticipant,
      };
}
