# 🔐 Al Hibe Security Guide

## Critical Security Implementation Tips

### 1. Private Key Management

#### ✅ DO:
```dart
// Store mnemonic in hardware-backed keystore
await WalletSecurity.storeMnemonic(mnemonic);

// Derive keys on-demand, never store private keys
final privateKey = await WalletSecurity.derivePrivateKey(seed, 0, 0);

// Clear sensitive data from memory immediately
privateKey.fillRange(0, privateKey.length, 0);
```

#### ❌ DON'T:
```dart
// NEVER store private keys in SharedPreferences
SharedPreferences.setString('private_key', privateKey); // DANGEROUS!

// NEVER log sensitive data
print('Private key: $privateKey'); // SECURITY RISK!

// NEVER store keys in plain text files
File('wallet.txt').writeAsString(privateKey); // CRITICAL VULNERABILITY!
```

### 2. Secure Storage Implementation

#### Production-Ready Secure Storage:
```dart
class SecureWalletStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
      synchronizable: false, // Never sync to iCloud
    ),
  );

  // Use unique salt per user
  static String _generateUserSalt(String userId) {
    return sha256.convert(utf8.encode('$userId-salt-2024')).toString();
  }

  // Proper AES encryption implementation
  static Future<String> encryptData(String data, String userSalt) async {
    final key = Key.fromSecureRandom(32);
    final iv = IV.fromSecureRandom(16);
    final encrypter = Encrypter(AES(key));
    
    final encrypted = encrypter.encrypt(data, iv: iv);
    
    // Store key securely in keystore
    await _storage.write(
      key: 'encryption_key_$userSalt',
      value: key.base64,
    );
    
    return '${iv.base64}:${encrypted.base64}';
  }
}
```

### 3. Transaction Security

#### Secure Transaction Signing:
```dart
class TransactionSecurity {
  // Verify transaction before signing
  static Future<bool> verifyTransaction(Transaction tx) async {
    // Check balance
    if (tx.amount > await getWalletBalance()) {
      throw InsufficientBalanceException();
    }
    
    // Validate recipient address
    if (!isValidAddress(tx.recipientAddress)) {
      throw InvalidAddressException();
    }
    
    // Check daily limits
    if (await getDailyTransactionAmount() + tx.amount > AppConstants.maxDailyTransactionAmount) {
      throw DailyLimitExceededException();
    }
    
    return true;
  }

  // Multi-factor authentication for transactions
  static Future<bool> authenticateTransaction(Transaction tx) async {
    // 1. PIN verification
    final pinValid = await WalletSecurity.verifyTransactionPin(userPin);
    if (!pinValid) return false;
    
    // 2. Biometric verification for large amounts
    if (tx.amount > 1000) {
      final biometricValid = await WalletSecurity.authenticateWithBiometrics();
      if (!biometricValid) return false;
    }
    
    // 3. Time-based verification for suspicious activity
    if (await isSuspiciousActivity(tx)) {
      return await requestAdditionalVerification();
    }
    
    return true;
  }
}
```

### 4. Network Security

#### Certificate Pinning:
```dart
class SecureHttpClient {
  static Dio createSecureClient() {
    final dio = Dio();
    
    // Certificate pinning
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (cert, host, port) {
        // Verify certificate fingerprint
        final certSha256 = sha256.convert(cert.der).toString();
        return _trustedCertificates.contains(certSha256);
      };
      return client;
    };
    
    // Request/Response interceptors
    dio.interceptors.add(SecurityInterceptor());
    
    return dio;
  }
  
  static const List<String> _trustedCertificates = [
    'sha256_fingerprint_of_your_api_server',
    // Add backup certificates
  ];
}
```

### 5. Biometric Security Best Practices

#### Secure Biometric Implementation:
```dart
class BiometricSecurity {
  static Future<bool> authenticateWithFallback() async {
    try {
      // Check if biometric is available and enrolled
      final isAvailable = await LocalAuthentication().canCheckBiometrics;
      final availableBiometrics = await LocalAuthentication().getAvailableBiometrics();
      
      if (!isAvailable || availableBiometrics.isEmpty) {
        // Fallback to PIN
        return await _authenticateWithPin();
      }
      
      // Attempt biometric authentication
      final authenticated = await LocalAuthentication().authenticate(
        localizedReason: AppConstants.biometricReason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      
      if (!authenticated) {
        // Fallback to PIN after failed biometric
        return await _authenticateWithPin();
      }
      
      return true;
    } catch (e) {
      // Always have a fallback
      return await _authenticateWithPin();
    }
  }
  
  static Future<bool> _authenticateWithPin() async {
    // Implement secure PIN entry with rate limiting
    final attempts = await getFailedAttempts();
    if (attempts >= AppConstants.maxLoginAttempts) {
      throw AccountLockedException();
    }
    
    // Show PIN entry dialog
    final pin = await showPinEntryDialog();
    final isValid = await WalletSecurity.verifyTransactionPin(pin);
    
    if (!isValid) {
      await incrementFailedAttempts();
    } else {
      await resetFailedAttempts();
    }
    
    return isValid;
  }
}
```

### 6. Data Protection & Privacy

