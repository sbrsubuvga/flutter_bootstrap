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
      body: SingleChildScrollView(
        child: Column(
          children: [
            BootstrapRow(
              children: [
                // 12 span-1 columns
                for (int i = 0; i < 12; i++)
                  BootstrapCol(
                    sizes: GridCol(
                        col: BCol.col1,
                        sm: BCol.col12,
                        md: BCol.col6,
                        lg: BCol.col4,
                        xl: BCol.col3),
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(1),
                      color: Colors.grey,
                      alignment: Alignment.center,
                      child: Text('colum A$i '),
                    ),
                  ),
              ],
            ),
            BootstrapRow(
              children: [
                // 3 span-4 columns
                for (int i = 0; i < 3; i++)
                  BootstrapCol(
                    sizes: GridCol(
                        col: BCol.col4,
                        sm: BCol.col6,
                        md: BCol.col6,
                        lg: BCol.col4,
                        xl: BCol.col4),
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(1),
                      color: Colors.grey,
                      alignment: Alignment.center,
                      child: Text('colum B$i'),
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            BootstrapRow(
              children: [
                // 1 span-4 + 1 span-8
                BootstrapCol(
                  sizes: GridCol(col: BCol.col4),
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.all(1),
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: const Text('span 4'),
                  ),
                ),
                BootstrapCol(
                  sizes: GridCol(col: BCol.col8),
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.all(1),
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: const Text('span 8'),
                  ),
                ),
              ],
            ),
            BootstrapRow(
              children: [
                // 2 span-6 columns
                for (int i = 0; i < 2; i++)
                  BootstrapCol(
                    sizes: GridCol(col: BCol.col6),
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(1),
                      color: Colors.grey,
                      alignment: Alignment.center,
                      child: const Text('span 6'),
                    ),
                  ),
              ],
            ),
            BootstrapRow(
              children: [
                // 1 span-12 column
                BootstrapCol(
                  sizes: GridCol(col: BCol.col12),
                  child: Container(
                    height: 60,
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: const Text('span 12'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            BootstrapRow(
              children: [
                // 1 span-4 + 1 span-8
                BootstrapCol(
                  sizes: GridCol(col: BCol.col4),
                  orders: GridOrder(col: BCol.col1, md: BCol.col2),
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.all(1),
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: const Text('Order 1'),
                  ),
                ),
                BootstrapCol(
                  sizes: GridCol(col: BCol.col8),
                  orders: GridOrder(col: BCol.col2, md: BCol.col1),
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.all(1),
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: const Text('Order 2'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            BootstrapRow(
              children: [
                // 1 span-4 + 1 span-8
                BootstrapCol(
                  sizes: GridCol(col: BCol.col4),
                  offsets: GridOffset(col: BCol.col2),
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.all(1),
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: const Text('Order 1'),
                  ),
                ),
                BootstrapCol(
                  sizes: GridCol(col: BCol.col4),
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.all(1),
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: const Text('Order 2'),
                  ),
                ),
              ],
            ),
            BootstrapRow(
              children: [
                // 1 span-4 + 1 span-8
                BootstrapCol(
                  sizes: GridCol(col: BCol.col3),
                  offsets: GridOffset(col: BCol.col2),
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.all(1),
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: const Text('Order 1'),
                  ),
                ),
                BootstrapCol(
                  sizes: GridCol(col: BCol.col3),
                  offsets: GridOffset(col: BCol.col2),
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.all(1),
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: const Text('Order 2'),
                  ),
                ),
              ],
            ),
            BootstrapRow(
              children: [
                BootstrapCol(
                  sizes: GridCol(
                      lg: BCol.col2,
                      xl: BCol.col2,
                      md: BCol.col3,
                      sm: BCol.col4),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: FilledButton(
                      onPressed: () {},
                      style: ButtonStyle().primary(),
                      child: Text('Primary'),
                    ),
                  ),
                ),
                BootstrapCol(
                  sizes: GridCol(
                      lg: BCol.col2,
                      xl: BCol.col2,
                      md: BCol.col3,
                      sm: BCol.col4),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: FilledButton(
                      style: ButtonStyle().secondary(),
                      onPressed: () {},
                      child: Text('Secondary'),
                    ),
                  ),
                ),
                BootstrapCol(
                  sizes: GridCol(
                      lg: BCol.col2,
                      xl: BCol.col2,
                      md: BCol.col3,
                      sm: BCol.col4),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle().success(),
                      child: const Text('Success'),
                    ),
                  ),
                ),
                BootstrapCol(
                  sizes: GridCol(
                      lg: BCol.col2,
                      xl: BCol.col2,
                      md: BCol.col3,
                      sm: BCol.col4),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle().danger(),
                      child: const Text('Danger'),
                    ),
                  ),
                ),
                BootstrapCol(
                  sizes: GridCol(
                      lg: BCol.col2,
                      xl: BCol.col2,
                      md: BCol.col3,
                      sm: BCol.col4),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle().warning(),
                      child: const Text('Warning'),
                    ),
                  ),
                ),
                BootstrapCol(
                  sizes: GridCol(
                      lg: BCol.col2,
                      xl: BCol.col2,
                      md: BCol.col3,
                      sm: BCol.col4),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle().info(),
                      child: const Text('Info'),
                    ),
                  ),
                ),
                BootstrapCol(
                  sizes: GridCol(
                      lg: BCol.col2,
                      xl: BCol.col2,
                      md: BCol.col3,
                      sm: BCol.col4),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: OutlinedButton(
                      onPressed: () {},
                      style: ButtonStyle().light(),
                      child: const Text('Light'),
                    ),
                  ),
                ),
                BootstrapCol(
                  sizes: GridCol(
                      lg: BCol.col2,
                      xl: BCol.col2,
                      md: BCol.col3,
                      sm: BCol.col4),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: OutlinedButton(
                      onPressed: () {},
                      style: ButtonStyle().dark(),
                      child: const Text('Dark'),
                    ),
                  ),
                ),
                BootstrapCol(
                  sizes: GridCol(
                      lg: BCol.col2,
                      xl: BCol.col2,
                      md: BCol.col3,
                      sm: BCol.col4),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle().link(),
                      child: const Text('Link'),
                    ),
                  ),
                ),
                BootstrapCol(
                  sizes: GridCol(
                      lg: BCol.col2,
                      xl: BCol.col2,
                      md: BCol.col3,
                      sm: BCol.col4),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: FilledButton(
                      onPressed: () {},
                      style: ButtonStyle()
                          .primary()
                          .copyWith(elevation: WidgetStateProperty.all(2.0)),
                      child: Text('Custom Primary'),
                    ),
                  ),
                ),
                BootstrapCol(
                  sizes: GridCol(
                      lg: BCol.col2,
                      xl: BCol.col2,
                      md: BCol.col3,
                      sm: BCol.col4),
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              style: ButtonStyle().primary(),
                              onPressed: () {},
                              icon: Icon(Icons.home)),
                          IconButton(
                              style: ButtonStyle().secondary(),
                              onPressed: () {},
                              icon: Icon(Icons.home)),
                          IconButton(
                              style: ButtonStyle().success(),
                              onPressed: () {},
                              icon: Icon(Icons.home)),
                        ],
                      )),
                ),
                BootstrapCol(
                  sizes: GridCol(
                      lg: BCol.col2,
                      xl: BCol.col2,
                      md: BCol.col3,
                      sm: BCol.col4),
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              style: ButtonStyle().primary().copyWith(
                                  iconColor:
                                      WidgetStateProperty.all(Colors.yellow)),
                              onPressed: () {},
                              icon: Icon(Icons.home)),
                          IconButton(
                              style: ButtonStyle().secondary(),
                              onPressed: () {},
                              icon: Icon(Icons.home)),
                          IconButton(
                              style: ButtonStyle().success(),
                              onPressed: () {},
                              icon: Icon(Icons.home)),
                        ],
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
