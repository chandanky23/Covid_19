import 'package:flutter/material.dart';
import 'package:covid_19/components/list_view_province.dart';

@override
Widget filterOnSearch(String _searchedText, List primaryData, List filteredData) {
  if (_searchedText.isNotEmpty) {
      List tempList = new List();
      for (int i = 0; i < primaryData.length; i++) {
        if ('${primaryData[i].name}'
            .toLowerCase()
            .contains(_searchedText.toLowerCase())) {
          tempList.add(primaryData[i]);
        }
      }
      filteredData = tempList;
    }
    return listViewWidget(filteredData);
}