import 'package:flutter/material.dart';
import 'package:speak_out_app/features/home/case-mode/case_model.dart';

import '../utils/colors.dart';

class CaseItem extends StatelessWidget {
  const CaseItem({super.key, required this.caseModel});
  final CaseModel caseModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(17),
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
                  Text(
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
                  const SizedBox(height: 5),
                  Text(
                    caseModel.description ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFFA4A4A4),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
