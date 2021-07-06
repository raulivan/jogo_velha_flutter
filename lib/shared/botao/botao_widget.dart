import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jogodavelha/core/app_colors.dart';

class BotaoWidget extends StatefulWidget {
  Function aoTocar;
  int linha;
  int coluna;
  bool limparBotao;

  BotaoWidget(
      {Key? key,
      required this.aoTocar,
      required this.linha,
      required this.coluna,
      required this.limparBotao})
      : super(key: key);

  @override
  _BotaoWidgetState createState() => _BotaoWidgetState();
}

class _BotaoWidgetState extends State<BotaoWidget> {
  String textoBotao = '';

  @override
  Widget build(BuildContext context) {
    if (widget.limparBotao == true) {
      textoBotao = '';
    }
    return Padding(
        padding: EdgeInsets.all(3),
        child: GestureDetector(
          onTap: () {
            var retorno = widget.aoTocar(context, widget.linha, widget.coluna);
            if ('X,O'.split(',').indexOf(retorno) == -1) {
              toast(retorno);
            } else {
              textoBotao = retorno;
              setState(() {});
            }
          },
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: AppColors.azul,
              border: Border.all(color: AppColors.preto, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(textoBotao,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ),
        ));
  }

  void toast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: AppColors.vermelho,
        textColor: AppColors.branco,
        fontSize: 20.0);
  }
}
