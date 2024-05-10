import 'package:flutter/material.dart';
import 'package:lab9_cuba/page1.dart';
import "package:lab9_cuba/page2.dart";


Map<String, WidgetBuilder> routes = {
  '/': (context) => Page1(),
  '/page2': (context) => Page2(),
};