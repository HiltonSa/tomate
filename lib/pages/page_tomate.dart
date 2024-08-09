import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomate/components/cronometro.dart';
import 'package:tomate/components/entrada_tempo.dart';
import 'package:tomate/store/tomate.store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PageTomate extends StatelessWidget {
  const PageTomate({super.key});

  @override
  Widget build(BuildContext context) {
    // aqui recupera o store atraves do provider
    final store = Provider.of<StoreTomate>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(child: Cronometro()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Observer(builder: (_) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  EntradaTempo(
                    titulo: 'Trabalho',
                    valor: store.tempoTrabalho,
                    inc: store.iniciado && store.estaTrabalhando()
                        ? null
                        : store.incrementarTempoTrabalho,
                    dec: store.iniciado && store.estaTrabalhando()
                        ? null
                        : store.decrementarTempoTrabalho,
                  ),
                  EntradaTempo(
                    titulo: 'Descanso',
                    valor: store.tempoDescanso,
                    inc: store.iniciado && store.estaDescansando()
                        ? null
                        : store.incrementarTempoDescanso,
                    dec: store.iniciado && store.estaDescansando()
                        ? null
                        : store.decrementarTempoDescanso,
                  )
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}
