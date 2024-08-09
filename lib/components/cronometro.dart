import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tomate/components/cronometro_botao.dart';
import 'package:tomate/store/tomate.store.dart';

class Cronometro extends StatelessWidget {
  const Cronometro({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<StoreTomate>(context);
    return Observer(
      builder: (context) => Container(
        color: store.estaTrabalhando() ? Colors.red : Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              store.estaTrabalhando()
                  ? 'Hora de Trabalhar'
                  : 'Hora de Descansar',
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${store.minutos.toString().padLeft(2, '0')}:${store.segundos.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 120, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!store.iniciado)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CronometroBotao(
                      texto: 'Iniciar',
                      icone: Icons.play_arrow,
                      clique: store.iniciar,
                    ),
                  ),
                if (store.iniciado)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CronometroBotao(
                      texto: 'Parar',
                      icone: Icons.stop,
                      clique: store.parar,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CronometroBotao(
                    texto: 'Reiniciar',
                    icone: Icons.refresh,
                    clique: store.reiniciar,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
