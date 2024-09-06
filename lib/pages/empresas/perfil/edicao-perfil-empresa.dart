import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/empresas/candidato/repositories/empresa-repository.dart';
import 'package:conectatrabalho/pages/empresas/perfil/perfil-empresa-edicao-model.dart';
import 'package:conectatrabalho/shared/menu/menu-extensivel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditarPerfiLEmpresaPage extends StatefulWidget {
  EditarPerfiLEmpresaPage({Key? key}) : super(key: key);

  @override
  State<EditarPerfiLEmpresaPage> createState() =>
      _EditarPerfiLEmpresaPageState();
}

class _EditarPerfiLEmpresaPageState extends State<EditarPerfiLEmpresaPage> {
  final _formKey = GlobalKey<FormState>();
  final EmpresaRepository empresaRepository = EmpresaRepository();

  late TextEditingController _setorController;
  late TextEditingController _descricaoController;
  late TextEditingController _websiteController;
  late TextEditingController _linkedinController;

  @override
  void initState() {
    super.initState();
    _setorController = TextEditingController(text: "");
    _descricaoController = TextEditingController(text: "");
    _websiteController = TextEditingController(text: "");
    _linkedinController = TextEditingController(text: "");
    getEmpresa(); 
  }

  Future<void> save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('idPerfil')!;

    PerfilEmpresaEdicaoModel perfil = PerfilEmpresaEdicaoModel(
      uuid,
      _setorController.text,
      _descricaoController.text,
      _websiteController.text.isNotEmpty ? _websiteController.text : '',
      _linkedinController.text.isNotEmpty ? _linkedinController.text : '',
    );

    await empresaRepository.updatePerfilEmpresa(context, perfil);
  }

  Future<void> getEmpresa() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('idPerfil')!;
    empresaRepository.getEmpresaCompleto(context, id).then((onValue) {
      setState(() {
        _setorController.text = onValue.setor;
        _descricaoController.text = onValue.descricao;
        _websiteController.text = onValue.website;
        _linkedinController.text = onValue.linkedin;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
          color: Color(0xff220A55),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50),
                Row(
                  children: [
                    const SizedBox(width: 35),
                    IconButton(
                      onPressed: () => routes.go('/home'),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Spacer(),
                    const CustomPopupMenuEmpresa(),
                    const SizedBox(width: 35),
                  ],
                ),
                const SizedBox(height: 20),

                // Campo Setor
                _buildTextField(
                  _setorController,
                  "Setor",
                  "O setor é obrigatório.",
                ),
                const SizedBox(height: 20.0),

                // Campo Descrição
                _buildTextField(
                  _descricaoController,
                  "Descrição",
                  "A descrição é obrigatória.",
                ),
                const SizedBox(height: 20.0),

                // Campo Website (Não obrigatório)
                _buildTextField(
                  _websiteController,
                  "Website",
                  null, // Não tem validação obrigatória
                ),
                const SizedBox(height: 20.0),

                // Campo LinkedIn (Não obrigatório)
                _buildTextField(
                  _linkedinController,
                  "LinkedIn",
                  null, // Não tem validação obrigatória
                ),
                const SizedBox(height: 40.0),

                // Botão de Enviar
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      save();
                    }
                  },
                  child: const Text(
                    "Salvar Alterações",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String? errorMessage,
  ) {
    return SizedBox(
      width: 330,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (errorMessage != null && (value == null || value.isEmpty)) {
            return errorMessage;
          }
          return null;
        },
      ),
    );
  }
}
