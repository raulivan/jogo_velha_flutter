import 'package:flutter/material.dart';
import 'package:jogodavelha/controllers/home_controller.dart';
import 'package:jogodavelha/core/app_colors.dart';
import 'package:jogodavelha/shared/botao/botao_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _controlador = new HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaria,
        title: Row(
          children: [
            Icon(Icons.gamepad_outlined),
            SizedBox(
              width: 5,
            ),
            Text('Jogo da Velha'),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => _controlador.novaPartida(),
              icon: Icon(Icons.fiber_new)),
          IconButton(
              onPressed: () => _controlador.reiniciar(),
              icon: Icon(Icons.refresh))
        ],
      ),
      backgroundColor: AppColors.secundaria,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.cor1,
                  border: Border.all(color: AppColors.preto),
                  boxShadow: [
                    BoxShadow(color: AppColors.preto, blurRadius: 10)
                  ]),
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: ValueListenableBuilder<String>(
                    valueListenable: _controlador.proximoJogadorNotifier,
                    builder: (context, value, child) => Text(
                      'Vez do jogador $value',
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ValueListenableBuilder<int>(
                        valueListenable: _controlador.vitoriasXNotifier,
                        builder: (context, value, child) =>
                            Text('Vitórias do X: $value')),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ValueListenableBuilder<int>(
                        valueListenable: _controlador.vitoriasONotifier,
                        builder: (context, value, child) =>
                            Text('Vitórias do O: $value')),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ValueListenableBuilder<int>(
                        valueListenable: _controlador.empatesNotifier,
                        builder: (context, value, child) =>
                            Text('Empates: $value')),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ValueListenableBuilder<bool>(
              valueListenable: _controlador.limparBotaoNotifier,
              builder: (context, value, child) => Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      children: [
                        BotaoWidget(
                          aoTocar: _controlador.definirJogada,
                          linha: 0,
                          coluna: 0,
                          limparBotao: _controlador.limparBotao,
                        ),
                        BotaoWidget(
                            aoTocar: _controlador.definirJogada,
                            linha: 0,
                            coluna: 1,
                            limparBotao: _controlador.limparBotao),
                        BotaoWidget(
                            aoTocar: _controlador.definirJogada,
                            linha: 0,
                            coluna: 2,
                            limparBotao: _controlador.limparBotao),
                        BotaoWidget(
                            aoTocar: _controlador.definirJogada,
                            linha: 1,
                            coluna: 0,
                            limparBotao: _controlador.limparBotao),
                        BotaoWidget(
                            aoTocar: _controlador.definirJogada,
                            linha: 1,
                            coluna: 1,
                            limparBotao: _controlador.limparBotao),
                        BotaoWidget(
                            aoTocar: _controlador.definirJogada,
                            linha: 1,
                            coluna: 2,
                            limparBotao: _controlador.limparBotao),
                        BotaoWidget(
                            aoTocar: _controlador.definirJogada,
                            linha: 2,
                            coluna: 0,
                            limparBotao: _controlador.limparBotao),
                        BotaoWidget(
                            aoTocar: _controlador.definirJogada,
                            linha: 2,
                            coluna: 1,
                            limparBotao: _controlador.limparBotao),
                        BotaoWidget(
                            aoTocar: _controlador.definirJogada,
                            linha: 2,
                            coluna: 2,
                            limparBotao: _controlador.limparBotao),
                      ],
                    ),
                  ))
        ],
      ),
    );
  }
}
