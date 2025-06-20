import 'package:bootstrap_plus/resouces/enums.dart';
import 'package:bootstrap_plus/resouces/models/bootstrap_col_size.dart';
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
            offsets: GridOffsetSize(xl: ColSize.col2,lg:ColSize.col1),
            sizes:GridColSize(xl: ColSize.col4,lg:ColSize.col6 ,md: ColSize.col6), /// 'col-12 col-xl-8 col-lg-6 col-md-6',
            child: Container(
              color: Colors.red,
              height: 100,
              alignment: Alignment.center,
              child: const Text('Column 1'),
            ),
          ),
          BootstrapCol(
            sizes:GridColSize(xl: ColSize.col4,lg:ColSize.col6 ,md: ColSize.col6), /// 'col-12 col-xl-4 col-lg-6 col-md-6',

            child: Container(
              color: Colors.blue,
              height: 100,
              alignment: Alignment.center,
              child: const Text('Column 2'),
            ),
          ),
          BootstrapCol(
            sizes:GridColSize(md: ColSize.col6,lg:ColSize.col4,xs: ColSize.col6), /// 'col-12 col-md-6 col-lg-4 col-xs-6',
            child: Container(
              color: Colors.green,
              height: 100,
              alignment: Alignment.center,
              child: const Text('Column 3'),
            ),
          ),
          BootstrapCol(
            sizes:GridColSize(md: ColSize.col6,lg:ColSize.col4,xs: ColSize.col6), /// 'col-12 col-md-6 col-lg-4 col-xs-6',
            child: Container(
              color: Colors.yellow,
              height: 100,
              alignment: Alignment.center,
              child: const Text('Column 4'),
            ),
          ),
          BootstrapCol(
            sizes:GridColSize(md: ColSize.col6,lg:ColSize.col0,xs: ColSize.col6), /// 'col-12 col-md-6 col-lg-4 col-xs-6',
            child: Container(
              color: Colors.brown,
              height: 100,
              alignment: Alignment.center,
              child: const Text('Column 5'),
            ),
          ),
          BootstrapCol(
            sizes:GridColSize(md: ColSize.col6,lg:ColSize.col4,xs: ColSize.col6), /// 'col-12 col-md-6 col-lg-4 col-xs-6',
            child: Container(
              color: Colors.orange,
              height: 100,
              alignment: Alignment.center,
              child: const Text('Column 6'),
            ),
          ),
          BootstrapCol(
            sizes:GridColSize(col:ColSize.col2), /// 'col-12 col-md-6 col-lg-4 col-xs-6',
            child: Container(
              color: Colors.orange,
              height: 100,
              alignment: Alignment.center,
              child: const Text('Column 6'),
            ),
          ),
          BootstrapCol(
            sizes:GridColSize(col:ColSize.col2), /// 'col-12 col-md-6 col-lg-4 col-xs-6',
            child: Container(
              color: Colors.orange,
              height: 100,
              alignment: Alignment.center,
              child: const Text('Column 6'),
            ),
          ),
          BootstrapCol(
            sizes:GridColSize(col:ColSize.col2), /// 'col-12 col-md-6 col-lg-4 col-xs-6',
            child: Container(
              color: Colors.orange,
              height: 100,
              alignment: Alignment.center,
              child: const Text('Column 6'),
            ),
          ),
          BootstrapCol(
            sizes:GridColSize(col:ColSize.col2), /// 'col-12 col-md-6 col-lg-4 col-xs-6',
            child: Container(
              color: Colors.orange,
              height: 100,
              alignment: Alignment.center,
              child: const Text('Column 6'),
            ),
          ),
        ],
      ),
    );
  }
}
