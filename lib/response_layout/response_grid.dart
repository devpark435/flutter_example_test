import 'package:flutter/material.dart';

class ResponseGridApp extends StatelessWidget {
  const ResponseGridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 반응형 그리드 예제',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SwitchGrid(),
    );
  }
}

class ResponseGrid extends StatelessWidget {
  const ResponseGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('반응형 그리드 예제'),
      ),
      body: OperationGrid(),
    );
  }
}

class ResponseGridView extends StatelessWidget {
  const ResponseGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      final crossAxisCount = constraint.maxWidth > 600 ? 3 : 2;

      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 2 / 3,
        ),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.blue,
            child: Text('Item $index'),
          ),
        ),
      );
    });
  }
}

class OperationGrid extends StatelessWidget {
  const OperationGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      final crossAxisCount = orientation == Orientation.portrait ? 2 : 3;

      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 2 / 3,
        ),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.blue,
            child: Text('Item $index'),
          ),
        ),
      );
    });
  }
}

class SwitchGrid extends StatefulWidget {
  const SwitchGrid({super.key});

  @override
  State<SwitchGrid> createState() => _SwitchGridState();
}

class _SwitchGridState extends State<SwitchGrid> {
  bool _isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('갤러리'),
        actions: [
          Switch(
            value: _isGrid,
            onChanged: (value) {
              setState(() {
                _isGrid = value;
              });
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _isGrid ? 3 : 2,
          childAspectRatio: 2 / 3,
        ),
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Container(
                color: Colors.blue,
                child: Text('Item $index'),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('알림'),
                    content: Text('아이템 $index를 선택하셨습니다.'),
                  ),
                );
              },
            )),
      ),
    );
  }
}
