import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //chave do form 

  final _formKey = GlobalKey<FormState>();

  //variaveis
  double taxa = 0;
  double totalConta = 0;
  double totalPagar = 0;
  double comissao = 0;
  int qtdPessoas = 0;

  //textControllers

  TextEditingController txtTotal = TextEditingController();
  TextEditingController txtQtd = TextEditingController();

  //metodos

  void calcularConta() {
    setState(() {
      totalConta = double.parse(txtTotal.text);
      qtdPessoas = int.parse(txtQtd.text);
      comissao = (taxa * totalConta) / 100;
      totalPagar = (totalConta + comissao) / qtdPessoas;

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Total a pagar por Pessoa"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      "assets/smile.svg",
                      width: 60,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("O TOTAL DA CONTA: R\$ $totalConta "),
                    SizedBox(
                      height: 20,
                    ),
                    Text("TAXA DO GARÇOM: R\$ $comissao "),
                    SizedBox(
                      height: 20,
                    ),
                    Text("O TOTAL POR PESSOA: R\$ $totalPagar ")
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Color.fromARGB(255, 255, 2, 2)),
                  )
                ],
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RACHA CONTA'),
        centerTitle: true, //para centralizar titulo
        backgroundColor: Color.fromARGB(255, 255, 2, 2),
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: SvgPicture.asset("assets/money.svg", width: 100),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: txtTotal,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: "Total da conta"),
                  style: TextStyle(fontSize: 18),
                  validator: (valor){
                    if(valor!.isEmpty) return "Campo obrigátorio";
                    else{
                      return  null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Taxa de serviços %: ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Slider(
                        min: 0,
                        max: 10,
                        label: "$taxa %",
                        divisions: 10,
                        value: taxa,
                        activeColor: Color.fromARGB(255, 255, 2, 2),
                        inactiveColor: const Color.fromARGB(255, 214, 214, 214),
                        onChanged: (double valor) {
                          setState(() {
                            taxa = valor;
                          });
                        }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: txtQtd,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: "Qtd. pessoas"),
                  style: TextStyle(fontSize: 18),
                  validator: (valor){
                    if(valor!.isEmpty) return "Campo obrigátorio";
                    else{
                      return  null;
                    }
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 255, 2, 2),
                          onPrimary: Colors.white),
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          calcularConta();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
