import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:speak_out_app/features/cases/case-detail/view/case_detail_page.dart';
import 'package:speak_out_app/features/home/case-mode/case_model.dart';
import 'package:speak_out_app/utils/case_status_enum.dart';

import '../features/home/student-home/controller/student_home_controller.dart';
import '../utils/colors.dart';

class CaseItem extends StatelessWidget {
  const CaseItem({super.key, required this.caseModel});
  final CaseModel caseModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => CaseDetailPage(
            caseModel: caseModel,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 10,
              offset: Offset(0, 3),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: AppColors.themeColor,
                shape: BoxShape.circle,
                image: caseModel.images == null ||
                        (caseModel.images?.isEmpty ?? false)
                    ? null
                    : DecorationImage(
                        image: NetworkImage(caseModel.images!.first),
                        fit: BoxFit.cover,
                      ),
              ),
              padding: const EdgeInsets.all(8),
              child: caseModel.images == null ||
                      (caseModel.images?.isEmpty ?? false)
                  ? const Icon(
                      Icons.image_rounded,
                      color: AppColors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          caseModel.type ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            height: 1.33,
                            color: Color(0xFF242A37),
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:
                              CaseStatus.getCaseStatus(caseModel.status ?? "")
                                  .backColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 6),
                        child: Text(
                          caseModel.status ?? "",
                          style: TextStyle(
                            color:
                                CaseStatus.getCaseStatus(caseModel.status ?? "")
                                    .textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    caseModel.description ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFFA4A4A4),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      Text(
                        DateFormat("dd/MM/yyyy").format(
                          caseModel.updatedAt ?? DateTime.now(),
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textColor.withOpacity(0.6),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            if (caseModel.status == CaseStatus.pending.status) ...[
              Obx(
                () {
                  final control = Get.find<StudentHomeController>();
                  return control.isDeleteLoading.value
                      ? const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : IconButton(
                          onPressed: () =>
                              control.onDeleteCase(context, caseModel.id ?? ""),
                          icon: const Icon(
                            Icons.delete,
                            color: Color(0xffFF7D53),
                          ),
                        );
                },
              ),
            ]
          ],
        ),
      ),
    );
  }
}
