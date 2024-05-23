// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tablo/core/extensions.dart';
import 'package:e_tablo/core/widgets/custom_button.dart';
import 'package:e_tablo/core/widgets/custom_textfield.dart';
import 'package:e_tablo/services/firebase_services.dart';
import 'package:e_tablo/views/auth/signUp.dart';
import 'package:e_tablo/views/home/home.dart';
import 'package:e_tablo/views/widgets/auth_widgets.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final String _title = "LOGIN";
  final String _buttonTitle = "Create account";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _service = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainAuthCompanents(
        title: _title,
        buttonTitle: _buttonTitle,
        colorGradient: const [Colors.black, Colors.blue],
        authClipDecorationOnTap: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SignUp()),
            (route) => false,
          );
        },
        authCardChildren: [
          CustomTextField(controller: _emailController, hintText: "Email address"),
          CustomTextField(
            isPassword: true,
            controller: _passwordController,
            hintText: "password",
          ),
          Column(
            children: [
              NeumorphicButton(
                width: 0.5,
                onPressed: () async {
                  final tryLogin =
                      await _service.login(email: _emailController.text.trim(), password: _passwordController.text.trim());

                  if (tryLogin) {
                    Navigator.of(context)
                        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeView()), (route) => false);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(backgroundColor: Colors.red, content: Text("E-mail or password is incorrect!")));
                  }
                },
                child: Text(_title, style: context.texts.titleSmall),
              ),
              TextButton(onPressed: () {}, child: const Text("Forgot password?")),
            ],
          )
        ],
      ),
    );
  }
}




// class CustomTextField extends StatelessWidget {
//   final Widget child;
//   final double horizontalLineLength;
//   final double verticalLineLength;
//   final double strokeWidth;

//   const CustomTextField({
//     super.key,
//     required this.child,
//     this.horizontalLineLength = 75.0,
//     this.verticalLineLength = 20.0,
//     this.strokeWidth = 2.0,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: ExtendedCornerPainter(
//         strokeWidth: strokeWidth,
//         horizontalLineLength: horizontalLineLength,
//         verticalLineLength: verticalLineLength,
//       ),
//       child: Container(padding: const EdgeInsets.symmetric(horizontal: 15), child: child),
//     );
//   }
// }

