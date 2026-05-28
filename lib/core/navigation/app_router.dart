import 'package:go_router/go_router.dart';
import 'package:portfolio/core/constant/route_name.dart';
import 'package:portfolio/features/home/home_page.dart';

class AppRouter {

  static const String home = '/home';

  static final router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: RouteName.home,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
