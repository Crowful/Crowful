<<<<<<< HEAD
import 'package:date_format/date_format.dart';
=======
import 'package:cloud_firestore/cloud_firestore.dart';
>>>>>>> a888738237e53f6e6bec7ff91fe2961e7aa88b23
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sylviapp_project/providers/providers.dart';

class SendFeedbackScreen extends StatefulWidget {
  const SendFeedbackScreen({Key? key}) : super(key: key);

  @override
  _SendFeedbackScreenState createState() => _SendFeedbackScreenState();
}

class _SendFeedbackScreenState extends State<SendFeedbackScreen> {
  TextEditingController _feedbackController = TextEditingController();

  String nameOfUser = "";

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(context.read(authserviceProvider).getCurrentUserUID())
        .get()
        .then((value) {
      setState(() {
        nameOfUser = value.get('fullname');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                "Send Feedback",
                style: TextStyle(
                    color: Color(0xff65BFB8),
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              )),
          Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: Text(
                "Send feedback to the application",
                style: TextStyle(color: Colors.black54),
              )),
          Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: TextField(
                maxLines: 5,
                controller: _feedbackController,
                inputFormatters: [LengthLimitingTextInputFormatter(100)],
              )),
          Center(
            child: Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(), primary: Colors.green),
                onPressed: () {
                  String dateCreated =
                      formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
                  if (_feedbackController.text == "") {
                    Fluttertoast.showToast(msg: 'Please Input feedback');
                  } else {
<<<<<<< HEAD
                    context.read(authserviceProvider).addFeedback(
                        _feedbackController.text,
                        context.read(authserviceProvider).getCurrentUserUID(),
                        dateCreated);
=======
                    context
                        .read(authserviceProvider)
                        .addFeedback(_feedbackController.text, nameOfUser);
>>>>>>> a888738237e53f6e6bec7ff91fe2961e7aa88b23
                    _feedbackController.clear();
                  }
                },
                child: Text("Submit"),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
