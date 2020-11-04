import 'package:cadastrosi2020/esqueci.dart';
import 'package:cadastrosi2020/registrar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'menu.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //FirebaseFirestore.instance.collection("clientes").doc().set({"nomeCliente":"Funcionou curso SI","emailCliente":"teste@funcionou.com.br"});


  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffolfKey = GlobalKey<ScaffoldState>();

  TextEditingController usuarioEmail = TextEditingController();
  TextEditingController usuarioSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolfKey,

      appBar: AppBar(
        backgroundColor:  Colors.lightGreen,
        title: Text("CRUD Firebase - SI"),
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
                    child: Text("Logar"),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        logar();
                      }

                    },
                  )

                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  textColor: Colors.blue,
                  child: Text("Esqueci minha Senha"),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Esqueci()),
                    );
                  },
                ),
                FlatButton(
                  textColor: Colors.blue,
                  child: Text("Registrar"),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registrar()),
                    );
                  },
                ),
                RaisedButton(
                  child: Text("Menu"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Menu()),
                    );
                  }
                  ,
                )
              ],
            ),

          ],
        ),
      ),
    );
  }


  Future<void> logar() async {

    loading();

    try {
      UserCredential usuario = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: usuarioEmail.text,
          password: usuarioSenha.text);
      Navigator.pop(context); // fecha a janela do Loading
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Menu()),
      );
    } catch (erro) {
      Navigator.pop(context); // fecha a janela do Loading
      SnackBar snackbar = SnackBar(
        backgroundColor: Colors.red,
        content: Text("Erro ao Fazer Login"),
      );
      scaffolfKey.currentState.showSnackBar(snackbar);

    }

  }

  void loading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Color(0),
          child: new Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
            padding: EdgeInsets.all(10),
            height: 70,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                new CircularProgressIndicator(),
                SizedBox(
                  width: 30,
                ),
                new Text(" Verificando ..."),
              ],
            ),
          ),
        );
      },
    );
  }

}
