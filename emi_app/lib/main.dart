import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
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
  int _selectedIndex = 0;

  static const List<String> _menuTitles = [
    'Home',
    'Business',
    'School',
    'Settings'
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('Index 0: Home', style: TextStyle(fontSize: 30))),
    BusinessPage(), // Custom theme para Business
    Center(child: Text('Index 2: School', style: TextStyle(fontSize: 30))),
    Center(child: Text('Index 3: Settings', style: TextStyle(fontSize: 30))),
  ];

  void _onItemTapped(int index, BuildContext context) {
    setState(() {
      _selectedIndex = index;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Seleccionaste ${_menuTitles[index]}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: _widgetOptions[_selectedIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ...List.generate(
              _menuTitles.length,
              (index) => ListTile(
                title: Text(_menuTitles[index]),
                selected: _selectedIndex == index,
                onTap: () {
                  _onItemTapped(index, context);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BusinessPage extends StatelessWidget {
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.orange.shade50,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.orange, fontSize: 18),
          titleLarge: TextStyle(color: Colors.deepOrange, fontSize: 24),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Business Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Bienvenido a la pestaña Business'),
              SizedBox(height: 10),
              Text('Este es un tema personalizado.')
            ],
          ),
        ),
      ),
    );
  }
}
