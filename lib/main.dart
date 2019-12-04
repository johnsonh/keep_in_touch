import 'package:flutter/widgets.dart';

import 'flows/app_flow.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppFlow().start();
  }
}
