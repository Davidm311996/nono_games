class Game {
  final String id;
  final String name;
  final String description;
  final String longDescription;
  final double price;
  final String imageUrl;
  final List<String> features;
  final String category;
  final int playerCount;
  final int playTimeMinutes;
  final double rating;

  Game({
    required this.id,
    required this.name,
    required this.description,
    required this.longDescription,
    required this.price,
    required this.imageUrl,
    required this.features,
    required this.category,
    required this.playerCount,
    required this.playTimeMinutes,
    required this.rating,
  });
}

class User {
  final String id;
  final String email;
  final String name;
  final String profileImage;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.profileImage,
  });
}

class CartItem {
  final Game game;
  int quantity;

  CartItem({
    required this.game,
    required this.quantity,
  });

  double get total => game.price * quantity;
}
