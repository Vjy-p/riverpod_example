import 'dart:isolate';
import 'dart:math';

import 'package:example_riverpod/Models/product_model.dart';
import 'package:example_riverpod/services/productServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Screen2Notifier extends ChangeNotifier {
  List<int> numbersList = [];
  Map<int, List<int>> set = {
    0: [1, 2, 3],
    3: [11, 12, 13],
    6: [21, 22, 23],
    9: [31, 32, 33],
    12: [41, 42, 43],
    15: [51, 52, 53],
    18: [61, 62, 63],
    21: [71, 72, 73],
    24: [81, 82, 83],
    1: [4, 5, 6],
    4: [14, 15, 16],
    7: [24, 25, 26],
    10: [34, 35, 36],
    13: [44, 45, 46],
    16: [54, 55, 56],
    19: [64, 65, 66],
    22: [74, 75, 76],
    25: [84, 85, 86],
    2: [7, 8, 9, 10],
    5: [17, 18, 19, 20],
    8: [27, 28, 29, 30],
    11: [37, 38, 39, 40],
    14: [47, 48, 49, 50],
    17: [57, 58, 59, 60],
    20: [67, 68, 69, 70],
    23: [77, 78, 79, 80],
    26: [87, 88, 89, 90]
  };
  Map<int, List<int>> set1 = {
    0: [1, 2, 3],
    3: [11, 12, 13],
    6: [21, 22, 23],
    9: [31, 32, 33],
    12: [41, 42, 43],
    15: [51, 52, 53],
    18: [61, 62, 63],
    21: [71, 72, 73],
    24: [81, 82, 83]
  };
  Map<int, List<int>> set2 = {
    1: [4, 5, 6],
    4: [14, 15, 16],
    7: [24, 25, 26],
    10: [34, 35, 36],
    13: [44, 45, 46],
    16: [54, 55, 56],
    19: [64, 65, 66],
    22: [74, 75, 76],
    25: [84, 85, 86]
  };
  Map<int, List<int>> set3 = {
    2: [7, 8, 9, 10],
    5: [17, 18, 19, 20],
    8: [27, 28, 29, 30],
    11: [37, 38, 39, 40],
    14: [47, 48, 49, 50],
    17: [57, 58, 59, 60],
    20: [67, 68, 69, 70],
    23: [77, 78, 79, 80],
    26: [87, 88, 89, 90]
  };
  List<int> positionsList = [];
  List<int> selectedPositions = [];
  Map<int, int> map = {};
  List<int> fullList = List.generate(27, (index) => -1);
  bool isLoading = false;

  setData() async {
    getPositions();

    isLoading = false;
    notifyListeners();
  }

  getPositions() {
    isLoading = true;
    notifyListeners();
    positionsList.clear();
    positionsList = List.generate(27, (index) => index);
    selectedPositions.clear();
    fullList = List.generate(27, (index) => -1);

    notifyListeners();
    int start = 0;
    int end = 2;
    for (int i = 0; i < 10; i++) {
      int number = getRandomPositions(minNumber: start, maxNumber: end);

      selectedPositions.add(number);
      positionsList.remove(number);

      start = end + 1;
      end = end + 2;
      notifyListeners();
    }
    positionsList.sort();
    selectedPositions.sort();
    for (int i = 10; i < 15; i++) {
      int number = getPosition();

      selectedPositions.add(number);
      positionsList.remove(number);

      notifyListeners();
    }
    positionsList.sort();
    selectedPositions.sort();
    debugPrint("\nselected List $selectedPositions");
    mapwithPositions();
  }

  mapwithPositions() {
    for (int i = 0; i < 27; i++) {
      if (selectedPositions.contains(i)) {
        fullList[i] = getRandomNumber(position: i);
        notifyListeners();
      }
    }
    debugPrint("\nfull $fullList");
    isLoading = false;
    notifyListeners();
  }

  getRandomNumber({required int position}) {
    List<int>? numbersList = set[position];
    debugPrint("\nnumbers $numbersList");
    int number = numbersList![Random().nextInt(numbersList.length)];
    debugPrint("\nselected number $number");
    return number;
  }

  getPosition() {
    int number = positionsList[Random().nextInt(positionsList.length)];

    return number;
  }

  getRandomPositions({required int minNumber, required int maxNumber}) {
    int number = minNumber + Random().nextInt(maxNumber - minNumber);

    if (selectedPositions.contains(number)) {
      getRandomPositions(minNumber: minNumber, maxNumber: maxNumber);
    }
    return number;
  }
}

final screen2Provider = ChangeNotifierProvider<Screen2Notifier>((ref) {
  return Screen2Notifier();
});
