import 'package:flutter/material.dart';

class PhoneColor {
  final String name;
  final Color color;
  const PhoneColor(this.name, this.color);
}

class Phone {
  final String id;
  final String brand;
  final String name;
  final int price;
  final int? oldPrice; 
  final int stock;
  final double rating;
  final int sold;
  final String description;
  final String imageUrl;
  final List<PhoneColor> colors;
  final List<String> storages;
  final Map<String, String> specs;

  const Phone({
    required this.id,
    required this.brand,
    required this.name,
    required this.price,
    this.oldPrice,
    required this.stock,
    required this.rating,
    required this.sold,
    required this.description,
    required this.imageUrl,
    required this.colors,
    required this.storages,
    required this.specs,
  });

  int get discountPercent {
    if (oldPrice == null || oldPrice! <= price) return 0;
    return (((oldPrice! - price) / oldPrice!) * 100).round();
  }
}

String rupiah(int value) {
  final s = value.toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return 'Rp $buf';
}