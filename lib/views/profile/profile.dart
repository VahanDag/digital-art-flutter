import 'package:e_tablo/core/extensions.dart';
import 'package:e_tablo/views/auth/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

List<Map<String, dynamic>> _settings = [
  {"title": "My Previous Photos"},
  {"title": "E-Table Settings"},
  {"title": "Logout"}
];

class _ProfileViewState extends State<ProfileView> {
  final User? _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: <Widget>[
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: context.height * 0.35,
                    decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.purple, Colors.blue])),
                  ),
                ),
                Positioned(
                    top: 75,
                    child: Text(
                      "Welcome ${_user?.displayName ?? _user!.email}!",
                      style: context.texts.titleLarge?.copyWith(color: Colors.white),
                    )),
                const Positioned(
                  bottom: -15,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/samurai.jpg"),
                      radius: 55,
                    ),
                  ),
                ),
                // You can add more widgets here, like Text for the name, icons, etc.
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _settings.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () async {
                      if (_settings[index]["title"] == "Logout") {
                        Navigator.of(context)
                            .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SignIn()), (route) => false);
                      }
                    },
                    title: Text(_settings[index]["title"]),
                    trailing: const Icon(Icons.chevron_right),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80); // Adjust the curve as needed
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 80); // Adjust the curve as needed
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
