import 'package:flutter/material.dart';

class CalculationScreen extends StatefulWidget {
  const CalculationScreen({super.key});

  @override
  State<CalculationScreen> createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  final List<TextEditingController> _numeradorControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ]; // Inicialmente com três controladores para o numerador
  List<TextEditingController> _denominadorControllers = [];

  TextEditingController _nTermoController = TextEditingController(); // Controlador para o enésimo termo

  String termoGeralNumerador = '';
  String termoGeralDenominador = '';
  String termo_n = '';

  bool  _showFractionFields = false; // Controle para mostrar/ocultar os campos de fração
  void clearfields(){
    // Limpa os campos de entrada após o cálculo
    for (var controller in _numeradorControllers) {
      controller.clear();
    }
    for (var controller in _denominadorControllers) {
      controller.clear();
    }
    _nTermoController.clear();
  }
  // Função para calcular o termo geral e o enésimo termo
  void calcular() {
    List<int> numeradores = [];
    List<int> denominadores = [];

    // numeradores
    for (var controller in _numeradorControllers) {
      String input = controller.text;
      if (input.isNotEmpty) {
        numeradores.add(int.parse(input));
      }
    }

    // denominadores, se forem activos
    if (_showFractionFields) {
      for (var controller in _denominadorControllers) {
        String input = controller.text;
        if (input.isNotEmpty) {
          denominadores.add(int.parse(input));
        }
      }
    }

    // Verifica se os campos foram preenchidos corretamente
    if (numeradores.length < 2 || (_showFractionFields && denominadores.length < 2)) {
      setState(() {
        termoGeralNumerador = "ADICIONE PELO MENOS 2 TERMOS";
        termoGeralDenominador = 'ADICIONE PELO MENOS 2 TERMOS';
        termo_n = '';
      });
      return;
    } 
    /*else if (_showFractionFields) {
        if(numeradores.length != denominadores.length)
        {
          setState(() {
            termoGeralNumerador = "A quantidade de termos precisa de ser a mesma";
            termoGeralDenominador = 'A quantidade de termos precisa de ser a mesma';
            termo_n = '';
          });
        }
        return;
      }*/

    // Calculo da razão
    int rNumerador = numeradores[1] - numeradores[0];
    int a1Numerador = numeradores[0];

    int? rDenominador;
    int? a1Denominador;

    if (_showFractionFields) {
      rDenominador = denominadores[1] - denominadores[0];
      a1Denominador = denominadores[0];
    }

    // Calcula o enésimo termo, se o campo for preenchido
    int? nTermo;
    if (_nTermoController.text.isNotEmpty) {
      nTermo = int.parse(_nTermoController.text);
    }

    // Calculo do termo geral
    setState(() {
      //termoGeralNumerador = '$a1Numerador + (n-1) * $rNumerador';
      // termoGeralNumerador = '$a1Numerador + (n-1) * $rNumerador';
      int val =a1Numerador-rNumerador;
      
      termoGeralNumerador =' $rNumerador n $val';
      if (_showFractionFields) {
        //termoGeralDenominador = '$a1Denominador + (n-1) * $rDenominador';
        int val_ = a1Denominador! - rDenominador!;
        if (_showFractionFields) {
          rDenominador = denominadores[1] - denominadores[0];
          
          a1Denominador = denominadores[0];
        }

        termoGeralDenominador =' $rDenominador n $val_';
      }

      // Calcula o n-ésimo termo, se fornecido
      if (nTermo != null) {
        int termoNumerador = a1Numerador + (nTermo - 1) * rNumerador;
        String termoDenominador = _showFractionFields ? '${a1Denominador! + (nTermo - 1) * rDenominador!}' 
        : '1'; // Se não houver denominador, assume-se que seja 1

        termo_n = '$termoNumerador / $termoDenominador';
      } else {
        termo_n = '';
      }
    });

    /*

    if (_showFractionFields) {
      for (var controller in _denominadorControllers) {
        controller.clear();
      }
    }*/
  }
  
  // Função para adicionar campos de fração
  void toggleFractionFields() {
    setState(() {
      _showFractionFields = !_showFractionFields;

      // Se os campos de fração estiverem ativos, adicione os controladores para denominadores
      if (_showFractionFields) {
        _denominadorControllers = [
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
        ];
      } else {
        _denominadorControllers.clear(); // Remove os denominadores quando a fração for desativada
      }
    });
  }

  // Função para adicionar um campo de texto ao clicar no "+"
  void adicionarCampo() {
    setState(() {
      _numeradorControllers.add(TextEditingController());
      if (_showFractionFields) {
        _denominadorControllers.add(TextEditingController());
      }
    });
  }

  // Função para remover o último campo de texto ao clicar no "-"
  void removerCampo() {
    if (_numeradorControllers.length > 1) {
      setState(() {
        _numeradorControllers.removeLast();
        if (_showFractionFields && _denominadorControllers.isNotEmpty) {
          _denominadorControllers.removeLast();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Cálculo de Sucessão'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Digite a sequência que pretende calcular',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(height: 20),
            const Text("Numerador", style: TextStyle(fontSize: 17)),
            Wrap(
              spacing: 10,
              children: [
                for (var controller in _numeradorControllers)
                  SizedBox(
                    width: 50,
                    child: TextField(
                      controller: controller,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            if (_showFractionFields) ...[
              const Text("Denominador", style: TextStyle(fontSize: 17)),
              Wrap(
                spacing: 10,
                children: [
                  for (var controller in _denominadorControllers)
                    SizedBox(
                      width: 50,
                      child: TextField(
                        controller: controller,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                ],
              ),
            ],
            const SizedBox(height: 20),
            const Text("Enésimo termo (opcional)", style: TextStyle(fontSize: 17)),
            SizedBox(
              width: 50,
              child: TextField(
                controller: _nTermoController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 TextButton(
                  onPressed: clearfields,
                  child: const Text("Limpar"),
                ),
                IconButton(
                  onPressed: adicionarCampo,
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  onPressed: removerCampo,
                  icon: const Icon(Icons.remove),
                ),
                TextButton(
                  onPressed: toggleFractionFields,
                  child: const Text("Fracção"),
                ),
               
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcular,
              child: const Text(
                'Calcular',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 17),
              ),
            ),
            const SizedBox(height: 20),
            if (termoGeralNumerador.isNotEmpty) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Termo Geral (Numerador): $termoGeralNumerador',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 15),
                    ),
                  ),
                  if (_showFractionFields)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Termo Geral (Denominador): $termoGeralDenominador',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 15),
                      ),
                    ),
                  if (termo_n.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'n-esimo Termo: $termo_n',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 15),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
