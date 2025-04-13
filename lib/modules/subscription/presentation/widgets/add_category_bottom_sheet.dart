import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:subsciption_manager/config/constants/app_constants.dart';
import 'package:subsciption_manager/config/constants/colors.dart';
import 'package:subsciption_manager/modules/subscription/data/models/subscription_group_model.dart';
import 'package:subsciption_manager/modules/subscription/presentation/widgets/custom_check_box.dart';

class AddCategoryBottomSheet extends StatefulWidget {
  final ValueChanged<SubscriptionGroupModel> onSaved;

  const AddCategoryBottomSheet({
    super.key,
    required this.onSaved,
  });

  @override
  State<AddCategoryBottomSheet> createState() => _AddCategoryBottomSheetState();
}

class _AddCategoryBottomSheetState extends State<AddCategoryBottomSheet> {
  late final ValueNotifier<bool> _enableButtonNotifier;
  late final TextEditingController _nameController;
  late final List<String> _selectedSubscriptions = [];

  void _checkButtonStatus() {
    final bool nameAvailable = _nameController.text.trim().isNotEmpty;
    final bool anyItemSelected = _selectedSubscriptions.isNotEmpty;
    _enableButtonNotifier.value = nameAvailable && anyItemSelected;
  }

  @override
  void initState() {
    super.initState();
    _enableButtonNotifier = ValueNotifier(false);
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _enableButtonNotifier.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      key: const Key("addCategoryBottomSheetKey"),
      filter: ImageFilter.blur(
        sigmaX: 1.0,
        sigmaY: 1.0,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.90,
          decoration: const BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 36.0,
              ),
              Text(
                "Add a category",
                style: GoogleFonts.redHatDisplay(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Text(
                "Enter a name",
                style: GoogleFonts.redHatDisplay(
                  color: Colors.white,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 2.0,
              ),
              TextFormField(
                key: const Key('categoryNameFieldKey'),
                cursorColor: AppColors.blue,
                controller: _nameController,
                onChanged: (_) => _checkButtonStatus(),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    borderSide: const BorderSide(color: AppColors.blue),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 18.0),
                child: Text(
                  "Select subscriptions",
                  style: GoogleFonts.redHatDisplay(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: AppConstants.subscriptions.length,
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 16.0,
                  ),
                  itemBuilder: (context, index) {
                    final item =
                        AppConstants.subscriptions.values.elementAt(index);
                    return Row(
                      children: [
                        Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Image.asset(
                              item.imagePath,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          item.name,
                          key: Key("addCategorySubscriptionListTileKey$index"),
                          style: GoogleFonts.redHatDisplay(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        CustomCheckbox(
                          key: Key('subscriptionCheckBoxKey$index'),
                          onChanged: (bool val) {
                            if (val == true) {
                              _selectedSubscriptions.add(item.name);
                            } else {
                              _selectedSubscriptions
                                  .removeWhere((e) => e == item.name);
                            }
                            _checkButtonStatus();
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ValueListenableBuilder(
                    valueListenable: _enableButtonNotifier,
                    builder: (context, value, _) {
                      return ElevatedButton(
                        key: const Key("saveButtonKey"),
                        onPressed: value
                            ? () {
                                final SubscriptionGroupModel subsModel =
                                    SubscriptionGroupModel(
                                  _nameController.text.trim(),
                                  _selectedSubscriptions,
                                );
                                widget.onSaved(subsModel);
                                Navigator.pop(context);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          disabledBackgroundColor:
                              Colors.white.withValues(alpha: 0.1),
                          fixedSize:
                              Size(MediaQuery.sizeOf(context).width, 52.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: AppColors.blue,
                        ),
                        child: Text(
                          "Save",
                          style: GoogleFonts.redHatDisplay(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
