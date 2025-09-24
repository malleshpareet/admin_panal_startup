import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:provider/provider.dart';
import '../../screens/main/main_screen.dart';
import '../../screens/login/login_screen.dart';
import '../../screens/login/provider/login_provider.dart';

class AppPages {
  static const HOME = '/';
  static const LOGIN = '/login';

  static final routes = [
    GetPage(name: HOME, fullscreenDialog: true, page: () => MainScreen()),
    GetPage(
        name: LOGIN,
        fullscreenDialog: true,
        page: () => ChangeNotifierProvider(
              create: (_) => LoginProvider(),
              child: LoginScreen(),
            )),
  ];
}
