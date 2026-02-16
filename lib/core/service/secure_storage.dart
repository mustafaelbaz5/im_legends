import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  const SecureStorage(this._storage);

  final FlutterSecureStorage _storage;

  Future<void> write({
    required final String key,
    required final String value,
  }) => _storage.write(key: key, value: value);

  Future<String?> read({required final String key}) => _storage.read(key: key);

  Future<void> delete({required final String key}) => _storage.delete(key: key);

  Future<void> clearAll() => _storage.deleteAll();
}
