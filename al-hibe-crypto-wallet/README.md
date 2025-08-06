# Al Hibe (الهيبة) - Cryptocurrency Wallet & Trading App

A professional, secure cryptocurrency wallet and trading application built with Flutter, featuring Arabic RTL support, biometric authentication, and modern UI design inspired by Binance.

## 🚀 Features

### Core Features
- **Multi-language Support**: Arabic (RTL) and English
- **Firebase Authentication**: Email/Password, Google, Facebook
- **Biometric Security**: Fingerprint and Face ID authentication
- **Hot Wallet Integration**: On-device wallet system with BIP-39 mnemonic
- **Transaction PIN**: Additional security layer for transactions
- **Dark Mode UI**: Black and gold themed interface

### Wallet Features
- **Send/Receive Coins**: QR code integration for easy transfers
- **Live Crypto Prices**: Real-time market data
- **Transaction History**: Encrypted local storage
- **Multiple Cryptocurrencies**: Support for various digital assets
- **Secure Key Storage**: Hardware-backed keystore integration

### Trading Features
- **Buy/Sell Interface**: Simple trading interface
- **Live Order Book**: Real-time market depth
- **Price Charts**: Interactive trading charts
- **Price Alerts**: Push notifications for price movements

### Security Features
- **BIP-39 Mnemonic**: Industry-standard wallet recovery
- **AES-256 Encryption**: Military-grade data encryption
- **Secure Storage**: Platform keystore integration
- **Transaction Signing**: Cryptographic transaction verification

## 🛠 Tech Stack

### Framework & Language
- **Flutter 3.x**: Cross-platform mobile development
- **Dart**: Programming language
- **Material Design 3**: Modern UI components

### State Management
- **Riverpod**: Reactive state management
- **Riverpod Generator**: Code generation for providers

### Backend & Authentication
- **Firebase Core**: Backend infrastructure
- **Firebase Auth**: User authentication
- **Firebase Messaging**: Push notifications
- **Cloud Firestore**: Cloud database

### Security & Crypto
- **Flutter Secure Storage**: Encrypted local storage
- **Local Auth**: Biometric authentication
- **BIP-39**: Mnemonic phrase generation
- **ED25519 HD Key**: Hierarchical deterministic keys
- **Crypto**: Cryptographic operations

### UI & UX
- **Flutter SVG**: Vector graphics
- **Lottie**: Animations
- **FL Chart**: Interactive charts
- **QR Code Scanner**: QR code functionality

## 📁 Project Structure

```
al-hibe-crypto-wallet/
├── lib/
│   ├── core/                          # Core functionality
│   │   ├── constants/                 # App constants
│   │   ├── security/                  # Security utilities
│   │   │   └── wallet_security.dart   # Wallet security functions
│   │   ├── theme/                     # App theming
│   │   │   └── app_theme.dart         # Dark/Gold theme
│   │   └── network/                   # API clients
│   ├── features/                      # Feature modules
│   │   ├── auth/                      # Authentication
│   │   │   ├── data/                  # Data layer
│   │   │   ├── domain/                # Business logic
│   │   │   └── presentation/          # UI layer
│   │   │       ├── screens/
│   │   │       │   └── login_screen.dart
│   │   │       └── widgets/
│   │   │           ├── auth_button.dart
│   │   │           ├── custom_text_field.dart
│   │   │           └── social_login_button.dart
│   │   ├── wallet/                    # Wallet management
│   │   ├── trading/                   # Trading features
│   │   ├── transactions/              # Transaction history
│   │   └── settings/                  # App settings
│   ├── shared/                        # Shared components
│   │   ├── widgets/                   # Reusable widgets
│   │   └── utils/                     # Utility functions
│   └── main.dart                      # App entry point
├── assets/                            # Static assets
│   ├── images/                        # Image files
│   ├── animations/                    # Lottie animations
│   ├── fonts/                         # Custom fonts
│   └── icons/                         # App icons
├── android/                           # Android configuration
├── ios/                               # iOS configuration
└── pubspec.yaml                       # Dependencies
```

## 🔧 Setup Instructions

### Prerequisites
- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)
- Android Studio / Xcode
- Firebase project setup

