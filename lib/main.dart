import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xffF7D2D2),
          scaffoldBackgroundColor: Color(0xffF7D2D2)
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  AnimationController animationController;
  double ratio = 1.0;

  @override
  void initState() {
    animationController = AnimationController(vsync: this,duration: Duration(seconds: 10))
      ..addStatusListener((status) {
        if(status == AnimationStatus.completed)
        {
          animationController.reset();
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Stack(
              children: [
                FadeTransition(
                  opacity: Tween<double>(begin: 1.0,end: 0.0).animate(CurvedAnimation(
                      parent: animationController,
                      curve: Curves.fastLinearToSlowEaseIn
                  )
                  ),
                  child: SlideTransition(
                    position: Tween<Offset>(begin: Offset(0.0,0.0),end: Offset(0.0,-1.0)).animate(CurvedAnimation(
                      curve: Curves.fastLinearToSlowEaseIn,
                      parent: animationController,
                    )
                    ),
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: Icon(Icons.favorite,color: Colors.red,size: 100*ratio,),
                    ),
                  ),
                ),
                GestureDetector(
                  onTapDown: (d){
                    setState(() {
                      ratio = 0.9;
                    });
                  },
                  onTapUp: (d){
                    setState(() {
                      ratio = 1.0;
                    });
                    animationController.forward();
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    child: Icon(Icons.favorite,color: Colors.red,size: 100 * ratio,),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}