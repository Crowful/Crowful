import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sylviapp_project/widgets/register_basic_info.dart';
import 'package:sylviapp_project/widgets/register_password.dart';
import 'package:sylviapp_project/widgets/register_user_email.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    int add = 0;
    final PageController registerPageController =
        PageController(initialPage: add);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Create your account',
            style: GoogleFonts.sourceSansPro(
                fontWeight: FontWeight.w700, fontSize: 18),
          ),
          elevation: 0,
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: registerPageController,
          children: [
            UserRegPage(
              height: height,
              width: width,
              previousButton: Expanded(
                child: InkWell(
                    onTap: () {
                      registerPageController.animateToPage(
                          registerPageController.page!.toInt() - 1,
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastOutSlowIn);
                    },
                    child: Text('Back')),
              ),
              nextButton: Expanded(
                child: InkWell(
                    onTap: () {
                      registerPageController.animateToPage(
                          registerPageController.page!.toInt() + 1,
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastOutSlowIn);
                    },
                    child: Center(child: Text('Next'))),
              ),
            ),
            PasswordRegPage(
              height: height,
              width: width,
              previousButton: Expanded(
                child: InkWell(
                    onTap: () {
                      registerPageController.animateToPage(
                          registerPageController.page!.toInt() - 1,
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastOutSlowIn);
                    },
                    child: Text('Back')),
              ),
              nextButton: Expanded(
                child: InkWell(
                    onTap: () {
                      registerPageController.animateToPage(
                          registerPageController.page!.toInt() + 1,
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastOutSlowIn);
                    },
                    child: Center(child: Text('Next'))),
              ),
            ),
            BasicInfoPage()
          ],
        ));
  }
}
