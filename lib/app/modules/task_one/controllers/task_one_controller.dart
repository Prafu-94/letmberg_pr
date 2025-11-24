import 'package:get/get.dart';

class TaskOneController extends GetxController {
  Map<String, int> animalCounts = <String, int>{};
  List<Map> saprateCollection = [];

  @override
  void onInit() {
    super.onInit();
    animalCounts.assignAll(getAnimalCounts());
  }

  static Map data_collection = {
    "animals": [
      {"animal": "dog,cat,dog,cow,monkey"},
      {"animal": "cow,cat,cat,lion"},
      {"animal": null},
      {"animal": ""},
    ],
  };

  Map<String, int> getAnimalCounts() {
    Map<String, int> counts = {};
    for (var item in data_collection['animals']!) {
      final animalString = item['animal'];
      if (animalString != null && animalString.isNotEmpty) {
        List<String> animals = animalString.split(',');
        Map<String, int> tempCounts = {};
        for (int i = 0; i < animals.length; i++) {
          tempCounts[animals[i]] = (tempCounts[animals[i]] ?? 0) + 1;
          counts[animals[i]] = (counts[animals[i]] ?? 0) + 1;
        }
        saprateCollection.add(tempCounts);
      }
    }
    return counts;
  }
}
