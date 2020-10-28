import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registrar extends StatefulWidget {
  @override
  _RegistrarState createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffolfKey = GlobalKey<ScaffoldState>();

  TextEditingController usuarioEmail = TextEditingController();
  TextEditingController usuarioSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolfKey,

      appBar: AppBar(
        backgroundColor:  Colors.redAccent,
        title: Text("Registro de Usuário"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: usuarioEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email,color: Colors.blue,),
                        labelText: "E-Mail"
                    ),
                    validator: (valor) {
                      if (valor.isEmpty) {
                        return "Informe o E-Mail";
                      } else if (!usuarioEmail.text.contains("@"))  {
                        return "Informe um E-Mail Válido !";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: usuarioSenha,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock_outline,color: Colors.blue,),
                        labelText: "Senha"
                    ),
                    validator: (valor) {
                      if (valor.isEmpty) {
                        return "Informe a Senha";
                      } else {
                        return null;
                      }
                    },
                  ),
                  RaisedButton(
                    child: Text("Registrar"),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        registrar();
                      }
                    },
                  )

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future<void> registrar() async {
    try {
      UserCredential usuario = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: usuarioEmail.text,
          password: usuarioSenha.text);
      usuario.credential;

      Navigator.pop(context); // fecha a janela do Loading

    } catch (erro) {
      Navigator.pop(context); // fecha a janela do Loading
      SnackBar snackbar = SnackBar(
        backgroundColor: Colors.red,
        content: Text("Erro ao Fazer Login"),
      );
      scaffolfKey.currentState.showSnackBar(snackbar);

    }

  }

}
