import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher_string.dart';

const defaultTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 14,
);

const defaultHyperlinkStyle = TextStyle(
  color: Colors.blueAccent,
  decoration: TextDecoration.underline,
  fontSize: 14,
);

class Style {
  Style({
    this.link,
    this.textStyle = defaultTextStyle,
  });

  final String? link;
  final TextStyle textStyle;

  Style copyWith({
    String? link,
    TextStyle? textStyle,
  }) {
    return Style(
      link: link ?? this.link,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}

class RenderHtml extends StatelessWidget {
  RenderHtml(
    this.html, {
    Key? key,
    this.textStyle = defaultTextStyle,
    this.hyperlinkStyle = defaultHyperlinkStyle,
  })  : document = parse(html),
        super(key: key);

  final String html;
  final dom.Document document;
  final TextStyle? textStyle;
  final TextStyle? hyperlinkStyle;

  /// Receives an element and resolves the TextStyle based on the element tag.
  /// Styles are propagated downwards by extending previous style specifications.
  Style _parseElementStyle(dom.Element element, Style? style) {
    Style newStyle = style ?? Style();

    switch (element.localName) {
      case "b":
        final TextStyle newTextStyle =
            newStyle.textStyle.copyWith(fontWeight: FontWeight.bold);
        newStyle = newStyle.copyWith(textStyle: newTextStyle);
        break;
      case "i":
        final TextStyle newTextStyle =
            newStyle.textStyle.copyWith(fontStyle: FontStyle.italic);
        newStyle = newStyle.copyWith(textStyle: newTextStyle);
        break;
      case "u":
        final TextStyle newTextStyle =
            newStyle.textStyle.copyWith(decoration: TextDecoration.underline);
        newStyle = newStyle.copyWith(textStyle: newTextStyle);
        break;
      case "a":
        final TextStyle newTextStyle =
            newStyle.textStyle.merge(hyperlinkStyle ?? defaultHyperlinkStyle);
        newStyle = newStyle.copyWith(
          link: element.attributes["href"],
          textStyle: newTextStyle,
        );
        break;
    }

    return newStyle;
  }

  /// Flutter does not have a hyperlink widget, so implementing the recognizer
  /// field under TextSpan is required to listen to a tap gesture.
  TextSpan _resolveHyperlinkElement(TextSpan span, Style? style) {
    final tapGesture = style?.link != null
        ? (TapGestureRecognizer()
          ..onTap = () async {
            if (await canLaunchUrlString(style?.link ?? "")) {
              await launchUrlString(style?.link ?? "");
            }
          })
        : span.recognizer;

    return TextSpan(
      text: span.text,
      locale: span.locale,
      mouseCursor: span.mouseCursor,
      onEnter: span.onEnter,
      onExit: span.onExit,
      semanticsLabel: span.semanticsLabel,
      spellOut: span.spellOut,
      style: style?.textStyle ?? defaultHyperlinkStyle,
      children: span.children,
      recognizer: tapGesture,
    );
  }

  /// Receives an HTML element (p tag indicating content) and recursively builds
  /// a tree out of TextSpan widgets while propagating style down nested HTML
  /// elements. The function parses the element by treating nested elements
  /// as a tree and visits them using a preorder traversal.
  TextSpan _parseHtml(dom.Element element, Style? style) {
    if (element.nodes.isEmpty) {
      // element is plain text
      return TextSpan(
        text: element.text,
        style: _parseElementStyle(element, style).textStyle,
      );
    }
    // remaining cases are when element is an HTML tag
    // (can contain more than 1 node -- either a text or more HTML elements)
    else if (element.nodes.length == 1) {
      final remNode = element.nodes[0];

      if (remNode.nodeType == dom.Node.TEXT_NODE) {
        return TextSpan(
          text: remNode.text ?? "",
          style: style?.textStyle ?? defaultTextStyle,
        );
      } else {
        final nodeStyle = _parseElementStyle(remNode as dom.Element, style);
        TextSpan span = _parseHtml(remNode, nodeStyle);

        if (remNode.localName == "a") {
          span = _resolveHyperlinkElement(span, nodeStyle);
        }

        return span;
      }
    } else {
      final List<TextSpan> children = [];
      for (final dom.Node node in element.nodes) {
        if (node.nodeType == dom.Node.TEXT_NODE) {
          children.add(
            TextSpan(
              text: node.text ?? "",
              style: style?.textStyle ?? defaultTextStyle,
            ),
          );
        } else if (node.nodeType == dom.Node.ELEMENT_NODE) {
          final localName = (node as dom.Element).localName;
          final nodeStyle = _parseElementStyle(node, style);
          TextSpan span = _parseHtml(node, nodeStyle);

          if (localName == "a") {
            span = _resolveHyperlinkElement(span, nodeStyle);
          }

          children.add(span);
        }
      }

      return TextSpan(children: children);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dom.Element> elements = document.getElementsByTagName("p");

    if (elements.isEmpty) {
      elements = parse('<p>$html</p>').getElementsByTagName("p");
    }

    return RichText(
      text: TextSpan(
        children: elements
            .map(
              (element) => _parseHtml(
                element,
                Style(
                  textStyle: textStyle ?? defaultTextStyle,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
