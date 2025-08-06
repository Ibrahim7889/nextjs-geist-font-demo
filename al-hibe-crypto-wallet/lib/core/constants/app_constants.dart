class AppConstants {
  // App Information
  static const String appName = 'Al Hibe';
  static const String appNameArabic = 'الهيبة';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'محفظتك الرقمية الآمنة';

  // API Endpoints
  static const String cryptoApiBaseUrl = 'https://api.coingecko.com/api/v3';
  static const String tradingApiUrl = 'https://api.binance.com/api/v3';
  
  // Supported Cryptocurrencies
  static const List<String> supportedCryptos = [
    'bitcoin',
    'ethereum',
    'binancecoin',
    'cardano',
    'solana',
    'polkadot',
    'chainlink',
    'litecoin',
  ];

  // Wallet Configuration
  static const int defaultDerivationIndex = 0;
  static const String walletAddressPrefix = 'AH'; // Al Hibe prefix
  static const int minPinLength = 4;
  static const int maxPinLength = 8;
  static const int mnemonicWordCount = 24;

  // Security Settings
  static const int maxLoginAttempts = 5;
  static const int lockoutDurationMinutes = 15;
  static const int sessionTimeoutMinutes = 30;
  static const int biometricTimeoutSeconds = 30;

  // Transaction Limits
  static const double minTransactionAmount = 0.00000001; // 1 satoshi
  static const double maxDailyTransactionAmount = 10000.0;
  static const int maxTransactionsPerDay = 50;

  // UI Configuration
  static const double borderRadius = 12.0;
  static const double cardElevation = 4.0;
  static const int animationDurationMs = 300;
  static const int splashScreenDurationMs = 3000;

  // Notification Types
  static const String notificationTypeTransaction = 'transaction';
  static const String notificationTypePriceAlert = 'price_alert';
  static const String notificationTypeSystem = 'system';
  static const String notificationTypeSecurity = 'security';

  // Storage Keys
  static const String keyUserPreferences = 'user_preferences';
  static const String keyWalletData = 'wallet_data';
  static const String keyTransactionHistory = 'transaction_history';
  static const String keyPriceAlerts = 'price_alerts';
  static const String keySecuritySettings = 'security_settings';

  // Error Messages
  static const String errorNetworkConnection = 'لا يوجد اتصال بالإنترنت';
  static const String errorInvalidCredentials = 'بيانات الدخول غير صحيحة';
  static const String errorTransactionFailed = 'فشل في إرسال المعاملة';
  static const String errorInsufficientBalance = 'الرصيد غير كافي';
  static const String errorInvalidAddress = 'عنوان المحفظة غير صالح';

  // Success Messages
  static const String successLoginCompleted = 'تم تسجيل الدخول بنجاح';
  static const String successTransactionSent = 'تم إرسال المعاملة بنجاح';
  static const String successWalletCreated = 'تم إنشاء المحفظة بنجاح';
  static const String successBackupCompleted = 'تم حفظ النسخة الاحتياطية';

  // Regex Patterns
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phonePattern = r'^\+?[1-9]\d{1,14}$';
  static const String pinPattern = r'^\d{4,8}$';
  static const String walletAddressPattern = r'^AH[A-Za-z0-9]{32,}$';

  // Chart Configuration
  static const int chartDataPoints = 100;
  static const List<String> chartTimeframes = ['1H', '4H', '1D', '1W', '1M'];
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Cache Configuration
  static const int cacheExpirationHours = 1;
  static const int maxCacheSize = 50; // MB

  // Biometric Configuration
  static const String biometricReason = 'يرجى التحقق من هويتك للوصول إلى محفظتك';
  static const String biometricReasonTransaction = 'يرجى التحقق من هويتك لتأكيد المعاملة';

  // Deep Link Configuration
  static const String deepLinkScheme = 'alhibe';
  static const String deepLinkHost = 'wallet';

  // Social Media Links
  static const String websiteUrl = 'https://alhibe.com';
  static const String supportEmail = 'support@alhibe.com';
  static const String telegramUrl = 'https://t.me/alhibe';
  static const String twitterUrl = 'https://twitter.com/alhibe';

  // Feature Flags
  static const bool enableBiometricAuth = true;
  static const bool enablePushNotifications = true;
  static const bool enablePriceAlerts = true;
  static const bool enableTradingFeatures = true;
  static const bool enableMultiWallet = false; // Future feature

  // Development Configuration
  static const bool isDebugMode = true; // Set to false in production
  static const bool enableLogging = true;
  static const bool enableCrashReporting = true;
}
