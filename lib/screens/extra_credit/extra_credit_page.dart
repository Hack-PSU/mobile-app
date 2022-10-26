import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/screen/screen.dart';
import '../../common/api/extra_credit/extra_credit_repository.dart';
import '../../styles/theme_colors.dart';
import '../../widgets/default_text.dart';
import '../../widgets/loading.dart';
import 'extra_credit_page_cubit.dart';


class ExtraCreditPage extends StatelessWidget {
  const ExtraCreditPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return BlocProvider<ExtraCreditPageCubit>(
    //   create: (context) => ExtraCreditPageCubit(
    //     context.read<ExtraCreditRepository>(),
    //   ),
    //   child: Screen(
    //     body: BlocBuilder<ExtraCreditPageCubit, ExtraCreditPageCubitState>(
    //       builder: (context, state) {
    //         if (state.status == PageStatus.idle) {
    //           context.read<ExtraCreditPageCubit>().init();
    //         }
    //         if (state.status == PageStatus.ready) {
    //           return const ExtraCreditPage();
    //         }
    //         return const Loading(
    //           label: "Loading classes",
    //         );
    //       },
    //     ),
    //   ),
    // );
    return Screen(
      body: ExtraCreditScreen(),
    );
  }
}

class ExtraCreditScreen extends StatelessWidget {
  const ExtraCreditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    body: return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column (
        children: const <Widget>[
        _Toolbar(),
        Expanded (
          child: ClassView(classes: ["classes","asdfjasd;f","asdf"], labels: ["labels","other"])
        ),
      ],
    )
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

class _Classes {
  const _Classes({
    required this.name,
    required this.uid,
  });
  final String name;
  final String uid;
}

class ClassView extends StatefulWidget {
  const ClassView({
    Key? key,
    required this.classes,
    required this.labels,
  }) : super(key: key);

  final List<String> classes;
  final List<String> labels;


  @override
  State<StatefulWidget> createState() => ClassViewState();
}

class ClassViewState extends State<ClassView> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.labels.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  List<Widget> _generateTabChildren(Map<String, List<_Classes>> classes) {
    return classes.keys
        .map(
          (key) => Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(245, 245, 245, 1.0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 2).copyWith(top: 8),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, List<_Classes>> data = <String, List<_Classes>>{};



    return Column(
      children: [
        _Navigation(
          labels: widget.labels,
          controller: _tabController,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _generateTabChildren(data),
          ),
        ),
      ],
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    Key? key,
    required TabController? controller,
    required this.labels,
  })  : _controller = controller,
        super(key: key);

  final List<String> labels;
  final TabController? _controller;

  List<Tab> _generateTabs() {
    return labels
        .map(
          (el) => Tab(
            child: Align(
              child: DefaultText(
                el.toUpperCase(),
                textLevel: TextLevel.button,
                weight: FontWeight.bold,
                fontSize: 13.5,
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: labels.length,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: TabBar(
          controller: _controller,
          tabs: _generateTabs(),
          unselectedLabelColor: Colors.black,
          labelColor: ThemeColors.HackyBlue,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          indicator: ShapeDecoration(
            color: ThemeColors.addAlpha(ThemeColors.HackyBlue, 0.08),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
