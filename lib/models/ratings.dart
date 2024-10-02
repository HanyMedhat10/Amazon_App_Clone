import 'dart:convert';

class Ratings {
  final String userId;
  final num rating;
  Ratings({
    required this.userId,
    required this.rating,
  });

  Ratings copyWith({
    String? userId,
    num? rating,
  }) {
    return Ratings(
      userId: userId ?? this.userId,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'rating': rating,
    };
  }

  factory Ratings.fromMap(Map<String, dynamic> map) {
    return Ratings(
      userId: map['userId'] as String,
      rating: map['rating'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ratings.fromJson(String source) =>
      Ratings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Ratings(userId: $userId, rating: $rating)';

  @override
  bool operator ==(covariant Ratings other) {
    if (identical(this, other)) return true;

    return other.userId == userId && other.rating == rating;
  }

  @override
  int get hashCode => userId.hashCode ^ rating.hashCode;
}
