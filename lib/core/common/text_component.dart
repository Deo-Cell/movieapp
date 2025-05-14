import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_colors.dart';

class TextComponent extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final FontStyle? fontstyle;
  final double? fontsize;
  final FontWeight? fontweight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final Color? textcolor;
  final int? maxLines;
  final String? fontfamily;
  final TextDecoration? decoration;
  final Color? decorationcolor;
  final int? decorationthinkness;
  final TextAlign? textalign;
  final bool expandable;
  final String expandText;
  final String collapseText;
  final int initialMaxLines;

  const TextComponent(
    this.text, {
    super.key,
    this.style,
    this.fontstyle,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.fontsize,
    this.fontweight,
    this.textcolor,
    this.fontfamily,
    this.decoration,
    this.decorationcolor,
    this.decorationthinkness,
    this.textalign,
    this.expandable = false,
    this.expandText = 'Voir plus',
    this.collapseText = 'Voir moins',
    this.initialMaxLines = 3,
  });

  @override
  State<TextComponent> createState() => _TextComponentState();
}

class _TextComponentState extends State<TextComponent> {
  bool _expanded = false;

  TextStyle get _textStyle => widget.style ??
      TextStyle(
        fontSize: widget.fontsize,
        fontWeight: widget.fontweight,
        color: widget.textcolor,
        decoration: widget.decoration,
        decorationColor: widget.decorationcolor,
        decorationThickness: widget.decorationthinkness?.toDouble(),
        fontFamily: widget.fontfamily,
        fontStyle: widget.fontstyle,
      );

  @override
  Widget build(BuildContext context) {
    if (!widget.expandable) {
      return Text(
        widget.text,
        style: _textStyle,
        textAlign: widget.textalign ?? widget.textAlign,
        overflow: widget.overflow,
        maxLines: widget.maxLines,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          firstChild: Text(
            widget.text,
            style: _textStyle,
            textAlign: widget.textalign ?? widget.textAlign,
            maxLines: widget.initialMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
          secondChild: Text(
            widget.text,
            style: _textStyle,
            textAlign: widget.textalign ?? widget.textAlign,
          ),
          crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
        if (_needsExpandButton())
          GestureDetector(
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Text(
                _expanded ? widget.collapseText : widget.expandText,
                style: TextStyle(
                  color: AppColors.neonBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
      ],
    );
  }

  bool _needsExpandButton() {
    // Méthode pour vérifier si le texte est assez long pour nécessiter un bouton d'expansion
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: _textStyle,
      ),
      textDirection: TextDirection.ltr,
      maxLines: widget.initialMaxLines,
    )..layout(maxWidth: MediaQuery.of(context).size.width * 0.8);

    return textPainter.didExceedMaxLines;
  }
}