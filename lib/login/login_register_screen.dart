import 'package:flutter/material.dart';
// import 'package:flutter_samples/success/login_success.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import '../success/other.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});
  @override
  LoginRegisterScreenState createState() => LoginRegisterScreenState();
}

class LoginRegisterScreenState extends State<LoginRegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLogin = true; // 标记当前是登录模式还是注册模式
  String message = ''; // 用于显示登录或注册成功的消息
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor:
          const Color.fromARGB(255, 253, 116, 116).withOpacity(0.7),
      textColor: Colors.white,
      fontSize: 30.0,
    );
  }

  Future<bool> loginPostRequest() async {
    var url = Uri.parse('http://www.yueyvlunhui.cn:3000/api/login');
    var response = await http.post(url, body: {
      'account': usernameController.text,
      'password': passwordController.text,
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var code = jsonResponse['code'];
      var message = jsonResponse['message'];
      // var data = jsonResponse['data'];
      if (code == 200) {
        nextModule();
        return true;
      } else {
        showToast(message);
        return false;
      }
    } else {
      showToast('登录失败');
      return false;
    }
  }

  Future<bool> registerPostRequest() async {
    var url = Uri.parse('http://www.yueyvlunhui.cn:3000/api/register');
    var response = await http.post(url, body: {
      'account': usernameController.text,
      'password': passwordController.text,
    });

    if (response.statusCode == 200) {
      // 请求成功
      var jsonResponse = json.decode(response.body);
      var code = jsonResponse['code'];
      var message = jsonResponse['message'];
      // var data = jsonResponse['data'];
      if (code == 200) {
        nextModule();
        return true;
      } else {
        showToast(message);
        return false;
      }
      // 进行其他处理
    } else {
      // 请求失败
      showToast('注册失败');
      return false;
    }
  }

  void nextModule() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MathTest(username: usernameController.text)),
    );
  }

  void loginOrRegister() async {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username.length < 9 || password.length < 9) {
      setState(() {
        message = '账号和密码长度必须大于等于9个字符';
      });
    } else {
      if (isLogin == true) {
        if (await loginPostRequest() == true) {}
      } else {
        if (await registerPostRequest() == true) {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? '登录' : '注册'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: TextField(
                style: const TextStyle(fontSize: 24.0, color: Colors.pink),
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: '账号',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(181, 89, 89, 241)),
                  alignLabelWithHint: true,
                  // contentPadding:
                  // EdgeInsets.symmetric(horizontal: 106.0, vertical: 8.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: TextField(
                style: const TextStyle(fontSize: 24.0, color: Colors.pink),
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: '密码',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(181, 89, 89, 241))
                    // contentPadding:
                    // EdgeInsets.symmetric(horizontal: 106.0, vertical: 8.0),
                    ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: loginOrRegister,
              child: Text(
                isLogin ? '登录' : '注册',
                style: const TextStyle(fontSize: 24.0),
              ),
            ),
            if (message.isNotEmpty)
              Text(
                message,
                style: const TextStyle(
                    color: Color.fromARGB(255, 253, 188, 184), fontSize: 14.0),
              ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                  message = '';
                });
              },
              child: Text(
                isLogin ? '没有账号？点击注册' : '已有账号？点击登录',
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
