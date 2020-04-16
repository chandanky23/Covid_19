import 'package:flutter/material.dart';
import 'package:covid_19/components/list_view_country.dart';

@override
Widget filterOnSearch(String _searchedText, List primaryData, List filteredData, dynamic handleCardTap) {
  if (_searchedText.isNotEmpty) {
      List tempList = new List();
      for (int i = 0; i < primaryData.length; i++) {
        if ('${primaryData[i].country}'
            .toLowerCase()
            .contains(_searchedText.toLowerCase())) {
          tempList.add(primaryData[i]);
        }
      }
      filteredData = tempList;
    }
    return listViewWidget(filteredData, handleCardTap);
}