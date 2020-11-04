import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Esqueci extends StatefulWidget {
  @override
  _EsqueciState createState() => _EsqueciState();
}

class _EsqueciState extends State<Esqueci> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffolfKey = GlobalKey<ScaffoldState>();

  TextEditingController usuarioEmail = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolfKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Esqueci Minha Senha !"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(5),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: usuarioEmail,
                decoration: InputDecoration(
                  icon: Icon(Icons.person_outline),
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
              RaisedButton(
                child: Text("Resgatar Senha"),
                onPressed: (){
                  resgatar();

                },
              )

            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> resgatar() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: usuarioEmail.text);
      Navigator.pop(context);
    } catch (erro) {
      SnackBar snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text("Erro ao tentar resgatar a Senha !"),
      );
      scaffolfKey.currentState.showSnackBar(snackBar);
    }
    
  }
  
  
}
