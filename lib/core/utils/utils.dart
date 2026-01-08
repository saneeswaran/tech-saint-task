import 'package:connectivity_plus/connectivity_plus.dart';

class Utils {
  //check internet connection

  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.ethernet ||
        connectivityResult == ConnectivityResult.vpn ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
