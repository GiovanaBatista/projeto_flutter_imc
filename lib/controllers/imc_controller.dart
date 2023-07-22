import 'package:flutter/material.dart';
import 'package:projeto_ebac_imc/models/imc_model.dart';

class IMCController {
  IMCController() {
    pesoController.addListener(() {
      _habilitaBotao();
    });
    alturaController.addListener(() {
      _habilitaBotao();
    });
  }

  final pesoController = TextEditingController();
  final alturaController = TextEditingController();

  double resultadoIMC = 0;
  ValueNotifier<bool> btnCalcular = ValueNotifier(false);

  void _habilitaBotao() {
    btnCalcular.value = pesoController.value.text.isNotEmpty &&
        alturaController.value.text.isNotEmpty;
  }

  //Faz o calculo do IMC
  double _calcularIMC() {
    try {
      double peso =
          double.parse(pesoController.value.text.replaceAll(',', '.'));
      double altura =
          double.parse(alturaController.value.text.replaceAll(',', '.'));

      double valorIMC = peso / ((altura / 100) * (altura / 100));

      return valorIMC;
    } catch (e) {
      return -999;
    }
  }

  //Processa os valores do IMC e passa para a model
  IMcModel processarIMC() {
    resultadoIMC = double.tryParse(_calcularIMC().toStringAsFixed(2)) as double;

    if (resultadoIMC == -999) {
      return IMcModel(peso: 0, altura: 0, mensagem: '');
    }

    var mensagemIMC = _obterMensagemIMC(resultadoIMC);

    IMcModel iMcModel = IMcModel(
      peso: double.parse(pesoController.value.text.replaceAll(',', '.')),
      altura: double.parse(alturaController.value.text.replaceAll(',', '.')),
      mensagem: mensagemIMC,
    );

    return iMcModel;
  }

  //Obtém a mensagem sobre o resultado do IMC
  String _obterMensagemIMC(double valorIMC) {
    if (valorIMC < 16) {
      return 'Baixo peso muito grave = abaixo de 16 kg/m²';
    }

    if (valorIMC >= 16 && valorIMC <= 16.99) {
      return 'Baixo peso grave = entre 16 e 16,99 kg/m²';
    }

    if (valorIMC >= 17 && valorIMC <= 18.49) {
      return 'Baixo peso = entre 17 e 18,49 kg/m²';
    }

    if (valorIMC >= 18.50 && valorIMC <= 24.99) {
      return 'Peso normal = entre 18.50 e 24,99 kg/m²';
    }

    if (valorIMC >= 25 && valorIMC <= 29.99) {
      return 'Sobrepeso = entre 25 e 29,99 kg/m²';
    }

    if (valorIMC >= 30 && valorIMC <= 34.99) {
      return 'Obsesidade Grau I = entre 30 e 34,99 kg/m²';
    }

    if (valorIMC >= 35 && valorIMC <= 39.99) {
      return 'Obsesidade Grau II = entre 35 e 39,99 kg/m²';
    }

    return 'Obsesidade Grau III (obsidede mórbida) = maior que 40 kg/m²';
  }
}
