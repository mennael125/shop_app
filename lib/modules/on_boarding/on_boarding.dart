import 'package:e_commerce_payment/modeles/onboarding_model/onboarding_model.dart';
import 'package:e_commerce_payment/modules/login/login.dart';
import 'package:e_commerce_payment/shared/componentes/componentes.dart';
import 'package:e_commerce_payment/shared/network/local/cache_helper.dart';
import 'package:e_commerce_payment/shared/styles/colors.dart';
import 'package:flutter/material.dart';


import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<OnBoardingModel> items = [
    OnBoardingModel(
        image: 'assets/images/buying.jpg',
        title: 'Welcome',
        body   : 'Buy easily'),
    OnBoardingModel(
        image: 'assets/images/search.jpg',
        title: 'Search',
        body: 'Search for a product you want to buy'),
    OnBoardingModel(
        image: 'assets/images/payment.jpg',
        title: 'Payment',
        body: 'Enjoy easy bill payments '),
  ];
  var controller = PageController();
  bool isLast = false;

  void submit() {
    CacheHelper.savetData(
        key: 'onBoardingSkip',
        value: true)
        .then((value) {
      if (value) {
        pushAndRemove(widget:
        LoginScreen(), context: context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [textButton(fun: submit, text: 'skip')],
      ),
      body: PageView.builder(
        onPageChanged: (index) {
          if (index == items.length - 1) {
            setState(() {
              isLast = true;
            });
          } else {
            setState(() {
              isLast = false;
            });
          }
        },
        controller:controller,
        itemBuilder: (context, index) => onBoarding(items[index]),
        physics: BouncingScrollPhysics(),
        itemCount: items.length,
      ),
    );
  }

  Widget onBoarding(OnBoardingModel model) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(child: Image(image: AssetImage(model.image!))),
        SizedBox(
          height: 30,
        ),
        Text(
          '${model.title!} ',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          '${model.body!} ',
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.grey),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            SmoothPageIndicator(
              controller: controller, // PageController
              count: items.length,

              effect: ExpandingDotsEffect(
                dotColor: Colors.grey,
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: defaultColor,
                radius: 5,
              ), // your preferred effect
            ),

            Spacer(),
            FloatingActionButton(
              onPressed: () {
                if (isLast) {
                  submit();
                } else {
                  controller.nextPage(
                    duration: Duration(milliseconds: 750),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                }
              },
              child: Icon(Icons.arrow_forward_ios_outlined),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
      ],
    ),
  );
}
