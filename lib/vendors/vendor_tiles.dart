

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class VendorLineTitles {
  static getTitleData() => FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      showTitles: true,
      reservedSize: 35,

      getTextStyles: (value) => const TextStyle(
        color: Color(0xff68737d),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      getTitles: (value) {
        switch (value.toInt()) {
          case 1:
            return 'Jan';
          case 3:
            return 'Mar';
          case 5:
            return 'May';
          case 7:
            return 'Jul';
          case 9:
            return 'Sep';
          case 11:
            return 'Nov';
        }
        return '';
      },
      margin: 8,
    ),
    leftTitles: SideTitles(
      showTitles: true,
      getTextStyles: (value) => const TextStyle(
        color: Color(0xff67727d),
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      getTitles: (value) {
        switch (value.toInt()) {
          case 1:
            return '1k';
          case 3:
            return '3k';
          case 5:
            return '5k';
        }
        return '';
      },
      reservedSize: 35,
      margin: 12,
    ),
  );
}
