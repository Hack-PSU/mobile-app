import 'package:flutter/material.dart';

import '../../common/api/event.dart';
import '../../styles/theme_colors.dart';
import '../default_text.dart';
import 'agenda.dart';

class AgendaView extends StatefulWidget {
  const AgendaView({
    Key? key,
    required this.data,
    required this.labels,
    required this.groupElement,
    required this.renderItems,
    required this.favorites,
    required this.favoritesEnabled,
  }) : super(key: key);

  final Map<String, List<Event>> data;
  final int Function(Event) groupElement;
  final Widget Function(List<Event>) renderItems;
  final List<String> labels;
  final Set<String?>? favorites;
  final bool favoritesEnabled;

  @override
  State<StatefulWidget> createState() => AgendaViewState();
}

class AgendaViewState extends State<AgendaView> with TickerProviderStateMixin {
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

  List<Widget> _generateTabChildren(Map<String, List<Event>> data) {
    return data.keys
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
            child: Agenda<Event>(
              orientation: Axis.horizontal,
              data: data[key] ?? [],
              groupElement: widget.groupElement,
              renderItems: widget.renderItems,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Event>> data = <String, List<Event>>{};

    for (final String label in widget.labels) {
      List<Event>? eventList = <Event>[];
      if (widget.favoritesEnabled == true) {
        if (widget.data[label] != null) {
          eventList = widget.data[label]!
              .where((e) => widget.favorites!.contains(e.uid))
              .toList();
        }
      } else {
        eventList = widget.data[label];
      }
      data[label] = eventList ?? [];
    }

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