#### Secure Data Handling:
```dart
class DataProtection {
  // Encrypt sensitive user data
  static Future<void> storeUserData(UserData userData) async {
    final encryptedData = await encryptUserData(userData);
    await SecureStorage.store('user_data', encryptedData);
  }
  
  // Implement data retention policies
  static Future<void> cleanupOldData() async {
    final cutoffDate = DateTime.now().subtract(Duration(days: 90));
    await TransactionHistory.deleteOlderThan(cutoffDate);
    await LogFiles.deleteOlderThan(cutoffDate);
  }
  
  // Secure data export for backup
  static Future<String> exportWalletBackup(String userPassword) async {
    final walletData = await getWalletData();
    final encryptedBackup = await encryptWithUserPassword(walletData, userPassword);
    
    // Add integrity check
    final checksum = sha256.convert(utf8.encode(encryptedBackup)).toString();
    
    return jsonEncode({
      'version': '1.0',
      'timestamp': DateTime.now().toIso8601String(),
      'data': encryptedBackup,
      'checksum': checksum,
    });
  }
}
```

### 7. Runtime Security

#### App Integrity Checks:
```dart
class RuntimeSecurity {
  static Future<void> performSecurityChecks() async {
    // Check if device is rooted/jailbroken
    if (await isDeviceCompromised()) {
      throw DeviceCompromisedException();
    }
    
    // Verify app signature
    if (!await verifyAppSignature()) {
      throw AppTamperedException();
    }
    
    // Check for debugging/reverse engineering tools
    if (await isDebuggingDetected()) {
      throw DebuggingDetectedException();
    }
    
    // Verify app wasn't installed from unknown sources
    if (!await isInstalledFromTrustedSource()) {
      throw UntrustedSourceException();
    }
  }
  
  // Obfuscate sensitive operations
  static Future<void> performSensitiveOperation() async {
    // Add random delays to prevent timing attacks
    await Future.delayed(Duration(milliseconds: Random().nextInt(100) + 50));
    
    // Perform actual operation
    await _actualSensitiveOperation();
    
    // Clear sensitive data from memory
    _clearSensitiveMemory();
  }
}
```

### 8. Secure Communication

#### API Security:
```dart
class ApiSecurity {
  static Future<Response> secureApiCall(String endpoint, Map<String, dynamic> data) async {
    // Add request timestamp
    data['timestamp'] = DateTime.now().millisecondsSinceEpoch;
    
    // Create request signature
    final signature = await createRequestSignature(data);
    
    final response = await dio.post(
      endpoint,
      data: data,
      options: Options(
        headers: {
          'X-Signature': signature,
          'X-Timestamp': data['timestamp'].toString(),
          'X-App-Version': AppConstants.appVersion,
        },
      ),
    );
    
    // Verify response signature
    if (!await verifyResponseSignature(response)) {
      throw ResponseTamperedException();
    }
    
    return response;
  }
  
  static Future<String> createRequestSignature(Map<String, dynamic> data) async {
    final apiSecret = await SecureStorage.get('api_secret');
    final dataString = jsonEncode(data);
    final signature = Hmac(sha256, utf8.encode(apiSecret)).convert(utf8.encode(dataString));
    return signature.toString();
  }
}
```

## 🚨 Critical Security Checklist

### Before Production Deployment:

- [ ] **Remove all debug logs and print statements**
- [ ] **Enable certificate pinning for all API calls**
- [ ] **Implement proper key rotation mechanism**
- [ ] **Add tamper detection and response**
- [ ] **Enable Firebase App Check**
- [ ] **Implement rate limiting for sensitive operations**
- [ ] **Add comprehensive error handling without information leakage**
- [ ] **Perform security penetration testing**
- [ ] **Code obfuscation for release builds**
- [ ] **Implement secure backup and recovery**

### Ongoing Security Maintenance:

- [ ] **Regular security audits**
- [ ] **Monitor for new vulnerabilities in dependencies**
- [ ] **Update cryptographic libraries regularly**
- [ ] **Implement security incident response plan**
- [ ] **Regular backup testing**
- [ ] **Monitor for suspicious user activity**
- [ ] **Keep security documentation updated**

## 🔍 Security Testing

### Automated Security Tests:
```dart
// Example security test
testWidgets('Sensitive data should not be logged', (tester) async {
  // Capture all log output
  final logs = <String>[];
  debugPrint = (String? message, {int? wrapWidth}) {
    logs.add(message ?? '');
  };
  
  // Perform operations that handle sensitive data
  await performWalletOperations();
  
  // Verify no sensitive data was logged
  for (final log in logs) {
    expect(log, isNot(contains(RegExp(r'private.*key', caseSensitive: false))));
    expect(log, isNot(contains(RegExp(r'mnemonic', caseSensitive: false))));
    expect(log, isNot(contains(RegExp(r'password', caseSensitive: false))));
  }
});
```

## 📞 Security Incident Response

If you discover a security vulnerability:

1. **DO NOT** create a public issue
2. Email security@alhibe.com with details
3. Include steps to reproduce
4. Allow reasonable time for response
5. Follow responsible disclosure practices

---

**Remember: Security is not a feature, it's a foundation. Every line of code should be written with security in mind.**
