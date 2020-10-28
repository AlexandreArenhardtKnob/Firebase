import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClientesEditar extends StatefulWidget {

  final DocumentSnapshot dadosCliente;
  ClientesEditar(this.dadosCliente);

  @override
  _ClientesEditarState createState() => _ClientesEditarState();
}



class _ClientesEditarState extends State<ClientesEditar> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nomeCliente = TextEditingController();
  TextEditingController emailCliente = TextEditingController();

  @override
  void initState(){
    super.initState();
    if (widget.dadosCliente != null) { // é uma alteração
      nomeCliente.text = widget.dadosCliente.data()["nomeCliente"];
      emailCliente.text = widget.dadosCliente.data()["emailCliente"];
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dadosCliente == null ? "Inclusão de Cliente" : "Alteração de Cliente"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(5),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                controller: nomeCliente,
                decoration: InputDecoration(
                  labelText: "Nome",
                  hintText: "Informe o nome",
                ),
                validator: (valor) {
                  if (valor.isEmpty) {
                    return "Informe o Nome";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailCliente,
                decoration: InputDecoration(
                  labelText: "E-Mail",
                  hintText: "Informe o E-Mail",
                ),
                validator: (valor) {
                  if (valor.isEmpty) {
                    return "Informe o E-Mail";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Gravar"),
                    color: Colors.blue,
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        if (widget.dadosCliente == null) { // é uma inclusão
                          FirebaseFirestore.instance.collection("clientes")
                              .add(
                              {
                                "nomeCliente": nomeCliente.text,
                                "emailCliente": emailCliente.text,
                              }
                          );
                        } else { // é uma alteração
                          FirebaseFirestore.instance.collection("clientes")
                              .doc(widget.dadosCliente.id)
                              .update(
                              {
                                "nomeCliente": nomeCliente.text,
                                "emailCliente": emailCliente.text,
                              }
                          );

                        }
                        Navigator.pop(context);
                      }

                    },
                  ),
                  SizedBox(width: 10,),
                  RaisedButton(
                    child: Text("Cancelar"),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),

        ),
      ),
    );
  }
}
