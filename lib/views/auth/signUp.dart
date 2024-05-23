import 'package:e_tablo/core/extensions.dart';
import 'package:e_tablo/core/widgets/custom_button.dart';
import 'package:e_tablo/core/widgets/custom_textfield.dart';
import 'package:e_tablo/services/firebase_services.dart';
import 'package:e_tablo/views/auth/signIn.dart';
import 'package:e_tablo/views/home/home.dart';
import 'package:e_tablo/views/widgets/auth_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuthService _service = FirebaseAuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainAuthCompanents(
        title: "REGISTER",
        buttonTitle: "Login",
        colorGradient: const [Colors.black, Colors.red],
        authClipDecorationOnTap: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SignIn()),
            (route) => false,
          );
        },
        authCardChildren: [
          CustomTextField(
            controller: _nameController,
            hintText: "Enter your name",
          ),
          CustomTextField(controller: _emailController, hintText: "Enter your email"),
          CustomTextField(
            controller: _passwordController,
            hintText: "Enter your password",
            isPassword: true,
          ),
          CustomTextField(
            controller: _rePasswordController,
            hintText: "Re-password",
            isPassword: true,
          ),
          NeumorphicButton(
              onPressed: () async {
                final email = _emailController.text.trim();
                final password = _passwordController.text.trim();
                final registerResponse = await _service.register(email: email, password: password);

                if (registerResponse && mounted) {
                  await FirebaseAuth.instance.currentUser?.updateDisplayName(_nameController.text.trim());
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeView()));
                } else {}
              },
              width: 0.5,
              child: Text(
                "REGISTER",
                style: context.texts.titleSmall,
              ))
        ],
      ),
    );
  }
}
