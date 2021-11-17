import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sylviapp_project/providers/providers.dart';
import 'package:sylviapp_project/translations/locale_keys.g.dart';

class SettingsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    String _chosenValue = "";
    onLanguageChange() async {
      if (_chosenValue == "Filipino") {
        await context.setLocale(Locale('fil'));
      } else if (_chosenValue == "English") {
        await context.setLocale(Locale('en'));
      }
    }

    final isDark = watch(themingProvider);
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xff65BFB8),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Color(0xff403d55),
                ),
                Text(
                  'Sylviapp',
                  style: TextStyle(
                      color: Color(0xff65BFB8),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.bookmark_outline),
                  onPressed: () {},
                  color: Colors.transparent,
                ),
              ]),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Settings",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 35,
                padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(children: [
                      WidgetSpan(
                          child: Icon(
                        Icons.dark_mode,
                        size: 18,
                      )),
                      TextSpan(
                        text: "    " + LocaleKeys.DarkMode.tr(),
                      )
                    ])),
                    Switch(
                        value: isDark.darkTheme,
                        onChanged: (value) {
                          context.read(themingProvider).toggleTheme();
                        },
                        activeTrackColor: Color(0xff65BFB8),
                        activeColor: Colors.white),
                  ],
                ),
              ),
              Divider(),
              Container(
                height: 30,
                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(children: [
                      WidgetSpan(
                          child: Icon(
                        Icons.language,
                        size: 17,
                      )),
                      TextSpan(
                        text: '    ' + LocaleKeys.changeLanguage.tr(),
                      )
                    ])),
                    DropdownButton<String>(
                      // ignore: unrelated_type_equality_checks
                      value: null,
                      style: const TextStyle(color: Colors.white),
                      items: <String>['Filipino', 'English']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) async {
                        _chosenValue = value!;
                        onLanguageChange();
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                height: 30,
                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(children: [
                      WidgetSpan(
                          child: Icon(
                        Icons.privacy_tip,
                        size: 17,
                      )),
                      TextSpan(
                        text: '    ' + LocaleKeys.privacy.tr(),
                      )
                    ])),
                  ],
                ),
              ),
              Divider(),
              Container(
                height: 30,
                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(children: [
                      WidgetSpan(
                          child: Icon(
                        Icons.info_rounded,
                        size: 17,
                      )),
                      TextSpan(
                        text: '    ' + LocaleKeys.aboutus.tr(),
                      )
                    ])),
                  ],
                ),
              ),
              Divider(),
              Container(
                height: 30,
                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(children: [
                      WidgetSpan(
                          child: Icon(
                        Icons.feedback,
                        color: Colors.red,
                        size: 17,
                      )),
                      TextSpan(
                          text: '    ' + LocaleKeys.sendfeedback.tr(),
                          style: TextStyle(
                            color: Colors.red,
                          ))
                    ])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
