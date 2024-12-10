import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  // 初始化窗口管理器
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    WindowOptions windowOptions = WindowOptions(
      title: "新的标题", // 修改标题
      size: const Size(800, 600), // 设置窗口默认大小
      maximumSize: const Size(800, 600), // 设置窗口最大大小
      minimumSize: const Size(800, 600), // 设置窗口最小大小
      // resizable: false, // 禁止通过拖动调整窗口大小
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '游戏存档管理工具',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            // backgroundColor: Colors.blueAccent,
            labelType: NavigationRailLabelType.all,
            elevation: 20,
            leading: Container(
              color: Colors.transparent,
              child: SvgPicture.asset(
                'assets/svg/logo.svg',
                width: 80,
                height: 80,
              ),
            ),
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                selectedIcon: Icon(Icons.home_filled),
                label: Text("Home"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.star),
                selectedIcon: Icon(Icons.star_rate),
                label: Text('Favorites'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                selectedIcon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: Center(
              child: Text(
                'Selected Index: $_selectedIndex',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
