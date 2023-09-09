import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulHookWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(
        seconds: 10,
      ),
    );
    final animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animationController);

    useEffect(
      () {
        animationController.forward();
        return null;
      },
      [],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("ホーム"),
      ),
      body: Center(
        child: Hero(
          tag: 'tag',
          child: GestureDetector(
            onTap: () {
              Navigator.of(
                context,
              ).push(
                PageRouteBuilder(
                  pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) =>
                      const SamplePage(),
                  transitionDuration: const Duration(
                    seconds: 5,
                  ),
                  reverseTransitionDuration: const Duration(
                    seconds: 5,
                  ),
                ),
              );
            },
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: animation.value,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SamplePage extends HookWidget {
  const SamplePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(
        milliseconds: 500,
      ),
    )..repeat(reverse: true);
    final animation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(animationController);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Page'),
      ),
      backgroundColor: Colors.transparent,
      body: Hero(
        tag: 'tag',
        child: GestureDetector(
          onTap: () {
            Navigator.of(
              context,
            ).push(
              MaterialPageRoute(
                builder: (context) => const SamplePage2(),
              ),
            );
          },
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform.scale(
                scale: animation.value,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SamplePage2 extends StatelessWidget {
  const SamplePage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Page'),
      ),
      body: Center(
        child: Hero(
          tag: 'tag',
          child: Container(
            color: Colors.green,
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
