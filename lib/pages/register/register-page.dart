import 'package:conectatrabalho/pages/register/models/register-model.dart';
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
          backgroundColor: const Color(0xff220A55),
          toolbarHeight: 100,
          leadingWidth: 300,
          leading: Row(children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => context.go("/"),
            ),
            const Text("                      "),
            Image.asset(
              'assets/images/register-page/logo-register.png',
              filterQuality: FilterQuality.high,
              height: 40,
              fit: BoxFit.contain,
            ),
          ])),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
          color: Color(0xff220A55),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              const Text(
                "Eu busco:",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'MerriweatherSans',
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => context.go("/principal-data",
                        extra: User("", "", "", "", "1")),
                    child: Card(
                        elevation: 4,
                        child: SizedBox(
                            width: 125,
                            height: 125,
                            child: Image.asset(
                                'assets/images/register-page/contractor-icon.png'))),
                  ),
                  InkWell(
                    onTap: () => context.go("/principal-data",
                        extra: User("", "", "", "", "0")),
                    child: Card(
                        elevation: 4,
                        child: SizedBox(
                            width: 125,
                            height: 125,
                            child: Image.asset(
                                'assets/images/register-page/employee-icon.png'))),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
