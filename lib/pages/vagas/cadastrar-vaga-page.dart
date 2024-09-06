import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/vagas/models/create-vaga-model.dart';
import 'package:conectatrabalho/shared/menu/menu-extensivel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:conectatrabalho/pages/vagas/repositorios/vagas_repository.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CadastrarVagaPage extends StatefulWidget {
  CadastrarVagaPage({Key? key}) : super(key: key);

  @override
  State<CadastrarVagaPage> createState() => _CadastrarVagaPageState();
}

class _CadastrarVagaPageState extends State<CadastrarVagaPage> {
  final VagasRepository _vagasRepository = VagasRepository();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _tituloController;
  late TextEditingController _descricaoController;
  late MaskedTextController _remuneracaoController;
  int? tipo;
  String? nivel;
  int? status;
  late TextEditingController _cargoController;

  @override
  void initState() {
    _tituloController = TextEditingController(text: "");
    _descricaoController = TextEditingController(text: "");
    _remuneracaoController =
        MaskedTextController(mask: "R\$ 000.000,00", text: "");
    _cargoController = TextEditingController(text: "");
    super.initState();
  }

  Future<VagaCreateRequestModel> toModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('idPerfil')!;

    VagaCreateRequestModel model = VagaCreateRequestModel(
      titulo: _tituloController.text,
      descricao: _descricaoController.text,
      remuneracao: double.parse(
        _remuneracaoController.text
            .replaceAll("R\$", "")
            .replaceAll(".", "")
            .replaceAll(",", ".")
            .replaceAll("'", ""),
      ),
      tipo: 1,
      nivel: nivel,
      status: 1,
      cargo: _cargoController.text,
      idEmpresa: uuid,
    );

    return model;
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
              child: Column(children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    const SizedBox(width: 35),
                    IconButton(
                        onPressed: () => routes.go('/home'),
                        icon:
                            const Icon(Icons.arrow_back, color: Colors.white)),
                    const Spacer(),
                    const CustomPopupMenuEmpresa(),
                    const SizedBox(width: 35),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 20.0),

                        // Campo Título
                        _buildTextField(
                          _tituloController,
                          "Título da vaga",
                          false,
                          "O título é obrigatório.",
                        ),
                        const SizedBox(height: 20.0),

                        // Campo Descrição
                        _buildTextField(
                          _descricaoController,
                          "Descrição da vaga",
                          false,
                          "A descrição é obrigatória.",
                        ),
                        const SizedBox(height: 20.0),

                        // Campo Remuneração
                        _buildTextField(
                          _remuneracaoController,
                          "Remuneração da vaga",
                          false,
                          "A remuneração é obrigatória.",
                        ),
                        const SizedBox(height: 20.0),

                        // Campo Tipo
                        _buildDropdownField<int>(
                          "Tipo da vaga",
                          [
                            const DropdownMenuItem(
                                value: 0,
                                child: Text(
                                  'CLT',
                                  style: TextStyle(color: Colors.black),
                                )),
                            const DropdownMenuItem(
                                value: 1,
                                child: Text(
                                  'PJ',
                                  style: TextStyle(color: Colors.black),
                                )),
                            const DropdownMenuItem(
                                value: 2,
                                child: Text(
                                  'Estágio',
                                  style: TextStyle(color: Colors.black),
                                )),
                            const DropdownMenuItem(
                                value: 3,
                                child: Text(
                                  'Trainee',
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                          (value) {
                            setState(() {
                              tipo = value;
                            });
                          },
                          () => tipo,
                          "O tipo é obrigatório.",
                        ),
                        const SizedBox(height: 20.0),

                        // Campo Nível
                        _buildDropdownField<String>(
                          "Nível da vaga",
                          [
                            const DropdownMenuItem(
                                value: 'Ensino Médio',
                                child: Text(
                                  'Ensino Médio',
                                  style: TextStyle(color: Colors.black),
                                )),
                            const DropdownMenuItem(
                                value: 'Ensino Superior',
                                child: Text(
                                  'Ensino Superior',
                                  style: TextStyle(color: Colors.black),
                                )),
                            const DropdownMenuItem(
                                value: 'Pós-graduação',
                                child: Text(
                                  'Pós-graduação',
                                  style: TextStyle(color: Colors.black),
                                )),
                            const DropdownMenuItem(
                                value: 'Mestrado',
                                child: Text(
                                  'Mestrado',
                                  style: TextStyle(color: Colors.black),
                                )),
                            const DropdownMenuItem(
                                value: 'Doutorado',
                                child: Text(
                                  'Doutorado',
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                          (value) {
                            setState(() {
                              nivel = value;
                            });
                          },
                          () => nivel,
                          "O nível é obrigatório.",
                        ),
                        const SizedBox(height: 20.0),

                        // Campo Status
                        _buildDropdownField<int>(
                          "Status da vaga",
                          [
                            const DropdownMenuItem(
                                value: 0,
                                child: Text(
                                  'Inativa',
                                  style: TextStyle(color: Colors.black),
                                )),
                            const DropdownMenuItem(
                                value: 1,
                                child: Text(
                                  'Ativa',
                                  style: TextStyle(color: Colors.black),
                                )),
                            const DropdownMenuItem(
                                value: 2,
                                child: Text(
                                  'Pausada',
                                  style: TextStyle(color: Colors.black),
                                )),
                            const DropdownMenuItem(
                                value: 3,
                                child: Text(
                                  'Encerrada',
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                          (value) {
                            setState(() {
                              status = value;
                            });
                          },
                          () => status,
                          "O status é obrigatório.",
                        ),
                        const SizedBox(height: 20.0),

                        // Campo Cargo
                        _buildTextField(
                          _cargoController,
                          "Cargo da vaga",
                          false,
                          "O cargo é obrigatório.",
                        ),
                        const SizedBox(height: 40.0),

                        // Botão de Enviar
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                toModel().then((model) {
                                  _vagasRepository.cadastrarVaga(
                                      model, context);
                                });
                              }

                              routes.go('/home');
                            },
                            child: const Text(
                              "Cadastrar Vaga",
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    ),
                  ),
                ),
              ]),
            )));
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    bool permitNull,
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
          if (permitNull) {
            return null;
          }
          if (value == null || value.isEmpty) {
            return errorMessage;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField<T>(
    String label,
    List<DropdownMenuItem<T>> items,
    ValueChanged<T?> onChanged,
    T? Function() currentValueGetter,
    String? errorMessage,
  ) {
    return SizedBox(
      width: 330,
      child: DropdownButtonFormField<T>(
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
        style: const TextStyle(color: Colors.white),
        items: items,
        onChanged: onChanged,
        value: currentValueGetter(),
        validator: (value) {
          if (value == null) {
            return errorMessage;
          }
          return null;
        },
      ),
    );
  }
}
