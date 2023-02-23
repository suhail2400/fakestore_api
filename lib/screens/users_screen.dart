import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/models/category_model.dart';
import 'package:store/models/user_model.dart';
import 'package:store/widgets/category_widget.dart';
import 'package:store/widgets/users_widget.dart';

import '../services/api_handler.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
      ),
      body:
              FutureBuilder<List<UsersModel>>(
                future:APIHandler.getAllUsers() ,
                builder:(context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(),);
                }
                else if(snapshot.hasError){
                  Center(child:Text("An error occured ${snapshot.error}"),);
                }
                else if(snapshot.data == null){
                  Center(child:Text("No products has added"),);
                }                
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder:((context, index) {
                  return ChangeNotifierProvider.value(
                    value:snapshot.data![index],
                    child: const UserWidget()
                    );
                }));
                },),
  );
  }
}