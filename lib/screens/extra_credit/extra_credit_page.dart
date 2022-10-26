import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/screen/screen.dart';
import '../../common/api/extra_credit/extra_credit_repository.dart';
import '../../widgets/loading.dart';
import '../../widgets/view/agenda_view.dart';
import 'extra_credit_page_cubit.dart';


class ExtraCreditPage extends StatelessWidget {
  const ExtraCreditPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExtraCreditPageCubit>(
      create: (context) => ExtraCreditPageCubit(
        context.read<ExtraCreditRepository>(),
      ),
      child: Screen(
        body: BlocBuilder<ExtraCreditPageCubit, ExtraCreditPageCubitState>(
          builder: (context, state) {
            if (state.status == PageStatus.idle) {
              context.read<ExtraCreditPageCubit>().init();
            }
            if (state.status == PageStatus.ready) {
              return const ExtraCreditPage();
            }
            return const Loading(
              label: "Loading classes",
            );
          },
        ),
      ),
    );
  }
}

class ExtraCreditScreen extends StatelessWidget {
  const ExtraCreditScreen({Key? key}) : super(key: key);

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

