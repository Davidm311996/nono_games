# Nano Games - Interactive E-Commerce Website

An interactive Flutter-based e-commerce website for selling card games. Built for the web platform with a modern, responsive design.

## Features

✨ **Shop & Browse**
- Interactive game catalog with filtering
- Search functionality  
- Category-based browsing
- Detailed game information pages

✨ **Shopping Cart**
- Add/remove games from cart
- Adjust quantities
- Real-time price calculation
- Checkout flow

✨ **User Accounts**
- Login/logout functionality
- User profile management
- Order history tracking
- Account settings

✨ **Responsive Design**
- Works on desktop, tablet, and mobile
- Beautiful gradient UI with Material Design
- Smooth navigation between pages

## Project Structure

```
lib/
├── main.dart                 # App entry point and navigation
├── models/
│   └── game.dart            # Game, User, CartItem data models
├── providers/
│   └── game_provider.dart   # Business logic and state management
└── pages/
    ├── home_page.dart       # Landing page with featured games
    ├── shop_page.dart       # Games catalog with filters
    ├── game_details_page.dart # Detailed game information
    ├── cart_page.dart       # Shopping cart management
    └── account_page.dart    # User account and profile
```

## Getting Started

### Prerequisites
- Flutter 3.9.2+
- Dart SDK

### Installation

1. Navigate to the project directory:
```bash
cd nono_games
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app (web):
```bash
flutter run -d chrome
```

Or run on other platforms:
```bash
flutter run -d macos      # macOS desktop
flutter run -d linux      # Linux desktop
flutter run -d windows    # Windows desktop
```

## Customization Guide

### Adding Your Games

Edit `lib/providers/game_provider.dart` and add your games to the `_games` list:

```dart
Game(
  id: '4',
  name: 'Your Game Name',
  description: 'Short description',
  longDescription: 'Detailed description...',
  price: 29.99,
  imageUrl: 'https://your-image-url.com/image.jpg',
  features: [
    'Feature 1',
    'Feature 2',
    'Feature 3',
  ],
  category: 'Your Category',
  playerCount: 4,
  playTimeMinutes: 45,
  rating: 4.5,
)
```

### Customizing Appearance

- **Colors**: Edit the theme in `lib/main.dart` (currently using deep purple)
- **Brand Name**: Change 'NANO GAMES' in `lib/pages/home_page.dart`
- **Logo**: Add your logo to `web/icons/` and update `web/index.html`

### Adding Game Images

1. Create a `web/assets/games/` directory
2. Add your game images
3. Update the `imageUrl` in the game data to point to your local assets:
```dart
imageUrl: 'assets/games/your-game.jpg',
```

### Integrating Payment Processing

In `lib/pages/cart_page.dart`, replace the checkout button's `onPressed` handler with your payment gateway integration (Stripe, PayPal, etc.):

```dart
onPressed: () {
  // Integrate with your payment provider here
  // Example: Stripe.instance.confirmPaymentIntent(...)
}
```

## Pages Overview

### Home Page
- Landing page with hero section
- Featured games showcase
- Why choose us section
- Call-to-action button to shop

### Shop Page
- Full game catalog
- Category filters
- Search functionality
- Add to cart buttons
- Cart badge showing items count

### Game Details Page
- Large game image
- Complete game information
- Features list
- Player count and play time
- Customer rating
- Add to cart button

### Cart Page
- List of items in cart
- Quantity adjustment controls
- Item removal
- Cart summary with totals
- Checkout button

### Account Page
- User profile information
- Profile editing
- Order history (placeholder)
- Logout functionality
- Login dialog for non-authenticated users

## State Management

The app uses the `provider` package for state management with three main providers:

- **GameProvider**: Manages game data and catalog
- **CartProvider**: Handles shopping cart operations
- **UserProvider**: Manages user authentication and profile

## Building for Production

To build for web deployment:

```bash
flutter build web --release
```

The build files will be in `build/web/`. You can deploy these to any static hosting service (Firebase Hosting, Netlify, Vercel, etc.).

## Testing

Run the widget tests:

```bash
flutter test
```

## Future Enhancements

- [ ] Payment gateway integration
- [ ] User authentication backend
- [ ] Order tracking system
- [ ] Game reviews and ratings
- [ ] Wishlist functionality
- [ ] Email notifications
- [ ] Mobile app version
- [ ] Admin dashboard for inventory management

## License

This project is private and intended for personal use.

---

For questions or support, contact the development team.
