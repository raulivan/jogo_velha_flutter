import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  var jogoAcabou = false;
  var _jogadorAtual = '';
  //Gerência de estado nativa do Flutter import fundation
  final ValueNotifier<String> proximoJogadorNotifier =
      ValueNotifier<String>('X');

  set proximoJogador(String value) => proximoJogadorNotifier.value = value;
  String get proximoJogador => proximoJogadorNotifier.value;

  final ValueNotifier<int> vitoriasXNotifier = ValueNotifier<int>(0);
  set vitoriasX(int value) => vitoriasXNotifier.value = value;
  int get vitoriasX => vitoriasXNotifier.value;

  final ValueNotifier<int> vitoriasONotifier = ValueNotifier<int>(0);
  set vitoriasO(int value) => vitoriasONotifier.value = value;
  int get vitoriasO => vitoriasONotifier.value;

  final ValueNotifier<int> empatesNotifier = ValueNotifier<int>(0);
  set empates(int value) => empatesNotifier.value = value;
  int get empates => empatesNotifier.value;

  final ValueNotifier<bool> limparBotaoNotifier = ValueNotifier<bool>(false);
  set limparBotao(bool value) => limparBotaoNotifier.value = value;
  bool get limparBotao => limparBotaoNotifier.value;
  //FIm

  //0 - Disponível; 1 - X; 2 - O
  List<List> tabuleiro = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0]
  ];

  String definirJogada(BuildContext context, int linha, int coluna) {
    if (limparBotao) limparBotao = false;
    if (jogoAcabou) return "O Jogo finalizou";

    //verificando se o local está dispónivel
    if (tabuleiro[linha][coluna] != 0)
      return "Célula indisponível para novas jogadas!";

    //Definincado quem vai jogar
    if (_jogadorAtual == '') {
      _jogadorAtual = 'X';
      proximoJogador = 'O';
    } else if (_jogadorAtual == 'X') {
      _jogadorAtual = 'O';
      proximoJogador = 'X';
    } else {
      _jogadorAtual = 'X';
      proximoJogador = 'O';
    }

    tabuleiro[linha][coluna] = _jogadorAtual == 'X' ? 1 : 2;
    _verificar_vitorias(context, tabuleiro[linha][coluna]);
    return _jogadorAtual;
  }

  void _verificar_vitorias(BuildContext context, int jogador) async {
    var teveVencedor = false;
    //Verificar linhas
    var contador = 0;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) if (tabuleiro[i][j] == jogador) contador++;
      if (contador == 3) {
        teveVencedor = true;
      } else
        contador = 0;
    }

    //Verificar colunas
    contador = 0;
    for (int j = 0; j < 3; j++) {
      for (int i = 0; i < 3; i++) if (tabuleiro[i][j] == jogador) contador++;
      if (contador == 3) {
        teveVencedor = true;
      } else
        contador = 0;
    }

    //Verificar diagonal principal
    contador = 0;
    for (int i = 0; i < 3; i++) if (tabuleiro[i][i] == jogador) contador++;
    if (contador == 3) teveVencedor = true;

    //Verificar diagonal secundaria
    contador = 0;
    for (int i = 0; i < 3; i++)
      for (int j = 0; j < 3; j++)
        if (i + j + 2 == 4) if (tabuleiro[i][j] == jogador) contador++;
    if (contador == 3) teveVencedor = true;

    //notifica o vencedor
    if (teveVencedor) {
      if (jogador == 1) {
        vitoriasX++;
        _notificar(context, 'Parabens, X venceu');
      } else if (jogador == 2) {
        vitoriasO++;
        _notificar(context, 'Parabens, O venceu');
      }
      jogoAcabou = true;
    } else {
      //verifica se deu empate
      contador = 0;
      for (int i = 0; i < 3; i++)
        for (int j = 0; j < 3; j++) if (tabuleiro[i][j] != 0) contador++;

      if (contador == 9) {
        empates++;
        _notificar(context, 'Ninguém venceu');
        jogoAcabou = true;
      }
    }
  }

  void _notificar(BuildContext context, String msg) {
    var btnOK = TextButton(
        child: Text("OK"), onPressed: () => Navigator.of(context).pop());

    var alerta = AlertDialog(
      title: Text('Parabens!'),
      content: Text(msg),
      actions: [
        btnOK,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  void novaPartida() {
    for (int i = 0; i < 3; i++) for (int j = 0; j < 3; j++) tabuleiro[i][j] = 0;
    jogoAcabou = false;
    _jogadorAtual = '';
    proximoJogador = 'X';

    limparBotao = true;
  }

  void reiniciar() {
    vitoriasX = 0;
    vitoriasO = 0;
    empates = 0;
    novaPartida();
  }
}
