import 'package:e_commerce_payment/modeles/categories_model/categories.dart';
import 'package:e_commerce_payment/shared/cubits/ecommerce_cubit/ecommerce_cubit.dart';
import 'package:e_commerce_payment/shared/cubits/ecommerce_cubit/ecommerce_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ECommerceCubit, ECommerceStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => rowBuild(ECommerceCubit.get(context)
                .categoryModel!
                .categoryData!
                .dataInfo[index]),
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: ECommerceCubit.get(context)
                .categoryModel!
                .categoryData!
                .dataInfo
                .length);
      },
    );
  }
}

Widget rowBuild(DataInfo model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: Image(
              image: NetworkImage(
                '${model.image}',
              ),
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            '${model.name}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          Spacer(),
          Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
