import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Clientes extends StatefulWidget {
  @override
  _ClientesState createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Clientes"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("clientes").orderBy("nomeCliente", descending:false).snapshots(),
                builder: (context, snapshot) {
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                    case ConnectionState.done:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      if (snapshot.data.documents.length==0){ //
                        return Center(
                          child: Text("Não há dados!",style: TextStyle(color: Colors.redAccent,fontSize: 20),),
                        );
                      }
                      return ListView.builder(

                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            return Card( // Lista os produtos
                                child: ListTile(
                                  //snapshot.data.documents[index].documentID.toString() - pega o ID
                                  title: Text(snapshot.data.documents[index].data()["nomeCliente"].toString(),style: TextStyle(fontSize: 20)),
                                  subtitle: Text(snapshot.data.documents[index].data()["emailCliente"].toString(),style: TextStyle(fontSize: 20)),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        color: Colors.blueAccent,
                                        onPressed: () {
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ClientesEditar(snapshot.data.documents[index])));
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        color: Colors.redAccent,
                                        onPressed: () {
                                         // confirmaExclusao(context, index, snapshot);
                                        },
                                      ),
                                    ],
                                  ),
                                ));
                          }
                      );
                  }
                }
            ),
          ),

        ],
      ),

    );
  }
}
