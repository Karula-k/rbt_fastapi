import 'package:barang_app/api/barang.dart';
import 'package:barang_app/pages/form_add_page.dart';
import 'package:barang_app/pages/form_edit_page.dart';
import 'package:barang_app/pages/welcome_page.dart';
import 'package:barang_app/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/api_helper.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ApiUserProvider>(
            create: (_) => ApiUserProvider(apiService: ApiService()))
      ],
      child: MaterialApp(initialRoute: WelcomePage.routeName, routes: {
        WelcomePage.routeName: (context) => const WelcomePage(),
        HomePage.routeName: (context) => const HomePage(),
        FormAddPage.routeName: (context) => const FormAddPage(),
        FormPage.routeName: (context) => FormPage(
              barang: ModalRoute.of(context)?.settings.arguments as Barang,
            ),
      }),
    );
  }
}
