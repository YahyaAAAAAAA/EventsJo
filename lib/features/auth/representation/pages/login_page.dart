import 'package:events_jo/features/auth/representation/components/my_button.dart';
import 'package:events_jo/features/auth/representation/components/my_text_field.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/config/my_colors.dart';
import 'package:events_jo/features/home/presentation/components/events_jo_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  void login() {
    //prepare email & pw
    final String email = emailController.text;
    final String pw = pwController.text;

    //auth cubit
    final AuthCubit authCubit = context.read<AuthCubit>();

    //ensure that email & pw not empty
    if (email.isNotEmpty && pw.isNotEmpty) {
      authCubit.login(email, pw);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter both email and password',
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    pwController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                const EventsJoLogo(),

                const SizedBox(height: 25),

                //welcome back message
                Text(
                  "Login to EventsJO",
                  style: TextStyle(
                    color: MyColors.black,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //email textField
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                //pw textField
                MyTextField(
                  controller: pwController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                //login button
                MyButton(onTap: login, text: 'Login'),
                const SizedBox(
                  height: 50,
                ),
                //not a member ? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account ?',
                      style: TextStyle(
                        color: MyColors.black,
                        fontSize: 17,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        ' Register now!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.red,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
