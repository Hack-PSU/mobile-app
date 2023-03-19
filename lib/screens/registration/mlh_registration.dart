import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../styles/theme_colors.dart';
import '../../widgets/button.dart';
import '../../widgets/default_text.dart';
import '../../widgets/form/Section.dart';
import '../../widgets/screen/screen.dart';
import 'registration_cubit.dart';

class MlhRegistration extends StatelessWidget {
  const MlhRegistration({Key? key}) : super(key: key);

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
                  label: "MLH Code of Conduct",
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultText(
                            "I have read and agreed to the",
                          ),
                          GestureDetector(
                            onTap: () async {
                              await launchUrlString(
                                "https://static.mlh.io/docs/mlh-code-of-conduct.pdf",
                              );
                            },
                            child: DefaultText(
                              "MLH Code of Conduct",
                              color: Colors.lightBlue,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Checkbox(
                        value: state.mlhCoc,
                        onChanged: (value) {
                          context
                              .read<RegistrationCubit>()
                              .copyWith(mlhCoc: value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Section(
                  label: "MLH Data Sharing Notice",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                        "By agreeing to this notice, you affirm that: \n'I authorize you to share my registration \ninformation with Major League Hacking\nfor event administration, ranking, MLH\nadministration in-line with the MLH Privacy\nPolicy. I further agree to the terms of both\nthe MLH Contest Terms and Conditions and\nthe MLH Privacy Policy.'",
                        maxLines: 10,
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                "I have read agreed to",
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await launchUrlString(
                                      "https://mlh.io/privacy");
                                },
                                child: DefaultText(
                                  "MLH Privacy Policy",
                                  color: Colors.lightBlue,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await launchUrlString(
                                    "https://github.com/MLH/mlh-policies/blob/main/contest-terms.md",
                                  );
                                },
                                child: DefaultText(
                                  "MLH Contest Terms and Conditions",
                                  color: Colors.lightBlue,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Checkbox(
                            value: state.mlhDcp,
                            onChanged: (value) {
                              context
                                  .read<RegistrationCubit>()
                                  .copyWith(mlhDcp: value);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Button(
                  variant: ButtonVariant.TextButton,
                  onPressed: () {
                    if (state.mlhDcp != false && state.mlhCoc != false) {
                      Navigator.of(context).pushNamed("/registration/submit");
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