### 1. Clone the Repository
```bash
git clone <repository-url>
cd al-hibe-crypto-wallet
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Firebase Setup

#### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project named "Al Hibe"
3. Enable Authentication, Firestore, and Cloud Messaging

#### Android Setup
1. Add Android app to Firebase project
2. Download `google-services.json`
3. Place in `android/app/` directory
4. Update `android/build.gradle` and `android/app/build.gradle`

#### iOS Setup
1. Add iOS app to Firebase project
2. Download `GoogleService-Info.plist`
3. Add to `ios/Runner/` in Xcode
4. Update `ios/Runner/Info.plist`

### 4. Configure Authentication Providers

#### Google Sign-In
```bash
# Add SHA-1 fingerprint to Firebase
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

#### Facebook Login
1. Create Facebook App
2. Add Facebook App ID to Firebase
3. Configure OAuth redirect URLs

### 5. Environment Configuration
Create `.env` file in project root:
```env
# API Keys (DO NOT COMMIT TO VERSION CONTROL)
FIREBASE_API_KEY=your_firebase_api_key
GOOGLE_CLIENT_ID=your_google_client_id
FACEBOOK_APP_ID=your_facebook_app_id

# Crypto API
CRYPTO_API_BASE_URL=https://api.coingecko.com/api/v3
TRADING_API_URL=https://api.binance.com/api/v3

# App Configuration
APP_NAME=Al Hibe
APP_VERSION=1.0.0
ENVIRONMENT=development
```

### 6. Generate Code
```bash
# Generate Riverpod providers
flutter packages pub run build_runner build

# Generate localization files
flutter gen-l10n
```

### 7. Run the App
```bash
# Debug mode
flutter run

# Release mode
flutter run --release
```

## 🔐 Security Best Practices

### Wallet Security
- **Never store private keys in plain text**
- **Use hardware-backed keystore when available**
- **Implement proper key derivation (BIP-44)**
- **Encrypt all sensitive data with AES-256**
- **Use secure random number generation**

### Authentication Security
- **Implement biometric authentication**
- **Use transaction PINs for sensitive operations**
- **Enable Firebase App Check**
- **Implement proper session management**

### Data Protection
- **Encrypt local database**
- **Use certificate pinning for API calls**
- **Implement proper backup strategies**
- **Regular security audits**

## 🌍 Localization

### Supported Languages
- **Arabic (ar)**: Primary language with RTL support
- **English (en)**: Secondary language

### Adding New Languages
1. Create new `.arb` file in `lib/l10n/`
2. Add translations for all keys
3. Update `supportedLocales` in `main.dart`
4. Run `flutter gen-l10n`

## 📱 Platform-Specific Features

### Android
- **Biometric Prompt API**: Modern biometric authentication
- **Android Keystore**: Hardware-backed key storage
- **Scoped Storage**: Secure file access
- **Background Restrictions**: Optimized for battery life

### iOS
- **Touch ID / Face ID**: Native biometric authentication
- **Keychain Services**: Secure credential storage
- **App Transport Security**: Secure network communications
- **Background App Refresh**: Optimized background processing

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter test integration_test/
```

### Security Testing
- **Static Analysis**: `flutter analyze`
- **Dependency Check**: `flutter pub deps`
- **Security Audit**: Regular third-party security reviews

## 🚀 Deployment

### Android Deployment
1. Generate signed APK/AAB
2. Upload to Google Play Console
3. Configure app signing
4. Set up staged rollout

### iOS Deployment
1. Archive in Xcode
2. Upload to App Store Connect
3. Configure TestFlight
4. Submit for review

## 📊 Performance Optimization

### App Performance
- **Lazy loading**: Load data on demand
- **Image caching**: Efficient image management
- **Memory management**: Proper disposal of resources
- **Background processing**: Optimize background tasks

### Security Performance
- **Biometric caching**: Reduce authentication frequency
- **Key derivation optimization**: Efficient cryptographic operations
- **Secure storage optimization**: Fast encrypted data access

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:
- **Email**: support@alhibe.com
- **Documentation**: [docs.alhibe.com](https://docs.alhibe.com)
- **Community**: [community.alhibe.com](https://community.alhibe.com)

## 🔄 Changelog

### Version 1.0.0
- Initial release
- Basic wallet functionality
- Firebase authentication
- Biometric security
- Arabic RTL support
- Dark mode UI

---

**Al Hibe (الهيبة)** - Your Secure Digital Wallet
