// import 'package:chat_gpt/api_service.dart';
import 'package:doc_insight/models/models_model.dart';
import 'package:doc_insight/providers/models_provider.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalDropDown extends StatefulWidget {
  const ModalDropDown({super.key});

  @override
  _ModalDropDownState createState() => _ModalDropDownState();
}

class _ModalDropDownState extends State<ModalDropDown> {
  String? currentModelValue;

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    currentModelValue = modelsProvider.getCurrentModel;
    return FutureBuilder<List<ModelsModel>>(
      future: modelsProvider.getAllModels(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final modelsList = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
            child: DropdownButton<String>(
              dropdownColor: scaffoldBackgroundColor,
              items: modelsList.map((ModelsModel model) {
                return DropdownMenuItem<String>(
                  value: model.id,
                  child: Text(
                    model.id!,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }).toList(),
              value: currentModelValue,
              onChanged: (value) {
                setState(() {
                  currentModelValue = value.toString();
                });
                modelsProvider.setCurrentModel(value.toString());
              },
            ),
          );
        }
      },
    );
  }
}
