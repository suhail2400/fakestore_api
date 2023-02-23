import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store/consts/global_colors.dart';
import 'package:store/models/product_model.dart';
import 'package:store/screens/feeds_screen.dart';
import 'package:store/services/api_handler.dart';
import 'package:store/widgets/appbar_icons.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  bool isError = false;
  ProductsModel? productsModel;
  Future<void> getProductInfo () async {
    try {
    productsModel = await APIHandler.getProductById(id:widget.id);
    } catch (error) {
      log("error $error");
    }
    setState(() {});
  }  

  @override
  void didChangeDependencies() {
    getProductInfo();
    super.didChangeDependencies();
    
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(child:isError ?
      const Center(child: Text('An error occured', style: TextStyle(
        fontSize: 24,fontWeight: FontWeight.w600,
      )),)
      :productsModel == null? Center(child: CircularProgressIndicator(),):
      SingleChildScrollView(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18,),
            const BackButton(),
            Padding(padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(productsModel!.category!.name.toString(), style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                const SizedBox(height: 18,),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Text(productsModel!.title.toString(),textAlign: TextAlign.start,style: titleStyle,),
                    ),
                    Flexible(
                      flex: 1,
                      child: RichText(text:TextSpan(text:'\$', style: const TextStyle(fontSize: 25,color:Color.fromRGBO(33, 150, 243, 1)),
                      children: <TextSpan>[
                        TextSpan(text:productsModel!.price.toString(), style: TextStyle(
                          color:lightTextColor,
                          fontWeight: FontWeight.bold
                        ))
                      ]
                      )),                    
                    )
                  ],
                  ),
                  const SizedBox(height: 18,),
              ],
            ),
            ),
            SizedBox(
              height: size.height * 0.4,
              child:Swiper(
                itemBuilder: (BuildContext context, int index){
                  return FancyShimmerImage(
                    width: double.infinity,
                  imageUrl:productsModel!.images![index].toString(),
                    boxFit: BoxFit.fill,
                    );
                },

                autoplay: true,
                itemCount: 3,
                pagination:const SwiperPagination(
                  alignment:Alignment.bottomCenter,
                  builder:DotSwiperPaginationBuilder(
                    color:Colors.white,
                    activeColor: Colors.red
                  )
                ),
              )
            ),
            SizedBox(height: 18,),
            Padding(padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start ,
              children: [
                Text('Description', style:titleStyle),
                const SizedBox(height:18,),
                Text(productsModel!.description.toString(),
                textAlign: TextAlign.start,
                style:TextStyle(fontSize: 25)
                )
              ],
            ),
            )
          ],
        )
      )),
    );
  }
}