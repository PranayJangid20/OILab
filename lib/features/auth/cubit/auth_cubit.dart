import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oilab_task/features/auth/presentation/login_page.dart';
import 'package:oilab_task/features/home/presentation/home_page.dart';
import 'package:oilab_task/utils/app_colors.dart';
import 'package:oilab_task/utils/healper.dart';
import 'package:oilab_task/utils/ui_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?>? _authStateStream;
  AuthCubit() : super(AuthInitial()) {
    _authStateStream = auth.authStateChanges();
    "Auth Cubit Initalization".log();
    _authStateStream!.listen((User? user) {
      if (user == null) {
        'User is currently signed out!'.log();
      } else {
        'User is signed in!'.log();
      }
    });
  }

  verifyNumber(String number, BuildContext context) async {
    if (number.length > 10) {
      emit(AuthOtpSending());
      String smsCode = '';
      TextEditingController codeController = TextEditingController();
      await auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          emit(AuthOTPVerifyed());

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false);
        },

        verificationFailed: (FirebaseAuthException error) {
          emit(AuthOTPFailed());
          SnackBar snackBar = SnackBar(
            content: Text(error.message ?? "Error"),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },

        codeSent: (String verificationId, int? forceResendingToken) {
          emit(AuthOtpSended());
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                    title: const Text("Enter SMS Code"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          controller: codeController,
                          decoration: inputFieldDecoration(hint: "Enter OTP"),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      MaterialButton(
                        textColor: Colors.white,
                        color: Colors.redAccent,
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: const Text("Change Number"),
                      ),
                      MaterialButton(
                        textColor: Colors.white,
                        color: AppColors.secondaryColor,
                        onPressed: () async {
                          FirebaseAuth auth = FirebaseAuth.instance;

                          smsCode = codeController.text.trim();

                          try {
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                                    verificationId: verificationId,
                                    smsCode: smsCode);

                            await auth.signInWithCredential(credential);

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                                (route) => false);
                          } catch (e) {
                            Navigator.pop(context);
                            const snackBar = SnackBar(
                              content: Text('Incorrect Otp'),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: const Text("Done"),
                      )
                    ],
                  ));
        },
        
        codeAutoRetrievalTimeout: (String verificationId) {
          emit(AuthOTPFailed());
        },
      );
    } else {
      const snackBar = SnackBar(
        content: Text('Invalid Number'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  verifyGoogle(BuildContext context) async {
    emit(AuthGVerifing());

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;


    try {
      // Once signed in, return the UserCredential
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );


      emit(AuthGVerifed());

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } catch (e) {
      e.log();
      emit(AuthGFailed());
    }
  }

  logOutUser(BuildContext context) {
    auth.signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false);
  }
}
