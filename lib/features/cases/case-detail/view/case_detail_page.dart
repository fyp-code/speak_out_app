import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:speak_out_app/features/auth/user_type/user_type_enum/user_type_enum.dart';
import 'package:speak_out_app/features/cases/case-detail/controller/case_detail_controller.dart';
import 'package:speak_out_app/features/user-profile/user_model/user_model.dart';
import 'package:speak_out_app/features/user-profile/user_service/user_service.dart';
import 'package:speak_out_app/widgets/field_label.dart';

import '../../../../services/shared_pref_service.dart';
import '../../../../utils/case_status_enum.dart';
import '../../../../utils/colors.dart';
import '../../../../widgets/app_textfield.dart';
import '../../../../widgets/custom_dropdown.dart';
import '../../../../widgets/input_validators.dart';
import '../../../../widgets/network_image_progress.dart';
import '../../../home/case-mode/case_model.dart';
import '../../../home/comment-model/comment_model.dart';

class CaseDetailPage extends StatefulWidget {
  const CaseDetailPage({super.key, required this.caseModel});
  final CaseModel caseModel;

  @override
  State<CaseDetailPage> createState() => _CaseDetailPageState();
}

class _CaseDetailPageState extends State<CaseDetailPage> {
  final CaseDetailController controller = Get.put(CaseDetailController());
  @override
  void initState() {
    controller.fetchCommentData(widget.caseModel.id ?? "");
    super.initState();
  }

  final isAdmin =
      SharedPrefService().getUserType == UserRole.administrator.role;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.caseModel.type ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            if (controller.focusNode.hasFocus) {
              controller.focusNode.unfocus();
            }
          },
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: CustomScrollView(
                    slivers: [
                      if (widget.caseModel.images != null &&
                          (widget.caseModel.images?.isNotEmpty ?? false)) ...[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: widget.caseModel.images!.length,
                            (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: NetworkImageWithProgress(
                                        imageUrl:
                                            widget.caseModel.images![index],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(height: 20),
                        ),
                      ],
                      const SliverToBoxAdapter(
                        child: FieldLabel(
                          "Description",
                          textSize: 20,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            widget.caseModel.description ?? "",
                            textAlign: TextAlign.justify,
                            style: const TextStyle(),
                          ),
                        ),
                      ),
                      if (isAdmin) ...[
                        if (CaseStatus.resolved.status !=
                            widget.caseModel.status)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: CustomDropdownButton(
                                dropItems: CaseStatus.values
                                    .map((e) => e.status)
                                    .toList(),
                                value: widget.caseModel.status ?? "",
                                onChanged: controller.isUpdatingStatus.value
                                    ? null
                                    : (p0) {
                                        controller.onUpdateStatus(
                                          context,
                                          p0 ?? CaseStatus.pending.status,
                                          widget.caseModel.id ?? "",
                                        );
                                      },
                                borderRadius: 20,
                              ),
                            ),
                          ),
                      ],
                      const SliverToBoxAdapter(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black45,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Comments",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                          ),
                        ),
                      ),
                      CommentWidget(
                        controller: controller,
                        caseModel: widget.caseModel,
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 3.0),
                  child: Form(
                    key: controller.formKey,
                    child: AppTextField(
                      focusNode: controller.focusNode,
                      validator: InputValidators.required(
                          message: "Comment is required"),
                      textCapitalization: TextCapitalization.sentences,
                      textEditingController: controller.commentController,
                      maxLines: null,
                      minLines: 1,
                      onFieldSubmitted: (value) {
                        controller.onPostComment(
                            context, widget.caseModel.id ?? "");
                      },
                      readOnly: controller.isPostingReply.value,
                      borderRadius: 30,
                      hint: "Add comment...",
                      textInputAction: TextInputAction.send,
                      suffixIcon: IconButton(
                        onPressed: () => controller.onPostComment(
                            context, widget.caseModel.id ?? ""),
                        icon: controller.isPostingReply.value
                            ? const CupertinoActivityIndicator()
                            : const Icon(Icons.send),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  CommentWidget({
    super.key,
    required this.controller,
    required this.caseModel,
  });

  final CaseDetailController controller;
  final CaseModel caseModel;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isLoadingComments.value) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (controller.errorMessage.isNotEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(controller.errorMessage.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 16)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      controller.fetchCommentData(caseModel.id ?? "");
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }
        if (controller.commentsList.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text(
                'No comments...yet',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return SliverList.builder(
          itemCount: controller.commentsList.length,
          itemBuilder: (context, index) {
            CommentModel commentModel = controller.commentsList[index];
            return FutureBuilder<AppUser>(
                future: UserFirestoreService()
                    .fetchOneFirestore(commentModel.userId ?? ""),
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        snapshot.connectionState == ConnectionState.waiting
                            ? imagePlaceholder
                            : snapshot.hasError
                                ? imagePlaceholder
                                : snapshot.hasData
                                    ? snapshot.data?.imageUrl != null &&
                                            snapshot.data!.imageUrl!.isNotEmpty
                                        ? Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey.shade300,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: NetworkImageWithProgress(
                                                imageUrl:
                                                    snapshot.data!.imageUrl!,
                                              ),
                                            ),
                                          )
                                        : imagePlaceholder
                                    : imagePlaceholder

                        //   SvgPicture.asset(
                        //     "assets/images/profileplaceholder.svg",
                        //     height: 45,
                        //     width: 45,
                        //   )
                        // else
                        //   Container(
                        //     height: 45,
                        //     width: 45,
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       color: Colors.grey.shade300,
                        //     ),
                        //     child: ClipRRect(
                        //       borderRadius: BorderRadius.circular(50),
                        //       child: NetworkImageWithProgress(
                        //         imageUrl: commentModel.userData!.imageUrl!,
                        //       ),
                        //     ),
                        //   ),
                        ,
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: snapshot.connectionState ==
                                              ConnectionState.waiting
                                          ? _nameText()
                                          : snapshot.hasError
                                              ? _nameText()
                                              : snapshot.hasData
                                                  ? Row(
                                                      children: [
                                                        _nameText(
                                                            name: snapshot
                                                                .data?.name),
                                                        if (snapshot
                                                                .data?.role ==
                                                            UserRole
                                                                .administrator
                                                                .role)
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 5),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        4),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            child: const Text(
                                                              "Admin",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        const Spacer(),
                                                      ],
                                                    )
                                                  : _nameText(),
                                    ),
                                    Text(
                                      formatCommentDate(
                                          commentModel.createdAt ??
                                              DateTime.now()),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  commentModel.comment ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
        );
      },
    );
  }

  final imagePlaceholder = SvgPicture.asset(
    "assets/images/profileplaceholder.svg",
    height: 45,
    width: 45,
  );
  Widget _nameText({String? name}) {
    return Text(
      name ?? "Anonymous",
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }

  String formatCommentDate(DateTime date) {
    final currentTime = DateTime.now();
    final difference = currentTime.difference(date);

    // If the difference is less than 1 hour, show minutes ago
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    }
    // If the difference is less than 24 hours, show hours ago
    else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    }
    // If the difference is less than 30 days, show the date (e.g., Jan 15, 2025)
    else if (difference.inDays < 30) {
      return DateFormat('MMM dd, yyyy').format(date);
    } else {
      return DateFormat('yyyy-MM-dd').format(date);
    }
  }
}
