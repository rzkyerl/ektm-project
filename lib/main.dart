// import 'package:ektm/pages/info_bayar_pages/info_bayar_pages.dart';
// import 'package:ektm/pages/login_pages.dart';
// import 'package:ektm/pages/main_wrapper.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart'; // ✅ Tambah ini

// import 'package:ektm/pages/ektm_pages/barcode_pages.dart';
// import 'package:ektm/pages/ektm_pages/scanner_pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Tambahkan ini
// import 'package:webview_flutter/webview_flutter.dart';
import 'pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:
            GoogleFonts.poppinsTextTheme(), // Gunakan Google Fonts di seluruh app
        scaffoldBackgroundColor:
            Colors.white, // Opsional: atur background global
      ),
      home: SplashScreen(),
      // routes: {
      //   '/main':
      //       (context) =>
      //           const MainWrapper(), // Tambahkan route untuk MainWrapper
      // },
    );
  }
}
