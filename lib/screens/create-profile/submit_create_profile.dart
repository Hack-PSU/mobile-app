import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styles/theme_colors.dart';
import '../../widgets/button.dart';
import '../../widgets/default_text.dart';
import '../../widgets/loading.dart';
import '../../widgets/screen/screen.dart';
import 'create_profile_cubit.dart';

class SubmitCreateProfile extends StatelessWidget {
  const SubmitCreateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screen(
      body: BlocBuilder<CreateProfileCubit, CreateProfileCubitState>(
        builder: (context, state) {
          if (state.isSubmitting == null) {
            context.read<CreateProfileCubit>().submit();
          }

          if (state.isSubmitting == false) {
            return const _Complete();
          }

          return const Loading(label: "Submitting Profile...");
        },
      ),
    );
  }
}

class _Complete extends StatelessWidget {
  const _Complete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProfileCubit, CreateProfileCubitState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Column(
            children: [
              const Spacer(),
              DefaultText(
                "Your Profile is Created!",
                maxLines: 3,
                textAlign: TextAlign.center,
                fontSize: 40.0,
                textLevel: TextLevel.h1,
              ),
              const SizedBox(height: 10.0),
              DefaultText(
                "We hope to see you in one of our events",
                fontSize: 16.0,
                textAlign: TextAlign.center,
                textLevel: TextLevel.caption,
                maxLines: 3,
              ),
              const SizedBox(height: 30.0),
              Button(
                variant: ButtonVariant.TextButton,
                onPressed: () {
                  context.read<CreateProfileCubit>().goToMain();
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
                  padding:
                      const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultText("Go Back Home", color: Colors.white),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
