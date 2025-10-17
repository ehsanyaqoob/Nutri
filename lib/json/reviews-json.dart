// Add this to your ReviewsScreen or create a separate data file
import 'package:nutri/generated/assets.dart';

final List<Map<String, dynamic>> _allReviews = [
  {
    'id': 1,
    'userName': 'Sarah Johnson',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'Absolutely love this product! The quality exceeded my expectations and it looks even better in person than in the photos. Very comfortable and durable.',
    'likes': 24,
    'isLiked': false,
    'date': '2 days ago',
  },
  {
    'id': 2,
    'userName': 'Mike Chen',
    'userImage': Assets.personfilled,
    'rating': 4.0,
    'comment':
        'Good value for the price. The delivery was fast and packaging was secure. Minor issue with assembly instructions but overall satisfied with the purchase.',
    'likes': 12,
    'isLiked': true,
    'date': '1 week ago',
  },
  {
    'id': 3,
    'userName': 'Emily Rodriguez',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'This has completely transformed my living space! The craftsmanship is excellent and it\'s very sturdy. Would definitely recommend to friends and family.',
    'likes': 31,
    'isLiked': false,
    'date': '3 days ago',
  },
  {
    'id': 4,
    'userName': 'David Thompson',
    'userImage': Assets.personfilled,
    'rating': 3.0,
    'comment':
        'Decent product but had some quality issues. The color is slightly different from what was shown online. Customer service was helpful in resolving my concerns.',
    'likes': 8,
    'isLiked': false,
    'date': '2 weeks ago',
  },
  {
    'id': 5,
    'userName': 'Lisa Wang',
    'userImage': Assets.personfilled,
    'rating': 4.5,
    'comment':
        'Very happy with this purchase! The design is modern and functional. Assembly was straightforward and it fits perfectly in my space. Great quality!',
    'likes': 19,
    'isLiked': true,
    'date': '5 days ago',
  },
  {
    'id': 6,
    'userName': 'Robert Martinez',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'Outstanding quality and beautiful design. This product has received so many compliments from guests. Worth every penny and would buy again!',
    'likes': 42,
    'isLiked': false,
    'date': '1 day ago',
  },
];

// For different products, you can create separate review lists:
final List<Map<String, dynamic>> _sofaReviews = [
  {
    'id': 1,
    'userName': 'Jennifer Lee',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'This sofa is incredibly comfortable! Perfect for movie nights and the fabric is easy to clean. The color matches our decor perfectly.',
    'likes': 28,
    'isLiked': false,
    'date': '3 days ago',
  },
  {
    'id': 2,
    'userName': 'Kevin Brown',
    'userImage': Assets.personfilled,
    'rating': 4.0,
    'comment':
        'Great sofa overall. Very comfortable and good build quality. Took some time to assemble but worth the effort. Delivery was prompt.',
    'likes': 15,
    'isLiked': true,
    'date': '1 week ago',
  },
  {
    'id': 3,
    'userName': 'Amanda Wilson',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'Absolutely stunning sofa! The quality is exceptional and it\'s very comfortable. Perfect size for our living room. Highly recommended!',
    'likes': 33,
    'isLiked': false,
    'date': '4 days ago',
  },
  {
    'id': 4,
    'userName': 'James Taylor',
    'userImage': Assets.personfilled,
    'rating': 4.5,
    'comment':
        'Very pleased with this purchase. The sofa is comfortable and looks great. Minor issue with one cushion but customer service was excellent.',
    'likes': 21,
    'isLiked': false,
    'date': '2 weeks ago',
  },
];

final List<Map<String, dynamic>> _chairReviews = [
  {
    'id': 1,
    'userName': 'Maria Garcia',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'Perfect office chair! Very comfortable for long working hours. The lumbar support is excellent and the adjustable height works great.',
    'likes': 19,
    'isLiked': true,
    'date': '2 days ago',
  },
  {
    'id': 2,
    'userName': 'Thomas Clark',
    'userImage': Assets.personfilled,
    'rating': 4.0,
    'comment':
        'Good quality chair at a reasonable price. Assembly was easy and it feels sturdy. The fabric is nice and seems durable.',
    'likes': 11,
    'isLiked': false,
    'date': '6 days ago',
  },
  {
    'id': 3,
    'userName': 'Sophia Anderson',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'Beautiful chair that complements our dining set perfectly. Very comfortable and the craftsmanship is impressive. Fast delivery too!',
    'likes': 25,
    'isLiked': false,
    'date': '1 week ago',
  },
  {
    'id': 4,
    'userName': 'Daniel White',
    'userImage': Assets.personfilled,
    'rating': 3.5,
    'comment':
        'Decent chair but could be more comfortable. The padding is a bit thin for long sitting sessions. Good for occasional use though.',
    'likes': 7,
    'isLiked': false,
    'date': '3 weeks ago',
  },
  {
    'id': 5,
    'userName': 'Olivia Martin',
    'userImage': Assets.personfilled,
    'rating': 4.5,
    'comment':
        'Love this chair! The design is modern and it\'s very comfortable. Perfect for my home office. Would definitely recommend to others.',
    'likes': 16,
    'isLiked': true,
    'date': '5 days ago',
  },
];

final List<Map<String, dynamic>> _tableReviews = [
  {
    'id': 1,
    'userName': 'William Harris',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'Excellent dining table! Perfect size for our family. The wood finish is beautiful and it feels very sturdy. Easy to clean and maintain.',
    'likes': 22,
    'isLiked': false,
    'date': '4 days ago',
  },
  {
    'id': 2,
    'userName': 'Emma Thompson',
    'userImage': Assets.personfilled,
    'rating': 4.0,
    'comment':
        'Good quality table at a reasonable price. The assembly took some time but the instructions were clear. Very satisfied with the purchase.',
    'likes': 14,
    'isLiked': true,
    'date': '1 week ago',
  },
  {
    'id': 3,
    'userName': 'Michael Scott',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'This table is exactly what we needed! The design is modern and it fits perfectly in our space. Quality is outstanding for the price.',
    'likes': 29,
    'isLiked': false,
    'date': '2 days ago',
  },
  {
    'id': 4,
    'userName': 'Jessica Parker',
    'userImage': Assets.personfilled,
    'rating': 4.5,
    'comment':
        'Beautiful coffee table that completes our living room. The glass top is easy to clean and the metal frame is very sturdy. Love it!',
    'likes': 18,
    'isLiked': false,
    'date': '1 week ago',
  },
];
