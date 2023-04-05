import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peace_time/constant.dart';

class AppInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About".toUpperCase()),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.info_outline_rounded),
          )
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Constant.APPICON_SVG,
              width: MediaQuery.of(context).size.width / 5, fit: BoxFit.contain
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Peace Time",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                // color: Colors.grey[400]
              ),
            ),
            Text(
              "Version: 15.0.0",
              style: TextStyle(
                  // fontWeight: FontWeight.w700,
                  color: Theme.of(context).disabledColor),
            )
          ],
        ),
      ),
    );
  }
}
