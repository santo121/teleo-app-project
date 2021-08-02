import 'package:flutter/material.dart';

class ActionChipData {
  final String label;
 

  ActionChipData({
    @required this.label,
   
  });

  ActionChipData copy({
    String label,
    IconData icon,
    Color iconColor,
  }) =>
      ActionChipData(
        label: label ?? this.label,
        
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActionChipData &&
          runtimeType == other.runtimeType &&
          label == other.label ;
         

  @override
  int get hashCode => label.hashCode;
}
