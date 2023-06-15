import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
      home: const MyHomePage(title: 'Flutter Skeleton Loader Demo'),
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
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }

  Future loadData() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 10), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SkeletonTheme(
      shimmerGradient: const LinearGradient(
        colors: [
          Color(0xFFD8E3E7),
          Color.fromARGB(255, 128, 191, 214),
          Color.fromARGB(255, 93, 39, 86),
          // Color(0xFFD8E3E7),
          // Color(0xFFD8E3E7),
          // Color(0xFFD8E3E7),
        ],
        stops: [
          0.1,
          0.5,
          0.9,
        ],
      ),
      darkShimmerGradient: const LinearGradient(
        colors: [
          Color(0xFF222222),
          Color(0xFF242424),
          Color(0xFF2B2B2B),
          Color(0xFF242424),
          Color(0xFF222222),
        ],
        stops: [
          0.0,
          0.2,
          0.5,
          0.8,
          1,
        ],
        tileMode: TileMode.repeated,
      ),
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Container(
            child: _isLoading
                ?
                //  SkeletonListView(
                //     spacing: 20,
                //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                //   )
                Container(
                    margin: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width - 40,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                                height: 100,
                                width: 100,
                                borderRadius: BorderRadius.circular(50))),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            SkeletonParagraph(
                                style: SkeletonParagraphStyle(
                                    lines: 4,
                                    lineStyle: SkeletonLineStyle(
                                      height: 12,
                                      borderRadius: BorderRadius.circular(8),
                                      minLength:
                                          MediaQuery.of(context).size.width / 2,
                                      maxLength:
                                          MediaQuery.of(context).size.width /
                                              1.8,
                                    ))),
                            const SkeletonItem(
                                child: Text(
                              'Loading...',
                            )),
                          ],
                        )
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(12),
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) =>
                        buildResult(),
                  ),
          )),
    );
  }

  Widget buildResult() => Row(
        children: <Widget>[
          Container(
            child: Image.network(
              'https://images.unsplash.com/photo-1508697014387-db70aad34f4d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80',
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Hello',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 8),
              Text(
                'Hello',
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ],
      );
}
