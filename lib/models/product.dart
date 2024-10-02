// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:amazon_clone/models/ratings.dart';
import 'package:flutter/foundation.dart';

class Product {
  final String name;
  final String description;
  final num price; /* int or double */
  final num quantity;
  final String category;
  final List<String> images;
  final String? id;
  final num? rating;
  final num? numReviews;
  final List<Ratings>? ratings;
  // final String? userId;
  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.images,
    this.ratings,
    this.id,
    this.rating,
    this.numReviews,
    // this.userId,
  });

  Product copyWith({
    String? name,
    String? description,
    double? price,
    double? quantity,
    String? category,
    List<String>? images,
    String? id,
    num? rating,
    num? numReviews,
    final List<Ratings>? ratings,
  }) {
    return Product(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      images: images ?? this.images,
      id: id ?? this.id,
      rating: rating ?? this.rating,
      numReviews: numReviews ?? this.numReviews,
      ratings: ratings ?? this.ratings,
      // userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category,
      'images': images,
      'id': id,
      'rating': rating,
      'numReviews': numReviews,
      'ratings': ratings,
      // 'userId': userId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0.0,
      quantity: map['quantity'] ?? 0.0,
      category: map['category'] ?? '',
      images: List<String>.from(
        (map['images']),
      ),
      id: map['_id'],
      rating: map['rating'],
      numReviews: map['numReviews'],
      ratings: map['ratings'] == null ? null : List<Ratings>.from(map['ratings']?.map((x) => Ratings.fromMap(x as Map<String, dynamic>))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    // return 'Product(name: $name, description: $description, price: $price, quantity: $quantity, category: $category, images: $images, id: $id, userId: $userId)';
    return 'Product(name: $name, description: $description, price: $price, quantity: $quantity, category: $category, images: $images, id: $id)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.price == price &&
        other.quantity == quantity &&
        other.category == category &&
        listEquals(other.images, images) &&
        // other.id == id &&
        other.id == id &&
        other.rating == rating &&
        other.numReviews == numReviews &&
        listEquals(other.ratings, ratings);
    // other.userId == userId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        category.hashCode ^
        images.hashCode ^
        // id.hashCode ^
        id.hashCode ^
        rating.hashCode ^
        numReviews.hashCode ^
        ratings.hashCode;
    // userId.hashCode;
  }
}
