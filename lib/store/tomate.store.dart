import 'dart:async';

import 'package:mobx/mobx.dart';

// importacao da classe gerada pelo build_runner
part 'tomate.store.g.dart';

// declaracao que cria a classe a ser instanciada como um mixin da
// classe abstrata e a classe gerada, contida no arquivo .g que tem
// o mesmo nome da classe abstrada com um $ depois do _
class StoreTomate = _StoreTomate with _$StoreTomate;

enum TipoIntervalo { TRABALHO, DESCANSO }

abstract class _StoreTomate with Store {
  @observable
  bool iniciado = false;
  @observable
  int tempoTrabalho = 2;
  @observable
  int tempoDescanso = 1;
  @observable
  int minutos = 2;
  @observable
  int segundos = 0;
  @observable
  TipoIntervalo tipoIntervalo = TipoIntervalo.TRABALHO;

  Timer? cronometro;

  @action
  void iniciar() {
    iniciado = true;
    cronometro = Timer.periodic(
      const Duration(milliseconds: 50),
      (timer) {
        if (minutos == 0 && segundos == 0) {
          _trocarTipoIntervalo();
        } else if (segundos == 0) {
          segundos = 59;
          minutos--;
        } else {
          segundos--;
        }
      },
    );
  }

  @action
  void parar() {
    iniciado = false;
    cronometro?.cancel();
  }

  @action
  void reiniciar() {
    parar();
    minutos = estaTrabalhando() ? tempoTrabalho : tempoDescanso;
    segundos = 0;
  }

  @action
  void incrementarTempoTrabalho() {
    tempoTrabalho++;
    if (estaTrabalhando()) {
      reiniciar();
    }
  }

  @action
  void decrementarTempoTrabalho() {
    tempoTrabalho--;
    if (tempoTrabalho <= 0) {
      tempoTrabalho = 1;
    }
    if (estaTrabalhando()) {
      reiniciar();
    }
  }

  @action
  void incrementarTempoDescanso() {
    tempoDescanso++;

    if (estaDescansando()) {
      reiniciar();
    }
  }

  @action
  void decrementarTempoDescanso() {
    tempoDescanso--;
    if (tempoDescanso <= 0) {
      tempoDescanso = 1;
    }
    if (estaDescansando()) {
      reiniciar();
    }
  }

  bool estaTrabalhando() => tipoIntervalo == TipoIntervalo.TRABALHO;
  bool estaDescansando() => tipoIntervalo == TipoIntervalo.DESCANSO;

  _trocarTipoIntervalo() {
    if (estaTrabalhando()) {
      tipoIntervalo = TipoIntervalo.DESCANSO;
      minutos = tempoDescanso;
    } else {
      tipoIntervalo = TipoIntervalo.TRABALHO;
      minutos = tempoTrabalho;
    }
    segundos = 0;
  }
}
