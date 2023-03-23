import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styles/theme_colors.dart';
import '../../widgets/button.dart';
import '../../widgets/default_text.dart';
import '../../widgets/form/Section.dart';
import '../../widgets/form/Select.dart';
import '../../widgets/form/text_area.dart';
import '../../widgets/screen/screen.dart';
import 'registration_cubit.dart';

class ExperienceRegistration extends StatelessWidget {
  const ExperienceRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationCubitState>(
      builder: (context, state) {
        return Screen(
          body: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 8.0),
            child: Column(
              children: [
                const _Toolbar(),
                Section(
                  label: "Coding Experience",
                  child: Select<String>(
                    value: state.codingExperience,
                    onChanged: (value) {
                      context
                          .read<RegistrationCubit>()
                          .copyWith(codingExperience: value);
                    },
                    items: [
                      SelectItem(
                        label: "None",
                        value: "none",
                      ),
                      SelectItem(
                        label: "Beginner",
                        value: "beginner",
                      ),
                      SelectItem(
                        label: "Intermediate",
                        value: "Intermediate",
                      ),
                      SelectItem(
                        label: "Advanced",
                        value: "advanced",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Section(
                  label: "Expectations for the Hackathon",
                  required: false,
                  child: TextArea(
                    placeholder: "Enter expectations",
                    value: state.expectations,
                    onChanged: (value) {
                      context
                          .read<RegistrationCubit>()
                          .copyWith(expectations: value);
                    },
                  ),
                ),
                const Spacer(),
                Button(
                  variant: ButtonVariant.TextButton,
                  onPressed: () {
                    if (state.expectations == null) {
                      context
                          .read<RegistrationCubit>()
                          .copyWith(expectations: "");
                    }

                    if (state.codingExperience != null) {
                      Navigator.of(context).pushNamed("/registration/mlh");
                    }
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 8.0,
                      ),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      ThemeColors.StadiumOrange,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 20.0),
                      DefaultText("Next", color: Colors.white),
                      const Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Toolbar extends StatelessWidget {
  const _Toolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Button(
          variant: ButtonVariant.IconButton,
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
