import 'dart:convert';

class AddData {
  String title;
  String description;
  String id;
  String date;
  AddData({
    required this.title,
    required this.description,
    required this.id,
    required this.date,
  });

  AddData copyWith({
    required String title,
    required String description,
    required String id,
    required String date,
  }) {
    return AddData(
      title: title ?? this.title,
      description: description ?? this.description,
      id: id ?? this.id,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
    };
  }

//used for add or update the database
  factory AddData.fromMap_ae(Map<String, dynamic> map) {
    return AddData(
      title: map['title'],
      description: map['description'],
      id: map['\$id'],
      date: map['date'],
    );
  }

//used for initialization from database
  factory AddData.fromMap(Map<String, dynamic> map) {
    return AddData(
      title: map['data']?['title'],
      description: map['data']?['description'],
      id: map['\$id'],
      date: map['data']?['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddData.fromJson(String source) =>
      AddData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddData(title: $title, description: $description, id: $id, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddData &&
        other.title == title &&
        other.description == description &&
        other.id == id &&
        other.date == date;
  }

  @override
  int get hashCode {
    return title.hashCode ^ description.hashCode ^ id.hashCode ^ date.hashCode;
  }
}
