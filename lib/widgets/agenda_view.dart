import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../styles/theme_colors.dart';
import 'agenda.dart';
import 'default_text.dart';

class AgendaView<M> extends StatefulWidget {
  const AgendaView({
    Key key,
    @required this.data,
    @required this.labels,
    @required this.groupElement,
    @required this.renderItems,
    this.orientation = Axis.horizontal,
  }) : super(key: key);

  final Axis orientation;
  final Map<String, List<M>> data;
  final int Function(M) groupElement;
  final Widget Function(List<M>) renderItems;
  final List<String> labels;

  @override
  State<StatefulWidget> createState() => AgendaViewState<M>();
}

class AgendaViewState<M> extends State<AgendaView<M>>
    with TickerProviderStateMixin {
  TabController _tabController;
  Map<String, List<M>> data;

  @override
  void initState() {
    super.initState();
    data = Map.fromIterables(
      widget.data.keys.where((el) => widget.labels.contains(el)),
      widget.labels.map((label) => widget.data[label]),
    );
    _tabController = TabController(length: data.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> _generateTabChildren() {
    return data.keys
        .map((key) => Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(224, 224, 224, 1.0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 2).copyWith(top: 8),
              child: Agenda<M>(
                orientation: widget.orientation,
                data: data[key],
                groupElement: widget.groupElement,
                renderItems: widget.renderItems,
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Navigation(
          labels: widget.labels,
          controller: _tabController,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _generateTabChildren(),
          ),
        ),
      ],
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    Key key,
    @required TabController controller,
    @required this.labels,
  })  : _controller = controller,
        super(key: key);

  final List<String> labels;
  final TabController _controller;

  List<Tab> _generateTabs() {
    return labels
        .map((el) => Tab(
              child: Align(
                child: DefaultText(
                  el.toUpperCase(),
                  textLevel: TextLevel.button,
                  weight: FontWeight.bold,
                  fontSize: 13.5,
                ),
              ),
            ))
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
