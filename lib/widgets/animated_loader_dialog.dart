import 'package:breez/theme_data.dart' as theme;
import 'package:flutter/material.dart';
import 'package:breez/l10n/locales.dart';

import 'loading_animated_text.dart';

AlertDialog createAnimatedLoaderDialog(
  BuildContext context,
  String text, {
  bool withOKButton = true,
}) {
  return AlertDialog(
    contentPadding: EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
    content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        LoadingAnimatedText(
          text,
          textStyle: Theme.of(context).dialogTheme.contentTextStyle,
          textAlign: TextAlign.center,
        ),
        Image.asset(
          theme.themeId == "BLUE"
              ? 'src/images/breez_loader_blue.gif'
              : 'src/images/breez_loader_dark.gif',
          height: 64.0,
          gaplessPlayback: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: withOKButton
              ? [
                  TextButton(
                    child: Text(
                      context.l10n.backup_in_progress_action_confirm,
                      style: Theme.of(context).primaryTextTheme.button,
                    ),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ]
              : [],
        ),
      ],
    ),
  );
}
