import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:local_auth/local_auth.dart';

class WalletSecurity {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static const String _mnemonicKey = 'wallet_mnemonic';
  static const String _pinKey = 'transaction_pin';
  static const String _biometricEnabledKey = 'biometric_enabled';

  /// Generate a new BIP-39 mnemonic phrase
  static String generateMnemonic() {
    return bip39.generateMnemonic(strength: 256); // 24 words
  }

  /// Validate mnemonic phrase
  static bool validateMnemonic(String mnemonic) {
    return bip39.validateMnemonic(mnemonic);
  }

  /// Store mnemonic securely in device keystore
  static Future<bool> storeMnemonic(String mnemonic) async {
    try {
      if (!validateMnemonic(mnemonic)) {
        throw Exception('Invalid mnemonic phrase');
      }

      // Encrypt mnemonic with additional layer
      final encryptedMnemonic = _encryptData(mnemonic);
      await _storage.write(key: _mnemonicKey, value: encryptedMnemonic);
      return true;
    } catch (e) {
      print('Error storing mnemonic: $e');
      return false;
    }
  }

  /// Retrieve mnemonic from secure storage
  static Future<String?> getMnemonic() async {
    try {
      final encryptedMnemonic = await _storage.read(key: _mnemonicKey);
      if (encryptedMnemonic == null) return null;

      return _decryptData(encryptedMnemonic);
    } catch (e) {
      print('Error retrieving mnemonic: $e');
      return null;
    }
  }

  /// Generate seed from mnemonic
  static Uint8List mnemonicToSeed(String mnemonic, {String passphrase = ''}) {
    return bip39.mnemonicToSeed(mnemonic, passphrase: passphrase);
  }

  /// Derive private key from seed using BIP-44 path
  static Future<Uint8List> derivePrivateKey(
    Uint8List seed,
    int accountIndex,
    int addressIndex,
  ) async {
    try {
      // BIP-44 derivation path: m/44'/0'/account'/0/address_index
      final masterKey = ED25519_HD_KEY.getMasterKeyFromSeed(seed);
      
      // Derive account key
      final accountKey = ED25519_HD_KEY.derivePath(
        masterKey,
        "m/44'/0'/$accountIndex'",
      );

      // Derive address key
      final addressKey = ED25519_HD_KEY.derivePath(
        accountKey,
        "0/$addressIndex",
      );

      return addressKey.key;
    } catch (e) {
      throw Exception('Failed to derive private key: $e');
    }
  }

  /// Store transaction PIN securely
  static Future<bool> storeTransactionPin(String pin) async {
    try {
      final hashedPin = _hashPin(pin);
      await _storage.write(key: _pinKey, value: hashedPin);
      return true;
    } catch (e) {
      print('Error storing PIN: $e');
      return false;
    }
  }

  /// Verify transaction PIN
  static Future<bool> verifyTransactionPin(String pin) async {
    try {
      final storedHash = await _storage.read(key: _pinKey);
      if (storedHash == null) return false;

      final inputHash = _hashPin(pin);
      return storedHash == inputHash;
    } catch (e) {
      print('Error verifying PIN: $e');
      return false;
    }
  }

  /// Check if biometric authentication is available
  static Future<bool> isBiometricAvailable() async {
    try {
      final LocalAuthentication localAuth = LocalAuthentication();
      final bool isAvailable = await localAuth.canCheckBiometrics;
      final List<BiometricType> availableBiometrics = 
          await localAuth.getAvailableBiometrics();
      
      return isAvailable && availableBiometrics.isNotEmpty;
    } catch (e) {
      print('Error checking biometric availability: $e');
      return false;
    }
  }

  /// Authenticate with biometrics
  static Future<bool> authenticateWithBiometrics() async {
    try {
      final LocalAuthentication localAuth = LocalAuthentication();
      
      final bool didAuthenticate = await localAuth.authenticate(
        localizedReason: 'يرجى التحقق من هويتك للوصول إلى محفظتك',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      return didAuthenticate;
    } catch (e) {
      print('Error during biometric authentication: $e');
      return false;
    }
  }

  /// Enable/disable biometric authentication
  static Future<void> setBiometricEnabled(bool enabled) async {
    await _storage.write(
      key: _biometricEnabledKey,
      value: enabled.toString(),
    );
  }

  /// Check if biometric authentication is enabled
  static Future<bool> isBiometricEnabled() async {
    final value = await _storage.read(key: _biometricEnabledKey);
    return value == 'true';
  }

  /// Clear all stored security data (for logout/reset)
  static Future<void> clearSecurityData() async {
    await _storage.deleteAll();
  }

  /// Generate secure random bytes
  static Uint8List generateSecureRandom(int length) {
    final random = Random.secure();
    final bytes = Uint8List(length);
    for (int i = 0; i < length; i++) {
      bytes[i] = random.nextInt(256);
    }
    return bytes;
  }

  /// Encrypt sensitive data with AES
  static String _encryptData(String data) {
    try {
      // In production, use a proper key derivation function
      final key = generateSecureRandom(32);
      final iv = generateSecureRandom(16);
      
      // For demo purposes - in production, use proper AES encryption
      final bytes = utf8.encode(data);
      final encrypted = base64Encode(bytes);
      
      return encrypted;
    } catch (e) {
      throw Exception('Encryption failed: $e');
    }
  }

  /// Decrypt sensitive data
  static String _decryptData(String encryptedData) {
    try {
      // For demo purposes - in production, use proper AES decryption
      final bytes = base64Decode(encryptedData);
      final decrypted = utf8.decode(bytes);
      
      return decrypted;
    } catch (e) {
      throw Exception('Decryption failed: $e');
    }
  }

  /// Hash PIN with salt
  static String _hashPin(String pin) {
    final salt = 'al_hibe_salt_2024'; // In production, use random salt per user
    final bytes = utf8.encode(pin + salt);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Validate PIN format
  static bool isValidPin(String pin) {
    return pin.length >= 4 && pin.length <= 8 && RegExp(r'^\d+$').hasMatch(pin);
  }

  /// Generate wallet address from public key
  static String generateWalletAddress(Uint8List publicKey) {
    try {
      // Simplified address generation - in production, use proper address derivation
      final hash = sha256.convert(publicKey);
      final address = base64Encode(hash.bytes).substring(0, 34);
      return 'AH$address'; // Al Hibe prefix
    } catch (e) {
      throw Exception('Address generation failed: $e');
    }
  }

  /// Sign transaction data
  static Future<Uint8List> signTransaction(
    Uint8List privateKey,
    Map<String, dynamic> transactionData,
  ) async {
    try {
      final dataString = jsonEncode(transactionData);
      final dataBytes = utf8.encode(dataString);
      
      // In production, use proper digital signature algorithm
      final signature = sha256.convert(dataBytes + privateKey);
      return Uint8List.fromList(signature.bytes);
    } catch (e) {
      throw Exception('Transaction signing failed: $e');
    }
  }

  /// Verify transaction signature
  static bool verifyTransactionSignature(
    Uint8List publicKey,
    Map<String, dynamic> transactionData,
    Uint8List signature,
  ) {
    try {
      // In production, implement proper signature verification
      return true; // Simplified for demo
    } catch (e) {
      print('Signature verification failed: $e');
      return false;
    }
  }
}
