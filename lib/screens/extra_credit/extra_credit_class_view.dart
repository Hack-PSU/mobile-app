import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/api/extra_credit/extra_credit_class_model.dart';
import '../../styles/theme_colors.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_icons.dart';
import '../../widgets/default_text.dart';
import 'extra_credit_page_cubit.dart';

class ExtraCreditClassView extends StatelessWidget {
  const ExtraCreditClassView({
    Key? key,
  }) : super(key: key);

  Function() _onRemoveClass(
    ExtraCreditClass ecClass,
    BuildContext context,
  ) {
    void func() {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return _ConfirmModal(
            title: "Remove Class",
            message:
                "${ecClass.name.trim()} will be removed from your extra credit classes.",
            onConfirm: () {
              context.read<ExtraCreditPageCubit>().unregisterClass(ecClass.id);
              context.read<ExtraCreditPageCubit>().refetch();
            },
          );
        },
      );
    }

    return func;
  }

  Function() _onAddClass(
    ExtraCreditClass ecClass,
    BuildContext context,
  ) {
    void func() {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return _ConfirmModal(
            title: "Add Class",
            message:
                "${ecClass.name.trim()} will be added to your extra credit classes.",
            onConfirm: () {
              context.read<ExtraCreditPageCubit>().registerClass(ecClass.id);
              context.read<ExtraCreditPageCubit>().refetch();
            },
          );
        },
      );
    }

    return func;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExtraCreditPageCubit, ExtraCreditPageCubitState>(
      builder: (context, state) {
        return ListView(
          children: [
            if (state.assignments.isNotEmpty) ...[
              DefaultText(
                "My Classes",
                textLevel: TextLevel.h3,
                weight: FontWeight.bold,
              ),
              ...state.classes
                  .where(
                    (c) => state.assignments.keys.contains(c.id),
                  )
                  .map(
                    (c) => _ExtraCreditClassCard(
                      extraCreditClass: c,
                      onSelectClass: _onRemoveClass(
                        state.assignments[c.id]!,
                        context,
                      ),
                    ),
                  )
                  .toList(),
              const SizedBox(height: 30.0),
            ],
            DefaultText(
              "Offered Classes",
              textLevel: TextLevel.h3,
              weight: FontWeight.bold,
            ),
            ...state.classes
                .where(
                  (c) => !state.assignments.keys.contains(c.id),
                )
                .map(
                  (c) => _ExtraCreditClassCard(
                    extraCreditClass: c,
                    onSelectClass: _onAddClass(
                      c,
                      context,
                    ),
                  ),
                )
                .toList(),
          ],
        );
      },
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    Key? key,
    required TabController? controller,
    required this.labels,
  })  : _controller = controller,
        super(key: key);

  final List<String> labels;
  final TabController? _controller;

  List<Tab> _generateTabs() {
    return labels
        .map(
          (el) => Tab(
            child: Align(
              child: DefaultText(
                el.toUpperCase(),
                textLevel: TextLevel.button,
                weight: FontWeight.bold,
                fontSize: 13.5,
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: labels.length,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: TabBar(
          controller: _controller,
          tabs: _generateTabs(),
          unselectedLabelColor: Colors.black,
          labelColor: ThemeColors.HackyBlue,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          indicator: ShapeDecoration(
            color: ThemeColors.addAlpha(ThemeColors.HackyBlue, 0.08),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExtraCreditClassCard extends StatelessWidget {
  const _ExtraCreditClassCard({
    Key? key,
    required this.extraCreditClass,
    required this.onSelectClass,
  }) : super(
          key: key,
        );

  final ExtraCreditClass extraCreditClass;
  final void Function() onSelectClass;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectClass,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ThemeColors.addAlpha(
                Colors.black,
                0.08,
              ),
              width: 1.5,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DefaultText(
              extraCreditClass.name.trim(),
              textLevel: TextLevel.body1,
              fontSize: 16.0,
              weight: FontWeight.w500,
            ),
            BlocBuilder<ExtraCreditPageCubit, ExtraCreditPageCubitState>(
              builder: (context, state) {
                if (state.assignments.keys.contains(extraCreditClass.id)) {
                  return const Icon(
                    CustomIcons.selectedClass,
                    color: Colors.green,
                  );
                } else {
                  return const Icon(
                    CustomIcons.unselectedClass,
                    color: ThemeColors.StadiumOrange,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class _ConfirmModal extends StatelessWidget {
  const _ConfirmModal({
    Key? key,
    required this.title,
    required this.message,
    required this.onConfirm,
  }) : super(key: key);

  final String title;
  final String message;
  final dynamic Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultText(
                  title,
                  textLevel: TextLevel.h4,
                  weight: FontWeight.bold,
                ),
                const SizedBox(height: 8.0),
                DefaultText(
                  message,
                  textLevel: TextLevel.body1,
                  maxLines: 2,
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Button(
                        variant: ButtonVariant.TextButton,
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        onPressed: () => Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pop("dialog"),
                        child: DefaultText(
                          "Cancel",
                          textLevel: TextLevel.button,
                          height: 1.25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Button(
                        variant: ButtonVariant.TextButton,
                        style: TextButton.styleFrom(
                          backgroundColor: ThemeColors.StadiumOrange,
                        ),
                        onPressed: () {
                          onConfirm();
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pop("dialog");
                        },
                        child: DefaultText(
                          "Confirm",
                          textLevel: TextLevel.button,
                          color: Colors.white,
                          height: 1.25,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
