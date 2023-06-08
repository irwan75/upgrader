// Copyright (c) 2023 Larry Aasen. All rights reserved.

import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Only call clearSavedSettings() during testing to reset internal values.
  await Upgrader.clearSavedSettings(); // REMOVE this for release builds

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _testState = 0;
  Upgrader? _upgrader;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      appBar: AppBar(title: Text('Upgrader Driver App')),
      body: Center(
          child: Column(
        children: [
          SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () async {
              await Upgrader.clearSavedSettings();
              _upgrader = Upgrader();
              setState(() => _testState = 1);
            },
            child: Text('Dialog Alert'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              await Upgrader.clearSavedSettings();
              _upgrader = Upgrader(dialogStyle: UpgradeDialogStyle.cupertino);
              setState(() => _testState = 2);
            },
            child: Text('Dialog Alert - Cupertino'),
          ),
        ],
      )),
    );

    late Widget content;
    switch (_testState) {
      case 0:
        content = scaffold;
        break;
      case 1:
        content = UpgradeAlert(upgrader: _upgrader, child: scaffold);
        break;
      case 2:
        content = UpgradeAlert(upgrader: _upgrader, child: scaffold);
        break;
      default:
    }

    return MaterialApp(
      title: 'Upgrader Driver App',
      home: content,
    );
  }
}
