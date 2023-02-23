import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:store/consts/global_colors.dart';

import '../models/user_model.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  usersModelProvider = Provider.of<UsersModel>(context);
    Size size = MediaQuery.of(context).size;
    return ListTile(
      leading: FancyShimmerImage(
                  height:size.width * 0.15,
                  width: size.width * 0.15,
                  errorWidget: const Icon(IconlyBold.danger, color:Colors.red,size: 28,),
                  imageUrl:usersModelProvider.avatar.toString(),
                  boxFit:BoxFit.fill,
                ), 
      title: Text(usersModelProvider.name.toString()),
      subtitle:  Text(usersModelProvider.email.toString()),
      trailing:  Text(usersModelProvider.role.toString(),
      style: TextStyle(
        color:Colors.grey,
        fontWeight: FontWeight.bold,
      ),
      ),
    );
  }
}