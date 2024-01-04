import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xff413EFF),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => context.go("/"),
          )),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/register-page/register-select-type-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => context.go("/principal-data/0"),
                      child: Card(
                          elevation: 4,
                          child: Container(
                              width: 100,
                              height: 100,
                              child: Image.asset(
                                  'assets/images/register-page/contractor-icon.png'))),
                    ),
                    InkWell(
                      onTap: () => context.go("/principal-data/1"),
                      child: Card(
                          elevation: 4,
                          child: Container(
                              width: 100,
                              height: 100,
                              child: Image.asset(
                                  'assets/images/register-page/employee-icon.png'))),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
