import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/models/category_model.dart';
import 'package:store/widgets/category_widget.dart';

import '../services/api_handler.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body:
              FutureBuilder<List<CategoriesModel>>(
                future:APIHandler.getAllCategories() ,
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
                return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount:snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 0.0, mainAxisSpacing: 0.0, childAspectRatio:1.2), 
                itemBuilder:((context, index) {
                return ChangeNotifierProvider.value(
                  value:snapshot.data![index],
                  child: CategoryWidget());
              }));
                },),
  );
  }
}