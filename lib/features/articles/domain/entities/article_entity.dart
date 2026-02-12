import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ArticleEntity extends Equatable {
  const ArticleEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.contentURI,
    required this.categories,
    this.content = '',
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String contentURI;
  final String content;
  final List<String> categories;

  ArticleEntity copyWith({
    String? id,
    String? title,
    String? subtitle,
    IconData? icon,
    Color? color,
    String? contentURI,
    String? content,
    List<String>? categories,
  }) {
    return ArticleEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      contentURI: contentURI ?? this.contentURI,
      content: content ?? this.content,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object> get props => [
    id,
    title,
    subtitle,
    icon,
    color,
    contentURI,
    content,
    categories,
  ];
}
