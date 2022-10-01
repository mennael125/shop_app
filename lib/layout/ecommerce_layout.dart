import 'package:e_commerce_payment/modules/cart/cart_screen.dart';
import 'package:e_commerce_payment/modules/search/search.dart';
import 'package:e_commerce_payment/shared/componentes/componentes.dart';
import 'package:e_commerce_payment/shared/cubits/ecommerce_cubit/ecommerce_cubit.dart';
import 'package:e_commerce_payment/shared/cubits/ecommerce_cubit/ecommerce_states.dart';
import 'package:e_commerce_payment/shared/styles/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ECommerceLayout extends StatelessWidget {
  const ECommerceLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ECommerceCubit, ECommerceStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ECommerceCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('Salla'),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo( widget: SearchScreen(), context:  context);
                  },
                  icon: Icon(Icons.search),
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.star), label: 'Favorites'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings')
              ],
              onTap: (index) {
                cubit.change(index);
              },
              currentIndex: cubit.currentIndex,
            ),
            floatingActionButton: (CircleAvatar(
              backgroundColor: defaultColor,
              radius: 20,
              child: FloatingActionButton(onPressed: () {
                navigateTo( context: context, widget:  CartScreen ());

              },
              child:  Icon(Icons.local_grocery_store_outlined , color: Colors.grey[350],)

                ,),
            )),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: cubit.screens[cubit.currentIndex],
          );
        });
  }
}
