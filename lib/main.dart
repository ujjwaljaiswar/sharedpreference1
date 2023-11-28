import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  String _storedValue = '';

  @override
  void initState() {
    super.initState();
    _loadStoredValue();
  }

  Future<void> _loadStoredValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedValue = prefs.getString('myKey') ?? '';
    });
  }

  Future<void> _saveValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('myKey', _controller.text);
    _loadStoredValue(); // Refresh the displayed value after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedPreferences Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter a value'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveValue,
              child: Text('Save Value'),
            ),
            SizedBox(height: 16.0),
            Text('Stored Value: $_storedValue'),
          ],
        ),
      ),
    );
  }
}
