import "package:internet_connection_checker_plus/internet_connection_checker_plus.dart";

abstract interface class NetworkConnectivity {
  Future<bool> get isConnected;
}

class INetworkConnectivity implements NetworkConnectivity {
  final InternetConnection _internetConnection;
  INetworkConnectivity({required InternetConnection connection})
      : _internetConnection = connection;

  @override
  Future<bool> get isConnected async => _internetConnection.hasInternetAccess;
}
