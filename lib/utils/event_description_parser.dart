import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';

// TODO(susanto-tm): Refactor Style and Span to use TextSpan and nested Links
class Style {
  Style({
    this.link = "",
    this.bold = false,
    this.italic = false,
    this.underline = false,
  });

  Style copyWith({String? link, bool? bold, bool? italic, bool? underline}) {
    return Style(
      link: link ?? this.link,
      bold: bold ?? this.bold,
      italic: italic ?? this.italic,
      underline: underline ?? this.underline,
    );
  }

  @override
  String toString() {
    return "${link != "" ? "link: $link" : ""}--${bold || italic || underline ? "styles ${bold ? "bold" : ""}//${italic ? "italic" : ""}//${underline ? "underline" : ""}" : ""}";
  }

  final String link;
  final bool bold;
  final bool italic;
  final bool underline;
}

class Span {
  Span(this.text, {this.style, this.children});

  String text;
  List<Span>? children;
  Style? style;
}

/// Determine the styles of an HTML element based on its tag (localName)
Style parseElementStyle(dom.Element element, Style? style) {
  final elementTag = element.localName;

  Style newStyle = style ?? Style();

  if (elementTag == "b") {
    newStyle = newStyle.copyWith(bold: true);
  } else if (elementTag == "i") {
    newStyle = newStyle.copyWith(italic: true);
  } else if (elementTag == "u") {
    newStyle = newStyle.copyWith(underline: true);
  } else if (elementTag == "a") {
    newStyle = newStyle.copyWith(link: element.attributes["href"]);
  }

  return newStyle;
}

/// Recursively call parseSpan to parse elements while inheriting the parent's styles.
/// If an <a> tag is enclosed within a <b> tag, then the Span specifying the contents of the
/// <a> tag will inherit the <b> tag styling.
Span parseSpan(dom.Element elem, Style? style) {
  if (elem.nodes.isEmpty) {
    // elem is plain text
    return Span(elem.text, style: parseElementStyle(elem, style));
  } else {
    // elem is an HTML tag (can contain more than 1 node -- either a text or a nested HTML element)

    // filtered removes unnecessary tags (ie. a space that has styling)
    final filtered =
    elem.nodes.where((n) => n.text?.trim().isNotEmpty ?? false).toList();

    final List<Span> children = [];

    if (elem.nodes.length > 1) {
      for (final dom.Node node in filtered) {
        if (node.nodeType == dom.Node.TEXT_NODE) {
          children.add(Span(node.text ?? "", style: style));
        } else if (node.nodeType == dom.Node.ELEMENT_NODE) {
          children.add(
            parseSpan(
              node as dom.Element,
              parseElementStyle(node, style),
            ),
          );
        }
      }

      return Span("", children: children);
    } else {
      final remNode = elem.nodes[0];
      if (remNode.nodeType == dom.Node.TEXT_NODE) {
        return Span(remNode.text ?? "", style: style);
      } else {
        return parseSpan(
          remNode as dom.Element,
          parseElementStyle(
            remNode,
            style,
          ),
        );
      }
    }
  }
}

/// Takes an HTML string as an input and outputs a tree of TextSpans that renders
/// RichText that includes its styling features.
void test(List<String> arguments) {
  final document = parse(
      '<p>Hello<b> </b><i><b>there </b></i><b>I am a <a href="https://google.com" rel="noreferrer noopener" target="_blank">link</a></b></p>');

  final content = document.getElementsByTagName("p")[0];

  final span = parseSpan(content, null);

  print(span.children?[0].text);
  print(span.children?[1].text);
  print(span.children?[2].children?[0].style);
  print(span.children?[2].children?[1].style);
}