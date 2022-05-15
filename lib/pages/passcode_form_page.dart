import 'package:flutter/material.dart';
import '../constants/passcode_constants.dart';
import '../constants/text_constants.dart';
import '../constants/style_constants.dart';
import '../services/secure_storage.dart';
import 'start_page.dart';

class PasscodeFormPage extends StatefulWidget {
  const PasscodeFormPage({Key? key}) : super(key: key);

  @override
  State<PasscodeFormPage> createState() => _PasscodeFormPageState();
}

class _PasscodeFormPageState extends State<PasscodeFormPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String passcode = '';

  Future<void> submitAction() async {
    if (_formKey.currentState!.validate()) {
      final SecureStorage secureStorage = SecureStorage();
      secureStorage.writeSecureData('passcode', passcode);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const StartPage(title: kYourTripsDescr);
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppTitle2),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(kPasscodeDescr, style: kHeaderTextStyle),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0, 8, 0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            validator: (value) {
                              passcode = kPasscodeValue;
                              if (value == null || value.isEmpty) {
                                return kPasscodeDescr2;
                              } else if (value != passcode) {
                                return '$value$kPasscodeIncorrectMessage';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => submitAction(),
                            child: Icon(
                              Icons.login,
                              size: 50,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
