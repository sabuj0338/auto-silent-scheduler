import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:peace_time/NavigationScreen.dart';
import 'package:peace_time/constant.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/controller/SettingsController.dart';
import 'package:flutter/foundation.dart';

class AppIntroductionScreen extends StatefulWidget {
  @override
  _AppIntroductionScreenState createState() => _AppIntroductionScreenState();
}

class _AppIntroductionScreenState extends State<AppIntroductionScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    if (await SettingsController.getPermissionStatus() == false) {
      await SettingsController.openDoNotDisturbSettings();
    } else {
      await DBController.toggleIntroductionScreenStatus(false);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => NavigationScreen()));
    }
  }

  Widget _buildImage({String assetName = "", double width = 100.0}) {
    return Align(
      child: Image.asset(assetName, width: width),
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      // pageColor: Colors.white,
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
      fullScreen: false,
    );

    return IntroductionScreen(
      key: introKey,
      // globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // globalHeader: Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 16, right: 16),
      //       child: _buildImage('flutter.png',),
      //     ),
      //   ),
      // ),
      // globalFooter: SizedBox(
      //   width: double.infinity,
      //   height: 60,
      //   child: ElevatedButton(
      //     child: const Text(
      //       'Let\'s go right away!',
      //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      //     ),
      //     onPressed: () => _onIntroEnd(context),
      //   ),
      // ),
      pages: [
        PageViewModel(
          title: "Welcome",
          body:
              "Keep your phone silent\n when you are busy and stay safe from embarrassing moments.",
          image: _buildImage(assetName: Constant.APPICON),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Quick Silent",
          body:
              "One tap to silent your phone from now to next 30 or custom minutes.",
          image: _buildImage(assetName: Constant.APPICON),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Only Permission",
          body:
              "Please allow do not disturb mode.\n Otherwise, your phone will not turn on silent or vibrate mode according to your schedule.",
          image: _buildImage(assetName: 'assets/donotdisturb.png', width: 300),
          footer: OutlinedButton(
            onPressed: () async =>
                await SettingsController.openDoNotDisturbSettings(),
            child: Text(
              'Open Settings',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            autofocus: true,
            style: OutlinedButton.styleFrom(
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10)),
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: Icon(
        Icons.arrow_back,
        color: Theme.of(context).primaryColor,
      ),
      skip: Text(
        'SKIP',
        style: TextStyle(
            fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
      ),
      next: Icon(
        Icons.arrow_forward,
        color: Theme.of(context).primaryColor,
      ),
      done: Text(
        'DONE',
        style: TextStyle(
            fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        // color: Colors.black45,
        // activeColor: Colors.black,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      // dotsContainerDecorator: const ShapeDecoration(
      //   color: Colors.transparent,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
      //   ),
      // ),
    );
  }
}
