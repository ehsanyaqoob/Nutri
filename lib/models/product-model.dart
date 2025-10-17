class ProductModel {
  final String id;
  final String title;
  final String image;
  final String price;
  final String reviews;
  final int viewCount;
  final double rating;
  final bool isLiked;
  final String description;

  ProductModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    this.reviews = "4.5 (100)",
    this.viewCount = 2100,
    this.rating = 4.5,
    this.isLiked = false,
    this.description = "High quality, durable and designed to enhance your living space. Crafted with premium materials and attention to detail, this product combines style and functionality perfectly. Easy to maintain and built to last for years of comfortable use.",
  });

  // Convert ProductModel to Map for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'reviews': reviews,
      'viewCount': viewCount,
      'rating': rating,
      'isLiked': isLiked,
      'description': description,
    };
  }

  // Create ProductModel from Map (JSON)
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      price: json['price'] ?? '',
      reviews: json['reviews'] ?? "4.5 (100)",
      viewCount: json['viewCount'] ?? 2100,
      rating: (json['rating'] ?? 4.5).toDouble(),
      isLiked: json['isLiked'] ?? false,
      description: json['description'] ?? "High quality, durable and designed to enhance your living space. Crafted with premium materials and attention to detail, this product combines style and functionality perfectly. Easy to maintain and built to last for years of comfortable use.",
    );
  }

  // Optional: Create a copyWith method for immutability
  ProductModel copyWith({
    String? id,
    String? title,
    String? image,
    String? price,
    String? reviews,
    int? viewCount,
    double? rating,
    bool? isLiked,
    String? description,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      reviews: reviews ?? this.reviews,
      viewCount: viewCount ?? this.viewCount,
      rating: rating ?? this.rating,
      isLiked: isLiked ?? this.isLiked,
      description: description ?? this.description,
    );
  }
}