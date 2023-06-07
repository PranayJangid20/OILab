import 'package:flutter/material.dart';

import 'app_colors.dart';

inputFieldDecoration({required String hint})=>InputDecoration(
    focusColor: AppColors.primaryColor,
    fillColor: AppColors.backgroundColor,
    filled: true,
    hintText: hint,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    )
);