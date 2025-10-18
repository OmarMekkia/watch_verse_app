import 'package:flutter/material.dart';
import 'package:watch_verse/core/di/di.dart';
import 'package:watch_verse/watch_verse_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const WatchVerseApp());
}
