import 'package:flutter/material.dart';
import 'package:vendo/page/app.dart';

class Loading extends StatefulWidget {
  const Loading({ Key? key }) : super(key: key);

  @override
  LoadingState createState() => LoadingState();
}

class LoadingState extends State<Loading> {

  @override
  void initState() {
    _hasLoaded();
    super.initState();
  }

  Future<void> _hasLoaded() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder:(context, animation, secondaryAnimation) => const App(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: 300,
                height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/transparent-loading-logo.gif'),
                      fit: BoxFit.cover
                    )
                  ),
              ),
            ],
          ) ,
        ),
      ),
    ),
    );
  }
}