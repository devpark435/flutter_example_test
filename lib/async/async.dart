import 'package:flutter/material.dart';

class AsyncExampleApp extends StatelessWidget {
  const AsyncExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 비동기 예제',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AsyncExample(),
    );
  }
}

class AsyncExample extends StatefulWidget {
  const AsyncExample({super.key});

  @override
  AsyncExampleState createState() => AsyncExampleState();
}

class AsyncExampleState extends State<AsyncExample> {
  List<String> items = [];
  bool isLoading = false;

  void fetchData() async {
    setState(() {
      isLoading = true;
    });
    // 데이터를 비동기적으로 가져오는 작업 (API 호출 등)
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      items = ['Item 1', 'Item 2', 'Item 3'];
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비동기 데이터 로딩 예제'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(items[index]),
              ),
            ),
    );
  }
}
