import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../widgets/screen/screen.dart';
import '../extraCredit/extraCredit_page_cubit.dart';

class extraCreditPage extends StatelessWidget {
  const extraCreditPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExtraCreditCubitState(),
      child: Screen(
        body: const extraCreditScreen(),
      ),
    );
  }
}


class extraCreditScreen extends StatelessWidget {
  const extraCreditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(children: const [
        _Toolbar(),
        SizedBox(height: 20.0),
      ]),
    );
  }
}

class _Toolbar extends StatelessWidget {
  const _Toolbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back, size: 25.0),
          ),
        ],
      ),
    );
  }
}
