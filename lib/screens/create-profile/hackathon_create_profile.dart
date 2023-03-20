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

class HackathonCreateProfile extends StatelessWidget {
  const HackathonCreateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      body: BlocBuilder<CreateProfileCubit, CreateProfileCubitState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Column(
              children: [
                const _Toolbar(),
                Section(
                  label: "Shirt Size",
                  child: Select<String>(
                    value: state.shirtSize,
                    items: [
                      SelectItem(label: "XS", value: "XS"),
                      SelectItem(label: "S", value: "S"),
                      SelectItem(label: "M", value: "M"),
                      SelectItem(label: "L", value: "L"),
                      SelectItem(label: "XL", value: "XL"),
                      SelectItem(label: "XXL", value: "XXL"),
                    ],
                    onChanged: (value) {
                      context
                          .read<CreateProfileCubit>()
                          .copyWith(shirtSize: value);
                    },
                  ),
                ),
                Section(
                  label: "Dietary Restriction",
                  required: false,
                  child: TextArea(
                    minLines: 1,
                    value: state.dietaryRestriction,
                    onChanged: (value) {
                      context
                          .read<CreateProfileCubit>()
                          .copyWith(dietaryRestriction: value);
                    },
                  ),
                ),
                Section(
                  label: "Allergies",
                  required: false,
                  child: TextArea(
                    minLines: 1,
                    value: state.allergies,
                    onChanged: (value) {
                      context
                          .read<CreateProfileCubit>()
                          .copyWith(allergies: value);
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
                Button(
                  variant: ButtonVariant.TextButton,
                  onPressed: () {
                    if (state.shirtSize != null) {
                      Navigator.of(context).pushNamed("/submit");
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
          );
        },
      ),
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
