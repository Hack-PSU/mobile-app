import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_state.dart';
import '../styles/theme_colors.dart';
import 'default_text.dart';

class Agenda<M> extends StatelessWidget {
  const Agenda({
    Key key,
    @required this.orientation,
    @required this.data,
    @required this.groupElement,
    @required this.renderItems,
  }) : super(key: key);

  final Axis orientation;
  final List<M> data;
  final int Function(M) groupElement;
  final Widget Function(List<M>) renderItems;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultText(
            "No Events...",
            textLevel: TextLevel.h1,
            fontSize: 34,
            textAlign: TextAlign.center,
          ),
          DefaultText(
            "Check back later!",
            maxLines: 2,
            textLevel: TextLevel.h1,
            fontSize: 34,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    final elements = groupBy<M, int>(data, groupElement);
    final sortedKeys =
        elements.keys.toSet().toList().sorted((a, b) => a.compareTo(b));

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      itemCount: sortedKeys.length,
      itemBuilder: (context, int index) {
        final int key = sortedKeys[index];
        return _Block(
          separator: key,
          items: elements[key],
          orientation: orientation,
          renderItems: renderItems,
        );
      },
      separatorBuilder: (context, int index) {
        return const SizedBox(height: 20);
      },
    );
  }
}

class _Block<M> extends StatelessWidget {
  const _Block({
    @required this.separator,
    @required this.items,
    @required this.orientation,
    @required this.renderItems,
  });

  final List<M> items;
  final int separator;
  final Axis orientation;
  final Widget Function(List<M>) renderItems;

  String _formatTime() {
    final DateFormat formatter = DateFormat("h:mm a");
    return formatter
        .format(DateTime.fromMillisecondsSinceEpoch(separator))
        .toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        return Flex(
          direction: orientation,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  (orientation == Axis.horizontal ? 0.2 : 1),
              child: DefaultText(
                _formatTime(),
                textLevel: TextLevel.h3,
                weight: FontWeight.bold,
                color: ThemeColors.HackyBlue,
                maxLines: 2,
                textAlign: TextAlign.right,
              ),
            ),
            if (orientation == Axis.horizontal) const SizedBox(width: 10),
            if (orientation == Axis.vertical) const SizedBox(height: 10),
            Expanded(
              child: renderItems(items),
            ),
          ],
        );
      },
    );
  }
}
