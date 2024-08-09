import 'package:flutter/material.dart';
import 'package:tomate/pages/page_tomate.dart';
import 'package:provider/provider.dart';
import 'package:tomate/store/tomate.store.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:tomate/store/contador.store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // O multiprovider serve a toda a aplicacao uma instancia de TickerProviderStateMixin
    // atraves da lista de providers
    return MultiProvider(
      providers: [
        // aqui e adicionado o store
        Provider<StoreTomate>(
          create: (context) => StoreTomate(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PageTomate(),
      ),
    );
  }
}

// final store = ContadorStore();

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: const Text('Contador'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Observer(builder: (_) {
//               return Text(
//                 '${store.contador}',
//                 style: Theme.of(context).textTheme.headlineMedium,
//               );
//             }),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: store.incrementar,
//         tooltip: 'Somar',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
