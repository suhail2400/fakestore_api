import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store/consts/global_colors.dart';
import 'package:store/models/product_model.dart';
import 'package:store/screens/categories_screen.dart';
import 'package:store/screens/users_screen.dart';
import 'package:store/services/api_handler.dart';
import 'package:store/widgets/feeds_grid.dart';
import 'package:store/widgets/feeds_widget.dart';
import 'package:store/widgets/sale_widget.dart';

import '../widgets/appbar_icons.dart';
import 'feeds_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  late TextEditingController  _textEditingController;
  // List<ProductsModel> productsList = [];
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
  // @override
  // void didChangeDependencies() {
  //   getProducts();
  //   super.didChangeDependencies();
  // }

  // Future<void> getProducts() async {
  //   productsList = await   APIHandler.getAllProducts();
  //   setState(() {});
  // }
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child:Scaffold(
        appBar: AppBar(title: const Text('Home'),
        leading: AppBarIcons(
          function: (){
             Navigator.push(
            context,
            PageTransition(child: const CategoriesScreen(), type: PageTransitionType.fade)
            );
          },
          icon:IconlyBold.category,
          ),
          actions: [
            AppBarIcons(
              function:(){
            Navigator.push(
            context,
            PageTransition(child: const UsersScreen(), type: PageTransitionType.fade)
            );
              }, 
              icon:IconlyBold.user3
              ),
          ],
          ),
          body:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              SizedBox(height:18 ,),
              TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText:"Search",
                  filled:true,
                  fillColor: Theme.of(context).cardColor,
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 1,
                  color: Theme.of(context).cardColor,
                  )
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderRadius:BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 1,
                      color:Theme.of(context).colorScheme.secondary
                      )
                     ),
                     suffixIcon: Icon(IconlyLight.search, color:lightIconsColor), 
                  ),
              ),
              SizedBox(height: 18,),
              Expanded(child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                height: size.height *0.25,
                child: Swiper(itemCount: 3,itemBuilder:(context, index) {
                  return const SaleWidget();
                },
                autoplay: true,
                pagination: const SwiperPagination(
                  alignment:Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: Colors.red,)
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(8),
              child: Row(children: [
                const Text('Latest Products',
                style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                ),
                const Spacer(),
                AppBarIcons(function: (){
                  Navigator.push(context,PageTransition(type:PageTransitionType.fade,
                  child:  FeedsScreen()
                  ));
                }, icon:IconlyBold.arrowRight2)
              ]),
              ),
              FutureBuilder<List<ProductsModel>>(
                future:APIHandler.getAllProducts(limit: 3.toString()) ,
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
                return FeedsGridWidget(productsList: snapshot.data!);
              })
                  ],
                ),
              ))
            ],),
          )
        ),
      );
  }
}
