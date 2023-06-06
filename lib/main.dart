import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eventus/assets/app_color_palette.dart';
import 'package:eventus/assets/themes/app_theme.dart';
import 'package:eventus/screens/auth/auth_widget_three.dart';
import 'package:eventus/screens/home_screen.dart';
import 'package:eventus/screens/success_screen.dart';
import 'package:eventus/utlis/get_info_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'assets/configurations/firebase_options.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const EventusApp(),
  );
}

class EventusApp extends StatelessWidget {
  const EventusApp({super.key});

  static const String _title = 'EVENTUS';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TeAppThemeData.darkTheme,
      title: _title,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name!.startsWith('/success')) {
          // Extract the session ID and event name from the route
          final parameters = settings.name!.split('?')[1];
          final sessionId = parameters.split('&')[0].split('=')[1];
          final eventName = parameters.split('&')[1].split('=')[1];

          // Return the SuccessScreen widget with the extracted session ID and event name
          return MaterialPageRoute(
            builder: (_) => SuccessScreen(
                paymentSessionId: sessionId, eventName: eventName),
          );
        }

        // Handle other routes as needed
        return null;
      },
      routes: {
        '/': (_) => const SplashScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List screens = [
    const HomeScreen(),
    const AuthWidgetTree(),
  ];

  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ///////////////
  // MAIN CODE //
  ///////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('EVENTUS'),
        toolbarHeight: TeInformationUtil.getPercentageHeight(context, 8),
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: TeAppColorPalette.purple,
        items: const <Widget>[
          Icon(Icons.radar, size: 30),
          Icon(Icons.account_circle_rounded, size: 30),
        ],
        buttonBackgroundColor: TeAppColorPalette.black,
        index: _selectedIndex,
        onTap: _onTap,
      ),
    );
  }
}
