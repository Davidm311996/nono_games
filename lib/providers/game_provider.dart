import 'package:flutter/material.dart';
import '../models/game.dart';

class GameProvider extends ChangeNotifier {
  final Game game = Game(
    id: '1',
    name: 'NANO GAMES',
    description: 'A Faith-Based Strategic Card Game',
    longDescription:
        'NANO GAMES is a spiritually-inspired card game that brings Christian values to life through strategic gameplay. With 120+ beautifully crafted cards featuring biblical wisdom and virtues, players build faith-based strategies and engage in meaningful competition. Perfect for church groups, Christian families, and anyone seeking deeper spiritual connection through gaming.',
    price: 34.99,
    imageUrl: 'assets/Images/logo.jpg',
    features: [
      '120+ Faith-Inspired Cards',
      'Biblical Wisdom & Values',
      'Spiritual Growth Through Play',
      '2-4 Players',
      '30-60 Minutes per game',
      'Infinite Combinations',
      'Fast to Learn, Rewarding to Master',
      'Perfect for Christian Communities'
    ],
    category: 'Faith-Based Strategy Game',
    playerCount: 4,
    playTimeMinutes: 45,
    rating: 4.9,
  );

  int _currentCardIndex = 0;

  int get currentCardIndex => _currentCardIndex;

  void nextCard() {
    _currentCardIndex = (_currentCardIndex + 1) % 120;
    notifyListeners();
  }

  void previousCard() {
    _currentCardIndex = (_currentCardIndex - 1 + 120) % 120;
    notifyListeners();
  }

  void goToCard(int index) {
    _currentCardIndex = index % 120;
    notifyListeners();
  }

  String getCardImagePath(int cardNumber) {
    // Map to image format - cards are numbered 1-120
    final imageNum = cardNumber + 1;
    return 'assets/Images/1 ENGLISH CARD VERSION-images-$imageNum.jpg';
  }
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get total => _items.fold(0, (sum, item) => sum + item.total);

  int get itemCount => _items.length;

  void addToCart(Game game) {
    final existingItem = _items.firstWhere(
      (item) => item.game.id == game.id,
      orElse: () => CartItem(game: game, quantity: 0),
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity++;
    } else {
      _items.add(CartItem(game: game, quantity: 1));
    }
    notifyListeners();
  }

  void removeFromCart(String gameId) {
    _items.removeWhere((item) => item.game.id == gameId);
    notifyListeners();
  }

  void updateQuantity(String gameId, int quantity) {
    final item = _items.firstWhere((item) => item.game.id == gameId);
    if (quantity > 0) {
      item.quantity = quantity;
    } else {
      removeFromCart(gameId);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

class UserProvider extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  void login(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void updateProfile(String name, String profileImage) {
    if (_currentUser != null) {
      _currentUser = User(
        id: _currentUser!.id,
        email: _currentUser!.email,
        name: name,
        profileImage: profileImage,
      );
      notifyListeners();
    }
  }
}
