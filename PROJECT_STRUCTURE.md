# Project Structure - Nano Games Website

This is now a **web-only Flutter project**. All platform-specific folders have been removed.

## 📁 Clean Folder Structure

```
nono_games/
├── lib/                          # Dart source code
│   ├── main.dart                # App entry point
│   ├── models/
│   │   └── game.dart            # Data models (Game, User, CartItem)
│   ├── providers/
│   │   └── game_provider.dart   # State management (GameProvider, CartProvider, UserProvider)
│   └── pages/
│       ├── home_page.dart       # Landing page
│       ├── shop_page.dart       # Games catalog
│       ├── game_details_page.dart # Game detail view
│       ├── cart_page.dart       # Shopping cart
│       └── account_page.dart    # User account
│
├── web/                         # Web-specific files
│   ├── index.html              # HTML entry point
│   ├── favicon.png             # Website favicon
│   ├── manifest.json           # Web app manifest
│   └── icons/                  # Web icons
│
├── assets/                      # Static assets
│   ├── games/                  # Game images (add your game images here)
│   └── icons/                  # Custom icons and logos
│
├── public/                      # Static web files (optional)
│
├── test/                        # Unit and widget tests
│   └── widget_test.dart
│
├── build/                       # Build output (auto-generated)
│
├── pubspec.yaml                # Project configuration
├── pubspec.lock                # Dependency lock file
├── analysis_options.yaml       # Dart lint rules
├── README.md                   # Original project README
├── WEBSITE_README.md           # Website-specific documentation
└── nono_games.iml             # IDE project file
```

## 🗑️ Removed Folders

✓ **android/** - Android app resources  
✓ **ios/** - iOS app resources  
✓ **linux/** - Linux desktop resources  
✓ **macos/** - macOS desktop resources  
✓ **windows/** - Windows desktop resources  

These platform-specific folders are no longer needed since this is a **web-only project**.

## ✨ Updated Configuration

The `pubspec.yaml` has been updated to:
- Update project description to reflect it's a website
- Remove platform-specific build comments
- Add assets configuration for the new `assets/` folder

## 📦 How to Use the New Folders

### `assets/games/`
Store all your game card images here:
```
assets/games/
├── cosmic-card-battle.jpg
├── legends-of-nano.jpg
└── nano-racing.jpg
```

Then reference them in your game data:
```dart
imageUrl: 'assets/games/cosmic-card-battle.jpg'
```

### `assets/icons/`
Store custom icons and logos:
```
assets/icons/
├── logo.svg
├── logo.png
└── banner.jpg
```

### `web/`
Web-specific configuration and files. Don't modify unless you need to customize the HTML or add web-specific resources.

### `public/`
Use this for serving static files if you deploy the website (robots.txt, sitemap.xml, etc.).

## 🚀 Building & Running

The project works exactly as before:

```bash
# Run locally
flutter run -d chrome

# Build for production
flutter build web --release

# Deploy the `build/web/` folder to your hosting service
```

## ✅ Project Status

✓ All platform files removed  
✓ Clean web project structure  
✓ Project builds successfully  
✓ Ready for web deployment  

Your Nano Games website is now optimized for web development! 🎮
