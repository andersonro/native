import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nativo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Nativo'),
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
  double _num1 = 0;
  double _num2 = 0;
  double _res = 0;

  Future<void> _calcSum() async {
    const channel = MethodChannel('br.com.arodevsistemas/nativo');

    try {
      _res =
          await channel.invokeMethod('calcSum', {'num1': _num1, 'num2': _num2});
    } catch (e) {
      _res = 0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Resultado: ${_res}',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                onChanged: (value) => _num1 = double.tryParse(value) ?? 0,
                decoration: const InputDecoration(label: Text('Número 1')),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                onChanged: (value) => _num2 = double.tryParse(value) ?? 0,
                decoration: const InputDecoration(label: Text('Número 2')),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.calculate_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
