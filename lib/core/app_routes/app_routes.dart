
import 'package:get/get.dart';
import 'package:nearby_scan/Scann/scan_result.dart';

class AppRoute {
  static const String scanResultScreen = "/scanResultScreen";


  ///<================================================================================================================================>

  static List<GetPage> routes = [
     GetPage(name: scanResultScreen, page: () => const ScannResultScreen()),




  ];
}
