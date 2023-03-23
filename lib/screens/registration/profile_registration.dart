import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styles/theme_colors.dart';
import '../../widgets/button.dart';
import '../../widgets/default_text.dart';
import '../../widgets/form/Section.dart';
import '../../widgets/form/Select.dart';
import '../../widgets/screen/screen.dart';
import 'registration_cubit.dart';

class ProfileRegistration extends StatelessWidget {
  const ProfileRegistration({Key? key}) : super(key: key);

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
                  label: "Will you be driving?",
                  child: Select<bool>(
                    value: state.driving,
                    onChanged: (value) {
                      context
                          .read<RegistrationCubit>()
                          .copyWith(driving: value);
                    },
                    items: [
                      SelectItem(label: "Yes", value: true),
                      SelectItem(label: "No", value: false),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Section(
                  label: "Is this your first hackathon?",
                  child: Select<bool>(
                    value: state.firstHackathon,
                    onChanged: (value) {
                      context
                          .read<RegistrationCubit>()
                          .copyWith(firstHackathon: value);
                    },
                    items: [
                      SelectItem(label: "Yes", value: true),
                      SelectItem(label: "No", value: false),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Section(
                  label: "Academic Year",
                  child: Select<String>(
                    value: state.academicYear,
                    onChanged: (value) {
                      context
                          .read<RegistrationCubit>()
                          .copyWith(academicYear: value);
                    },
                    items: [
                      SelectItem(label: "Freshman", value: "freshman"),
                      SelectItem(label: "Sophomore", value: "sophomore"),
                      SelectItem(label: "Junior", value: "junior"),
                      SelectItem(label: "Senior", value: "senior"),
                      SelectItem(label: "Graduate", value: "graduate"),
                      SelectItem(label: "Other", value: "other"),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Section(
                  label: "Educational Institution",
                  child: Select<String>(
                    value: state.educationalInstitutionType,
                    onChanged: (value) {
                      context
                          .read<RegistrationCubit>()
                          .copyWith(educationalInstitutionType: value);
                    },
                    items: [
                      SelectItem(
                        label: "Less than Secondary/High School",
                        value: "less-than-secondary",
                      ),
                      SelectItem(
                        label: "Secondary/High School",
                        value: "secondary",
                      ),
                      SelectItem(
                        label: "Undergraduate University (2 years)",
                        value: "two-year-university",
                      ),
                      SelectItem(
                        label: "Undergraduate University (3+ years)",
                        value: "three-plus-year-university",
                      ),
                      SelectItem(
                        label: "Graduate University",
                        value: "graduate-university",
                      ),
                      SelectItem(
                        label: "Code School/Bootcamp",
                        value: "code-school-or-bootcamp",
                      ),
                      SelectItem(
                        label: "Vocational, Trade, or Apprenticeship",
                        value: "vocational-trade-apprenticeship",
                      ),
                      SelectItem(
                        label: "Other",
                        value: "other",
                      ),
                      SelectItem(
                        label: "Not a Student",
                        value: "not-a-student",
                      ),
                      SelectItem(
                        label: "Prefer not to answer",
                        value: "prefer-no-answer",
                      ),
                    ],
                  ),
                ),
                Section(
                  label: "Are you a veteran",
                  child: Select<String>(
                    value: state.veteran,
                    onChanged: (value) {
                      context
                          .read<RegistrationCubit>()
                          .copyWith(veteran: value);
                    },
                    items: [
                      SelectItem(label: "Yes", value: "true"),
                      SelectItem(label: "No", value: "false"),
                      SelectItem(
                        label: "Prefer not to answer",
                        value: "no-disclose",
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Button(
                  variant: ButtonVariant.TextButton,
                  onPressed: () {
                    if (state.driving != null &&
                        state.firstHackathon != null &&
                        state.academicYear != null &&
                        state.educationalInstitutionType != null &&
                        state.veteran != null) {
                      Navigator.of(context)
                          .pushNamed("/registration/experience");
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      ThemeColors.StadiumOrange,
                    ),
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
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 20.0),
                      DefaultText(
                        "Next",
                        color: Colors.white,
                      ),
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
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
