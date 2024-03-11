import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styles/theme_colors.dart';
import '../../widgets/button.dart';
import '../../widgets/default_text.dart';
import '../../widgets/screen/screen.dart';
import 'registration_cubit.dart';

class StartRegistration extends StatelessWidget {
  const StartRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationCubitState>(
      builder: (context, state) {
        return Screen(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                DefaultText(
                  "Register for HackPSU",
                  textLevel: TextLevel.h1,
                  fontSize: 50.0,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
                DefaultText(
                  "By continuing with this registration, you are confirming that you are at least 18 years old before March 16th.",
                  textAlign: TextAlign.left,
                  textLevel: TextLevel.body1,
                  maxLines: 5,
                ),
                const SizedBox(height: 30),
                Button(
                  variant: ButtonVariant.TextButton,
                  onPressed: () {
                    context
                        .read<RegistrationCubit>()
                        .copyWith(eighteenBeforeEvent: true);
                    Navigator.of(context).pushNamed("/registration/profile");
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
                        DefaultText("Start", color: Colors.white),
                        const Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Button(
                  variant: ButtonVariant.OutlinedButton,
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultText("Cancel", color: Colors.red),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
