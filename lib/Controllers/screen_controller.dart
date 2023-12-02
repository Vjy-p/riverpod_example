import 'dart:math';

import 'package:example_riverpod/main.dart';
import 'package:example_riverpod/utils/customToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenNotifier extends ChangeNotifier {
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

  List<int> selectedPositions = [];
  List<int> fullList = List.generate(27, (index) => -1);
  bool isLoading = false;

  List<int> numbers = List.generate(90, (index) => index + 1);
  List<int> userMarkedList = [];
  List<int> selectedList = [];
  List<int> openNumbersList = [];
  List<List<int>> rowsList = [];
  List<int> recentNumbersList = [];
  int openedNumber = 0;
  String quickFive = '-1';
  String topRow = '-1';
  String middleRow = '-1';
  String bottomRow = '-1';
  String houseFull = '-1';
  int totalPoints = 0;
  bool start = false;

  setData() async {
    isLoading = true;
    notifyListeners();
    openedNumber = 0;
    start = false;
    userMarkedList.clear();
    openNumbersList.clear();
    selectedPositions.clear();
    recentNumbersList.clear();
    rowsList.clear();
    quickFive = '-1';
    topRow = '-1';
    middleRow = '-1';
    bottomRow = '-1';
    houseFull = '-1';
    totalPoints = 0;
    fullList = List.generate(27, (index) => -1);
    for (int i = 1; i <= 3; i++) {
      getPositions(setNumber: i);
    }
    isLoading = false;
    notifyListeners();
  }

  getPositions({required int setNumber}) {
    List<int> numbers = [];
    List<int> positions = [];
    if (setNumber == 1) {
      positions = set1.keys.toList();
    } else if (setNumber == 2) {
      positions = set2.keys.toList();
    } else if (setNumber == 3) {
      positions = set3.keys.toList();
    }

    for (int j = 0; j < 5; j++) {
      int number = positions[Random().nextInt(positions.length)];
      selectedPositions.add(number);
      positions.remove(number);
      int val = getNumber(position: number, setNumber: setNumber);
      fullList[number] = val;
      selectedList.add(val);
      numbers.add(val);
      notifyListeners();
    }
    rowsList.add(numbers);
    debugPrint("\nselected List $fullList");
    isLoading = false;
    notifyListeners();
  }

  getNumber({required int position, required int setNumber}) {
    List<int>? numbersList = [];
    if (setNumber == 1) {
      numbersList = set1[position];
    } else if (setNumber == 2) {
      numbersList = set2[position];
    } else if (setNumber == 3) {
      numbersList = set3[position];
    }

    int number = numbersList![Random().nextInt(numbersList.length)];

    return number;
  }

  startGame() {
    if (start == false) {
      start = true;
      countDownController.start();
      openNumber();
    }
  }

  openNumber() {
    int number = numbers[Random().nextInt(numbers.length)];

    openedNumber = number;
    openNumbersList.add(number);
    numbers.remove(number);
    if (recentNumbersList.length == 5) {
      // for(var i in recentNumbersList){

      // }
      recentNumbersList.removeAt(0);
      recentNumbersList.add(number);
    } else {
      recentNumbersList.add(number);
    }
    notifyListeners();
    debugPrint("\nopened Number $number $openNumbersList");
  }

  markNumber({required int number}) {
    userMarkedList.add(number);
    notifyListeners();
  }

  check() {
    if (openNumbersList.length == 90) {
      debugPrint("\nGame Over");
      start = false;
      notifyListeners();
    } else {
      countDownController.restart(duration: 5);
      notifyListeners();
    }
  }

  quickFiveValidate() {
    int count = 0;
    userMarkedList.sort();
    openNumbersList.sort();
    if (quickFive == '-1') {
      for (var i in openNumbersList) {
        if (userMarkedList.contains(i)) {
          count++;
          notifyListeners();
        }
      }
      if (count == 5) {
        quickFive = 'yes';
        totalPoints += 10;
        notifyListeners();
        customToast(
            context: navigatorKey.currentContext,
            text: "Congratulations \nWon Quick Five",
            margin: ScreenUtil().screenHeight * 0.3);
      } else {
        quickFive = 'no';
        totalPoints -= 10;
        notifyListeners();
        customToast(
            context: navigatorKey.currentContext,
            text: "Wrong selection",
            margin: ScreenUtil().screenHeight * 0.3);
      }
    } else {
      debugPrint("\nalready submmited");
    }
  }

  rowValidate({required int row}) {
    int count = 0;
    String rowType = '';

    if (row == 0) {
      rowType = topRow;
      notifyListeners();
      debugPrint("\nrow Type $rowType ");
    } else if (row == 1) {
      rowType = middleRow;
      notifyListeners();
      debugPrint("\nrow Type $rowType ");
    } else if (row == 2) {
      rowType = bottomRow;
      notifyListeners();
      debugPrint("\nrow Type $rowType ");
    }

    if (rowType == '-1') {
      debugPrint("\nrow Type11 $rowType ");
      for (var i in rowsList[row]) {
        if (openNumbersList.contains(i) && userMarkedList.contains(i)) {
          count++;
        }
      }
      debugPrint("\nrow Type count $rowType $count");
      notifyListeners();

      if (count == rowsList[row].length) {
        debugPrint("\nrow Type 33333 $rowType ");
        if (row == 0) {
          topRow = 'yes';
          notifyListeners();
        } else if (row == 1) {
          middleRow = 'yes';
          notifyListeners();
        } else if (row == 2) {
          bottomRow = 'yes';
          notifyListeners();
        }

        totalPoints += totalPoints + 10;
        notifyListeners();
      } else {
        if (row == 0) {
          topRow = 'no';
          notifyListeners();
        } else if (row == 1) {
          middleRow = 'no';
          notifyListeners();
        } else if (row == 2) {
          bottomRow = 'no';
          notifyListeners();
        }
        totalPoints -= 10;
        notifyListeners();
      }
    } else {
      debugPrint("\nAlready Validated");
    }
  }

  fullHouseValidate() {
    if (houseFull == '-1') {
      int count = 0;
      for (var i in userMarkedList) {
        if (openNumbersList.contains(i)) {
          count++;
        }
      }
      if (count == 15) {
        houseFull = 'yes';
        totalPoints += 60;
        notifyListeners();
        customToast(
            context: navigatorKey.currentContext,
            text: "Congratulations \nYou Won",
            margin: ScreenUtil().screenHeight * 0.3);
      } else {
        houseFull = 'no';
        totalPoints -= 60;
        customToast(
            context: navigatorKey.currentContext,
            text: "You Loose\nBetter luck next time",
            margin: ScreenUtil().screenHeight * 0.3);
        notifyListeners();
      }
    }
  }
}

final screenProvider = ChangeNotifierProvider<ScreenNotifier>((ref) {
  return ScreenNotifier();
});
