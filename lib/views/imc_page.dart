import 'package:flutter/material.dart';
import 'package:projeto_ebac_imc/controllers/imc_controller.dart';
import 'package:projeto_ebac_imc/models/imc_model.dart';

class IMCPage extends StatefulWidget {
  const IMCPage({super.key});

  @override
  State<IMCPage> createState() => _IMCPageState();
}

class _IMCPageState extends State<IMCPage> {
  IMCController imcController = IMCController();

  @override
  void dispose() {
    //pesoController.dispose();
    //imcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: imcController.pesoController,
                    keyboardType: TextInputType.number,
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(RegExp('[0-9,]')),
                    // ],
                    decoration: const InputDecoration(
                      isDense: true,
                      icon: Icon(
                        Icons.boy,
                        size: 24,
                      ),
                      labelText: 'Peso',
                      hintText: 'Informe seu peso',
                      hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                      suffix: Text('kg'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: imcController.alturaController,
                    keyboardType: TextInputType.number,
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(RegExp('[0-9,]')),
                    // ],
                    decoration: const InputDecoration(
                      isDense: true,
                      icon: Icon(
                        Icons.boy,
                        size: 24,
                      ),
                      labelText: 'Altura',
                      hintText: 'Informe sua altura',
                      hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                      suffix: Text('cm'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: imcController.btnCalcular,
                      builder: (context, value, child) => ElevatedButton(
                        onPressed: !value
                            ? null
                            : () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    IMcModel iMcModel =
                                        imcController.processarIMC();
                                    return AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                      ),
                                      titlePadding: EdgeInsets.zero,
                                      titleTextStyle: const TextStyle(
                                          color: Colors.white, fontSize: 24),
                                      title: const AlertTitle(),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 0),
                                      content: imcController.resultadoIMC ==
                                              -999
                                          ? Center(
                                              heightFactor: 3,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                  Icon(
                                                    Icons.warning,
                                                    size: 40,
                                                    color: Colors.amber,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 15),
                                                    child: Text(
                                                      'Os dados de Peso e/ou Altura não foram informados corretamente.',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ImcAlertItem(
                                                  icon: Icons.boy,
                                                  descricao: 'Peso',
                                                  valorImc: iMcModel.peso,
                                                ),
                                                Divider(
                                                  height: 1,
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                ),
                                                ImcAlertItem(
                                                  icon: Icons.boy,
                                                  descricao: 'Altura',
                                                  valorImc: iMcModel.altura,
                                                ),
                                                Divider(
                                                  height: 1,
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                ),
                                                ImcAlertItem(
                                                  icon:
                                                      Icons.show_chart_outlined,
                                                  descricao: 'IMC',
                                                  valorImc: imcController
                                                      .resultadoIMC,
                                                ),
                                                Divider(
                                                  height: 1,
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 8,
                                                    horizontal: 10,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'Nível IMC',
                                                        style: TextStyle(
                                                          color: Colors.indigo,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        iMcModel.mensagem,
                                                        style: const TextStyle(
                                                          color: Colors.indigo,
                                                          fontSize: 14,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            FocusManager.instance.primaryFocus!
                                                .unfocus();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                        child: const Text('CALCULAR IMC'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImcAlertItem extends StatelessWidget {
  const ImcAlertItem({
    super.key,
    required this.icon,
    required this.descricao,
    required this.valorImc,
  });
  final IconData icon;
  final String descricao;
  final double valorImc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.indigo,
      ),
      tileColor: Colors.grey.withOpacity(0.1),
      title: Text(
        descricao,
        style: const TextStyle(
          color: Colors.indigo,
          fontSize: 20,
        ),
      ),
      trailing: Text(
        valorImc.toString(),
        style: const TextStyle(
          color: Colors.indigo,
          fontSize: 20,
        ),
      ),
    );
  }
}

class AlertTitle extends StatelessWidget {
  const AlertTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: const Center(
        child: Text(
          'Resultado IMC',
        ),
      ),
    );
  }
}
