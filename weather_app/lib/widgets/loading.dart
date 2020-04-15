import 'package:flutter/material.dart';

class LoadingLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg_1.png"), fit: BoxFit.cover)),
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor, 
        ),
      ),
    );
  }
}
