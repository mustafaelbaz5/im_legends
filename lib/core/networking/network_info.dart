import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Network Information Interface
/// Provides network connectivity status
abstract class NetworkInfo {
  /// Checks if device is connected to internet
  Future<bool> get isConnected;

  /// Stream of connectivity changes
  Stream<InternetConnectionStatus> get onStatusChange;
}

/// Implementation of NetworkInfo using internet_connection_checker
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  Stream<InternetConnectionStatus> get onStatusChange =>
      connectionChecker.onStatusChange;
}
