import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oilab_task/features/auth/cubit/auth_cubit.dart';
import 'package:oilab_task/utils/app_colors.dart';
import 'package:oilab_task/utils/healper.dart';
import 'package:oilab_task/utils/ui_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _numController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text("Hello, Welcome", style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white)),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _numController,
                      decoration: inputFieldDecoration(hint: 'Enter Mobile Nunmer'),
                    ),
                    10.spaceY,
                    state is AuthOtpSending
                        ? CircularProgressIndicator(
                            color: AppColors.secondaryColor,
                          )
                        : MaterialButton(
                            onPressed: () {
                              context.read<AuthCubit>().verifyNumber(_numController.text.toString(), context);
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                decoration: BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.shadowColor,
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0, 5))
                                    ]),
                                child:
                                    Center(child: Text("Send OTP", style: Theme.of(context).textTheme.displayLarge))),
                          )
                  ],
                ),
                const Spacer(),
                state is AuthGVerifing
                    ? CircularProgressIndicator(
                        color: AppColors.secondaryColor,
                      )
                    : MaterialButton(
                        onPressed: () {
                          context.read<AuthCubit>().verifyGoogle(context);
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            decoration: BoxDecoration(
                                color: AppColors.secondaryColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.shadowColor,
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5))
                                ]),
                            child: Center(
                                child: Text("Login with Google", style: Theme.of(context).textTheme.displayLarge))),
                      ),
                const Spacer()
              ],
            ),
          );
        },
      ),
    );
  }
}
