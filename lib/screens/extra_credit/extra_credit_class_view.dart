import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/api/extra_credit/extra_credit_assignment_model.dart';
import '../../common/api/extra_credit/extra_credit_class_model.dart';
import '../../styles/theme_colors.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_icons.dart';
import '../../widgets/default_text.dart';
import 'extra_credit_page_cubit.dart';

class ExtraCreditClassView extends StatelessWidget {
  const ExtraCreditClassView({
    Key? key,
    required this.assignments,
    required this.classes,
  }) : super(key: key);

  final Map<int, ExtraCreditAssignment> assignments;
  final List<ExtraCreditClass> classes;

  Function() _onRemoveClass(
    ExtraCreditAssignment assignment,
    String className,
    BuildContext context,
  ) {
    void func() {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return _ConfirmModal(
            title: "Remove Class",
            message:
                "$className will be removed from your extra credit classes.",
            onConfirm: () {
              context
                  .read<ExtraCreditPageCubit>()
                  .unregisterClass(assignment.uid);
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
                "${ecClass.className} will be added to your extra credit classes.",
            onConfirm: () {
              context.read<ExtraCreditPageCubit>().registerClass(ecClass.uid);
            },
          );
        },
      );
    }

    return func;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (assignments.isNotEmpty) ...[
          DefaultText("My Classes", textLevel: TextLevel.h2),
          ...classes
              .where(
                (c) => assignments.keys.contains(c.uid),
              )
              .map(
                (c) => _ExtraCreditClassCard(
                  extraCreditClass: c,
                  onSelectClass: _onRemoveClass(
                    assignments[c.uid]!,
                    c.className,
                    context,
                  ),
                ),
              )
              .toList(),
        ],
        DefaultText("Extra Credit Classes", textLevel: TextLevel.h2),
        ...classes
            .where(
              (c) => !assignments.keys.contains(c.uid),
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
  final Function onSelectClass;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DefaultText(
          extraCreditClass.className,
          textLevel: TextLevel.body1,
        ),
        BlocBuilder<ExtraCreditPageCubit, ExtraCreditPageCubitState>(
          builder: (context, state) {
            if (state.assignments.keys.contains(extraCreditClass.uid)) {
              return const Icon(CustomIcons.selectedClass);
            } else {
              return const Icon(CustomIcons.unselectedClass);
            }
          },
        )
      ],
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
      child: Column(children: [
        DefaultText(
          title,
          textLevel: TextLevel.h2,
          weight: FontWeight.bold,
        ),
        const SizedBox(height: 20),
        DefaultText(
          message,
          textLevel: TextLevel.body1,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Button(
              variant: ButtonVariant.TextButton,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              ),
              onPressed: () => Navigator.of(
                context,
                rootNavigator: true,
              ).pop("dialog"),
              child: DefaultText("Cancel", textLevel: TextLevel.button),
            ),
            Button(
              variant: ButtonVariant.TextButton,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(ThemeColors.StadiumOrange),
              ),
              onPressed: onConfirm,
              child: DefaultText(
                "Confirm",
                textLevel: TextLevel.button,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
