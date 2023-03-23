import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styles/theme_colors.dart';
import '../../widgets/button.dart';
import '../../widgets/default_text.dart';
import '../../widgets/form/Section.dart';
import '../../widgets/form/Select.dart';
import '../../widgets/form/text_area.dart';
import '../../widgets/screen/screen.dart';
import 'create_profile_cubit.dart';

class StartCreateProfile extends StatelessWidget {
  const StartCreateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProfileCubit, CreateProfileCubitState>(
      builder: (context, state) {
        return Screen(
          withDismissKeyboard: true,
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                children: [
                  DefaultText(
                    "Let's start by creating a profile",
                    textLevel: TextLevel.h1,
                    weight: FontWeight.bold,
                    maxLines: 5,
                  ),
                  Section(
                    label: "First Name",
                    child: TextArea(
                      minLines: 1,
                      placeholder: "Enter first name",
                      value: state.firstName,
                      onChanged: (value) {
                        context
                            .read<CreateProfileCubit>()
                            .copyWith(firstName: value);
                      },
                    ),
                  ),
                  Section(
                    label: "Last Name",
                    child: TextArea(
                      minLines: 1,
                      placeholder: "Enter last name",
                      value: state.lastName,
                      onChanged: (value) {
                        context
                            .read<CreateProfileCubit>()
                            .copyWith(lastName: value);
                      },
                    ),
                  ),
                  Section(
                    label: "Preferred Email",
                    child: TextArea(
                      minLines: 1,
                      placeholder: "Enter an email",
                      value: state.email,
                      onChanged: (value) {
                        context
                            .read<CreateProfileCubit>()
                            .copyWith(email: value);
                      },
                    ),
                  ),
                  Section(
                    label: "Gender",
                    child: Select<String>(
                      value: state.gender,
                      items: [
                        SelectItem(label: "Male", value: "male"),
                        SelectItem(label: "Female", value: "female"),
                        SelectItem(label: "Non-Binary", value: "non-binary"),
                        SelectItem(
                          label: "Prefer not to answer",
                          value: "no-disclose",
                        ),
                      ],
                      onChanged: (value) {
                        context
                            .read<CreateProfileCubit>()
                            .copyWith(gender: value);
                      },
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Button(
                    variant: ButtonVariant.TextButton,
                    onPressed: () {
                      if (state.firstName != null &&
                          state.lastName != null &&
                          state.email != null &&
                          state.gender != null) {
                        Navigator.of(context).pushNamed("/university");
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        ThemeColors.StadiumOrange,
                      ),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 4.0, bottom: 4.0, right: 3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 20),
                          DefaultText("Next", color: Colors.white),
                          const Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
