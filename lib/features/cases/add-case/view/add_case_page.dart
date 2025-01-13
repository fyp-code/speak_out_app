import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../../widgets/app_textfield.dart';
import '../../../../widgets/field_label.dart';
import '../../../../widgets/input_validators.dart';
import '../../../../widgets/primary_button.dart';
import '../controller/add_case_controller.dart';

class AddCasePage extends StatelessWidget {
  AddCasePage({super.key});
  final AddCaseController controller = Get.put(AddCaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Case",
          style: TextStyle(),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  controller.imagesList.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  controller.imagesList[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                controller.imagesList.removeAt(index);
                              },
                              icon: const Icon(
                                Icons.cancel,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                const FieldLabel("Case Type"),
                AppTextField(
                  textEditingController: controller.typeController,
                  hint: "Type",
                  readOnly: controller.isLoading.value,
                  validator:
                      InputValidators.required(message: "Type is required"),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'^\s+')),
                  ],
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 15),
                const FieldLabel("Description"),
                AppTextField(
                  textEditingController: controller.descriptionController,
                  hint: "Description",
                  readOnly: controller.isLoading.value,
                  validator: InputValidators.required(
                      message: "Description is required"),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'^\s+')),
                  ],
                  maxLines: 5,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 20),
                AppButton(
                  onPressed: () => controller.onSubmit(context),
                  isLoading: controller.isLoading.value,
                  text: "Add Case",
                  textColor: AppColors.white,
                  backgroundColor: const Color(0xFF242A37),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.pickImages,
        label: const Text("Add Images"),
      ),
    );
  }
}
