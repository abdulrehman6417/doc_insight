import 'package:doc_insight/api_service.dart';
import 'package:doc_insight/models/models_model.dart';
import 'package:flutter/material.dart';

class ModelsProvider with ChangeNotifier {
  List<ModelsModel> modelsList = [];
  String currentModel = 'gpt-3.5-turbo-0613';

  List<ModelsModel> get getModelsList {
    return modelsList;
  }

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  Future<List<ModelsModel>> getAllModels() async {
    modelsList = ApiService.modelsList;
    return modelsList;
  }
}
