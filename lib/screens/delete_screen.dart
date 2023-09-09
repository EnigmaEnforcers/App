import 'package:child_finder/model/lostChildern.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({super.key, required this.childToDelete});

  final LostChildren childToDelete;
  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String verificationId = '';

  @override
  void initState() {
    // await FirebaseAuth.instance.verifyPhoneNumber(
    //   phoneNumber: '+91 ${widget.childToDelete.parentContact}',
    //   verificationCompleted: (PhoneAuthCredential credential) {},
    //   verificationFailed: (FirebaseAuthException e) {},
    //   codeSent: (String verificationId, int? resendToken) {
    //     verificationId = verificationId;
    //     ScaffoldMessenger.of(context).clearSnackBars();
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //         content: Text(
    //           'OTP has been sent',
    //         ),
    //       ),
    //     );
    //   },
    //   codeAutoRetrievalTimeout: (String verificationId) {},
    // );
    sendOTP();
    super.initState();
  }

  void sendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91 ${widget.childToDelete.parentContact}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        verificationId = verificationId;
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'OTP has been sent',
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    var codeEntered1 = '';
    var codeEntered2 = '';
    var codeEntered3 = '';
    var codeEntered4 = '';
    var codeEntered5 = '';
    var codeEntered6 = '';

    return Scaffold(
      appBar: AppBar(
          backgroundColor: lighttheme.appBarTheme.backgroundColor,
          title: const Text(
            'Delete Complaint',
          ),
          centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              // Row(
              //   children: [
              //     const Expanded(
              //         child: Text(
              //       'Click here to receive OTP',
              //       style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              //     )),
              //     TextButton(
              //       style: ButtonStyle(
              //           foregroundColor: MaterialStatePropertyAll(
              //               lighttheme.colorScheme.primary)),
              //       onPressed: () async {
              //         // await FirebaseAuth.instance.verifyPhoneNumber(
              //         //   phoneNumber:
              //         //       '+91 ${widget.childToDelete.parentContact}',
              //         //   verificationCompleted:
              //         //       (PhoneAuthCredential credential) {},
              //         //   verificationFailed: (FirebaseAuthException e) {},
              //         //   codeSent: (String verificationId, int? resendToken) {
              //         //     verificationId = verificationId;
              //         //     ScaffoldMessenger.of(context).clearSnackBars();
              //         //     ScaffoldMessenger.of(context).showSnackBar(
              //         //       const SnackBar(
              //         //         content: Text(
              //         //           'OTP has been sent',
              //         //         ),
              //         //       ),
              //         //     );
              //         //   },
              //         //   codeAutoRetrievalTimeout: (String verificationId) {},
              //         // );
              //       },
              //       child: const Text(
              //         'Send OTP',
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Please Enter the OTP',
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 30,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onSaved: (newValue) {
                          codeEntered1 = newValue!;
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 30,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onSaved: (newValue) {
                          codeEntered2 = newValue!;
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 30,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onSaved: (newValue) {
                          codeEntered3 = newValue!;
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 30,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onSaved: (newValue) {
                          codeEntered4 = newValue!;
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 30,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onSaved: (newValue) {
                          codeEntered5 = newValue!;
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 30,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onSaved: (newValue) {
                          codeEntered6 = newValue!;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            lighttheme.colorScheme.primary)),
                    onPressed: () async {
                      setState(() {
                        setState(() {
                          _isLoading = true;
                        });
                      });
                      FirebaseAuth auth = FirebaseAuth.instance;
                      _formKey.currentState!.save();
                      var codeEntered =
                          '$codeEntered1$codeEntered2$codeEntered3$codeEntered4$codeEntered5$codeEntered6';
                      // print(codeEntered);
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: codeEntered);
                        // print('verified');
                        await auth.signInWithCredential(credential);
                        final docUser = FirebaseFirestore.instance
                            .collection('lostChild')
                            .doc(widget.childToDelete.uid);

                        await docUser.delete();
                        setState(() {
                          _isLoading = false;
                        });
                        if (mounted) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Complaint Deleted Succesfully',
                              ),
                            ),
                          );
                          Navigator.of(context).pop(true);
                        }
                      } catch (e) {
                        // print('${e.toString()} failureeeeee');
                        setState(() {
                          _isLoading = false;
                        });
                        if (mounted) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Enter correct OTP or Try again later',
                              ),
                            ),
                          );
                        }
                      }

                      // Sign the user in (or link) with the credential
                      // await auth.signInWithCredential(credential);
                    },
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Verify'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget otpBox(code, {flag = true}) {
  //   return
  // }
}
