import 'package:flutter/material.dart';

class AnimationExampleApp extends StatelessWidget {
  const AnimationExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 애니메이션 예제',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AnimationExample(),
    );
  }
}

class AnimationExample extends StatefulWidget {
  const AnimationExample({super.key});

  @override
  AnimationExampleState createState() => AnimationExampleState();
}

class AnimationExampleState extends State<AnimationExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('애니메이션 예제'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '기본'),
            Tab(text: '트위닝'),
            Tab(text: '페이드'),
            Tab(text: '히어로'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          BasicAnimationExample(),
          TweenAnimationExample(),
          FadeAnimationExample(),
          HeroAnimationExample(),
        ],
      ),
    );
  }
}

// 1. 기본 애니메이션 예제
class BasicAnimationExample extends StatefulWidget {
  const BasicAnimationExample({super.key});

  @override
  BasicAnimationExampleState createState() => BasicAnimationExampleState();
}

class BasicAnimationExampleState extends State<BasicAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '기본 애니메이션',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: 200 + (100 * _animation.value),
                height: 100 + (100 * _animation.value),
                decoration: BoxDecoration(
                  color: Color.lerp(
                    Colors.blue,
                    Colors.red,
                    _animation.value,
                  ),
                  borderRadius: BorderRadius.circular(
                    8 + (8 * _animation.value),
                  ),
                ),
                child: const Center(
                  child: Text(
                    '크기 변경',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _toggleExpand,
            child: Text(_isExpanded ? '축소하기' : '확장하기'),
          ),
        ],
      ),
    );
  }
}

// 2. 트위닝 애니메이션 예제
class TweenAnimationExample extends StatefulWidget {
  const TweenAnimationExample({super.key});

  @override
  TweenAnimationExampleState createState() => TweenAnimationExampleState();
}

class TweenAnimationExampleState extends State<TweenAnimationExample> {
  double _targetValue = 24.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '트위닝 애니메이션',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: _targetValue),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return Column(
                children: [
                  Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'fontSize: ${value.toStringAsFixed(1)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: value,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Slider(
                    min: 10.0,
                    max: 48.0,
                    value: _targetValue,
                    onChanged: (value) {
                      setState(() {
                        _targetValue = value;
                      });
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// 3. 페이드 애니메이션 예제
class FadeAnimationExample extends StatefulWidget {
  const FadeAnimationExample({super.key});

  @override
  FadeAnimationExampleState createState() => FadeAnimationExampleState();
}

class FadeAnimationExampleState extends State<FadeAnimationExample> {
  bool _isVisible = true;
  int _currentIndex = 0;

  final List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _changeColor() {
    setState(() {
      _isVisible = false;
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _colors.length;
          _isVisible = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '페이드 애니메이션',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                color: _colors[_currentIndex],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  '페이드 효과',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _toggleVisibility,
                child: Text(_isVisible ? '숨기기' : '보이기'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _changeColor,
                child: const Text('색상 변경'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 4. 히어로 애니메이션 예제
class HeroAnimationExample extends StatelessWidget {
  const HeroAnimationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        final color = Colors.primaries[index % Colors.primaries.length];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HeroDetailScreen(
                  color: color,
                  index: index,
                ),
              ),
            );
          },
          child: Hero(
            tag: 'hero-$index',
            // Material 위젯으로 감싸서 클리핑 처리
            child: Material(
              type: MaterialType.transparency,
              clipBehavior: Clip.antiAlias, // 내용이 영역을 벗어나지 않도록 클리핑
              child: Card(
                color: color,
                elevation: 4,
                child: Center(
                  child: Text(
                    '항목 ${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class HeroDetailScreen extends StatelessWidget {
  final Color color;
  final int index;

  const HeroDetailScreen({
    super.key,
    required this.color,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // 화면 크기 가져오기
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('항목 ${index + 1} 상세'),
      ),
      // SingleChildScrollView로 감싸서 내용이 넘칠 경우 스크롤 가능하게 함
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'hero-$index',
                // Material 위젯으로 감싸서 클리핑 처리
                child: Material(
                  type: MaterialType.transparency,
                  clipBehavior: Clip.antiAlias, // 내용이 영역을 벗어나지 않도록 클리핑
                  child: Container(
                    // 화면 크기에 맞게 동적으로 조정
                    width: screenSize.width * 0.85, // 화면 너비의 85%
                    height: screenSize.width * 0.85, // 정사각형 유지
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '항목 ${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            '히어로 애니메이션 상세 화면',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('돌아가기'),
              ),
              const SizedBox(height: 20), // 스크롤 공간 확보
            ],
          ),
        ),
      ),
    );
  }
}
