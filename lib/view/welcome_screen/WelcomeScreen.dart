import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/assets.dart';
import 'package:smart_mosque/constants/strings.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/view/components/custom_button.dart';


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late int _index;
  late List<Map<String, String>> page;

  @override
  void initState() {
    super.initState();
    // OneSignal.shared.sendTag('test', 'coba coba');
    _index = 0;
    page = [
      {
        'image': Assets.onboardAsset0,
        'text': Strings.onboard0,
      },
      {
        'image': Assets.onboardAsset1,
        'text': Strings.onboard1,
      },
      {
        'image': Assets.onboardAsset2,
        'text': Strings.onboard2,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(dimensPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    height: 370,
                    child: PageView(
                      onPageChanged: (index) {
                        _index = index;
                        setState(() {});
                      },
                      children: page.map((e) {
                        return Column(
                          children: [
                            Text(
                              Strings.appName,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                            Text(
                              e['text']!,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 270,
                              width: 400,
                              child: Image.asset(e['image']!),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          page.length, (index) => buildDot(index: index)),
                    ),
                  ),
                ],
              ),
              CustomButton(
                label: Strings.login,
                onPressed: () {
                  AutoRouter.of(context).push(LoginRoute());
                },
                color: kPrimaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: _index == index ? 20 : 6,
      decoration: BoxDecoration(
          color: _index == index ? kPrimaryColor : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}