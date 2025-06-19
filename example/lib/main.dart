import 'package:flutter/material.dart';
import 'package:bootstrap_plus/bootstrap_plus.dart'; // Import your package.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bootstrap Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bootstrap Example'),
      ),
      body: BootstrapRow(
         children: [
          BootstrapCol(
            sizes: 'col-12 col-md-6',
            child: Container(
              color: Colors.red,
              height: 100,
              alignment: Alignment.center,
              child: const Text('Column 1'),
            ),
          ),
          BootstrapCol(
            sizes: 'col-12 col-md-6',
            child: Container(
              color: Colors.blue,
              height: 100,
              alignment: Alignment.center,
              child: const Text('Column 2'),
            ),
          ),
          BootstrapCol(
            sizes: 'col-12 col-md-3',
            child: Container(
              color: Colors.red,
              height: 100,
              alignment: Alignment.center,
              child: const Text('Column 1'),
            ),
          ),
          BootstrapCol(
            sizes: 'col-12 col-md-3',
            child: Container(
              color: Colors.blue,
              height: 100,
              alignment: Alignment.center,
              child: const Text('Column 2'),
            ),
          ),
         ],
      ),
    );
  }
}
