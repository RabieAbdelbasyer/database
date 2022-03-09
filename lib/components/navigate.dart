import 'package:flutter/material.dart';

void navigateToReplacement(context, screen) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return screen;
  }));
}

void navigateTo(context, screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return screen;
  }));
}
