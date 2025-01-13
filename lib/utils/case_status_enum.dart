import 'package:flutter/material.dart';
import 'package:speak_out_app/utils/colors.dart';

enum CaseStatus {
  pending("PENDING", 0.3, AppColors.themeColor, Color(0xffF0ECFF)),
  working("WORKING", 0.66, Color(0xffFF7D53), Color(0xffFFE4F2)),
  resolved("RESOLVED", 1, Color(0xff0087FF), Color(0xffE3F2FF)),
  ;

  const CaseStatus(this.status, this.value, this.textColor, this.backColor);
  final String status;
  final double value;
  final Color textColor;
  final Color backColor;

  static CaseStatus getCaseStatus(String status) {
    return CaseStatus.values.firstWhere(
      (element) {
        return element.status == status;
      },
    );
  }
}
