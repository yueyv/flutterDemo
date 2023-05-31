import 'package:flutter/material.dart';
import 'login/login_register_screen.dart'; // 导入登录注册页面

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '移动平台开发',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(bodyLarge: TextStyle(fontSize: 24.0))),
      home: const LoginRegisterScreen(), // 设置登录注册页面为主界面
    );
  }
}
