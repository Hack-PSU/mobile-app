import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/bloc/user/user_bloc.dart';
import '../../common/bloc/user/user_event.dart';
import '../../styles/theme_colors.dart';
import '../../widgets/button.dart';
import '../../widgets/default_text.dart';
import '../../widgets/loading.dart';
import '../../widgets/screen/screen.dart';
import 'registration_cubit.dart';

class SubmitRegistration extends StatelessWidget {
  const SubmitRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationCubitState>(
      buildWhen: (prev, curr) => true,
      builder: (context, state) {
        print(state);
        if (state.isSubmitting == null) {
          context.read<RegistrationCubit>().submit();
        }

        if (state.isSubmitting == false) {
          return Screen(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: const [
                  Spacer(),
                  _Complete(),
                  Spacer(),
                ],
              ),
            ),
          );
        }

        return const Loading(label: "Submitting Registration...");
      },
    );
    return Screen(
      body: BlocConsumer<RegistrationCubit, RegistrationCubitState>(
        listener: (context, state) {},
        buildWhen: (prev, curr) {
          return prev != curr;
        },
        builder: (context, state) {
          if (state.isSubmitting == null) {
            print("SUBMIT");
            context.read<RegistrationCubit>().submit();
          }
          if (state.isSubmitting == false) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: const [
                  Spacer(),
                  _Complete(),
                  Spacer(),
                ],
              ),
            );
          }
          return const Loading(label: "Submitting Registration...");
        },
      ),
    );
  }
}

class _Complete extends StatelessWidget {
  const _Complete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DefaultText(
          "Thank you for your registering for HackPSU",
          textLevel: TextLevel.h1,
          textAlign: TextAlign.center,
          fontSize: 35.0,
          maxLines: 3,
        ),
        const SizedBox(height: 20.0),
        DefaultText(
          "We look forward to seeing you at our event",
          textLevel: TextLevel.body1,
          fontSize: 16.0,
          maxLines: 2,
        ),
        const SizedBox(height: 20.0),
        Button(
          variant: ButtonVariant.TextButton,
          onPressed: () {
            context.read<UserBloc>().add(const RegisterUser());
            Navigator.of(context)
                .popUntil((route) => route.settings.name == "/");
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultText("Go Back Home", color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }
}
