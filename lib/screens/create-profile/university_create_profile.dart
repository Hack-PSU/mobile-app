import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styles/theme_colors.dart';
import '../../widgets/button.dart';
import '../../widgets/default_text.dart';
import '../../widgets/form/Section.dart';
import '../../widgets/form/text_area.dart';
import '../../widgets/screen/screen.dart';
import 'create_profile_cubit.dart';

class UniversityCreateProfile extends StatelessWidget {
  const UniversityCreateProfile({Key? key}) : super(key: key);

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
                  label: "University",
                  required: false,
                  child: TextArea(
                    minLines: 1,
                    value: state.university,
                    onChanged: (value) {
                      context
                          .read<CreateProfileCubit>()
                          .copyWith(university: value);
                    },
                  ),
                ),
                Section(
                  label: "Major",
                  required: false,
                  child: TextArea(
                    minLines: 1,
                    value: state.major,
                    onChanged: (value) {
                      context.read<CreateProfileCubit>().copyWith(major: value);
                    },
                  ),
                ),
                Section(
                  label: "Phone",
                  child: TextArea(
                    minLines: 1,
                    value: state.phone,
                    onChanged: (value) {
                      context.read<CreateProfileCubit>().copyWith(phone: value);
                    },
                  ),
                ),
                Section(
                  label: "Country",
                  child: TextArea(
                    minLines: 1,
                    placeholder: "Enter a country",
                    value: state.country,
                    onChanged: (value) {
                      context
                          .read<CreateProfileCubit>()
                          .copyWith(country: value);
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
                Button(
                  variant: ButtonVariant.TextButton,
                  onPressed: () {
                    if (state.phone != null && state.country != null) {
                      Navigator.of(context).pushNamed("/hackathon");
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
