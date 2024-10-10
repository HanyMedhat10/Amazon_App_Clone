// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:amazon_clone/models/product.dart';
import 'package:flutter/foundation.dart';

class Order {
  final String id;
  final String userId;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final int status;
  final String orderedAt;
  Order({
    required this.id,
    required this.userId,
    required this.products,
    required this.quantity,
    required this.address,
    required this.status,
    required this.orderedAt,
  });

  Order copyWith({
    String? id,
    String? userId,
    List<Product>? products,
    List<int>? quantity,
    String? address,
    int? status,
    String? orderedAt,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      products: products ?? this.products,
      quantity: quantity ?? this.quantity,
      address: address ?? this.address,
      status: status ?? this.status,
      orderedAt: orderedAt ?? this.orderedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'status': status,
      'orderedAt': orderedAt,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as String,
      userId: map['userId'] as String,
      products: List<Product>.from(
        (map['products'] as List<int>).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
      quantity: List<int>.from(
        (map['quantity'] as List<int>),
      ),
      address: map['address'] as String,
      status: map['status'] as int,
      orderedAt: map['orderedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, userId: $userId, products: $products, quantity: $quantity, address: $address, status: $status, orderedAt: $orderedAt)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        listEquals(other.products, products) &&
        listEquals(other.quantity, quantity) &&
        other.address == address &&
        other.status == status &&
        other.orderedAt == orderedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        products.hashCode ^
        quantity.hashCode ^
        address.hashCode ^
        status.hashCode ^
        orderedAt.hashCode;
  }
}
