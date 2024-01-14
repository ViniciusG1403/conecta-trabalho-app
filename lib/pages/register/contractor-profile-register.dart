import 'package:conectatrabalho/pages/register/models/register-model.dart';
import 'package:conectatrabalho/pages/register/services/validate-fields-service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContractorProfileRegisterPage extends StatefulWidget {
  const ContractorProfileRegisterPage({super.key});
  @override
  State<ContractorProfileRegisterPage> createState() =>
      _ContractorProfileRegisterPageState();
}

class _ContractorProfileRegisterPageState
    extends State<ContractorProfileRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              onPressed: () => context.go("/register"),
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [Text("Contractor")],
            ),
          ),
        ),
      ),
    );
  }
}
