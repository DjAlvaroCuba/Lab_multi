import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejmplos usando https://api.flutter.dev/ :'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Material'),
            Tab(text: 'Cupertino'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MaterialControls(),
          CupertinoControls(),
        ],
      ),
    );
  }
}

class MaterialControls extends StatefulWidget {
  @override
  _MaterialControlsState createState() => _MaterialControlsState();
}

class _MaterialControlsState extends State<MaterialControls> {
  double _sliderValue = 0.5;
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Barra con material'),
          Slider(
            value: _sliderValue,
            onChanged: (newValue) {
              setState(() {
                _sliderValue = newValue;
              });
            },
          ),
          SizedBox(height: 40),
          Text('Boton con Material'),
          Switch(
            value: _switchValue,
            onChanged: (newValue) {
              setState(() {
                _switchValue = newValue;
              });
            },
          ),
        ],
      ),
    );
  }
}

class CupertinoControls extends StatefulWidget {
  @override
  _CupertinoControlsState createState() => _CupertinoControlsState();
}

class _CupertinoControlsState extends State<CupertinoControls> {
  double _sliderValue = 0.5;
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Barra con Cupertino '),
          CupertinoSlider(
            value: _sliderValue,
            onChanged: (newValue) {
              setState(() {
                _sliderValue = newValue;
              });
            },
          ),
          SizedBox(height: 40),
          Text('Boton con Cupertino '),
          CupertinoSwitch(
            value: _switchValue,
            onChanged: (newValue) {
              setState(() {
                _switchValue = newValue;
              });
            },
          ),
        ],
      ),
    );
  }
}
