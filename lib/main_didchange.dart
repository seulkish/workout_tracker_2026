import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool dark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 조상의 InheritedWidget(Theme)이 여기서 바뀐다
      theme: dark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => setState(() => dark = !dark),
            child: const ChildText(),
          ),
        ),
      ),
    );
  }
}

class ChildText extends StatefulWidget {
  const ChildText({super.key});
  @override
  State<ChildText> createState() => _ChildTextState();
}

class _ChildTextState extends State<ChildText> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Theme.of(context) 호출로 의존성이 등록되어 있어,
    // 조상 Theme이 바뀔 때마다 이 콜백이 다시 불린다.
    print('didChangeDependencies 호출됨');
  }

  @override
  Widget build(BuildContext context) {
    // 여기서 of(context)를 읽는 것이 의존성 등록의 핵심
    final brightness = Theme.of(context).brightness;
    return Text('현재 테마: $brightness');
  }
}