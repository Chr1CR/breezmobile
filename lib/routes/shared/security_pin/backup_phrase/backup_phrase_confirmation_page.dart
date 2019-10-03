import 'package:auto_size_text/auto_size_text.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:breez/theme_data.dart' as theme;
import 'package:breez/utils/min_font_size.dart';
import 'package:breez/widgets/back_button.dart' as backBtn;
import 'package:breez/widgets/route.dart';
import 'package:flutter/material.dart';

import 'generate_backup_phrase_page.dart';

class BackupPhraseGeneratorConfirmationPage extends StatefulWidget {
  @override
  BackupPhraseGeneratorConfirmationPageState createState() => new BackupPhraseGeneratorConfirmationPageState();
}

class BackupPhraseGeneratorConfirmationPageState extends State<BackupPhraseGeneratorConfirmationPage> {
  bool _isUnderstood = false;
  String _instructions =
      "You will be shown a list of words. Write down the words and store them in a safe place. Without these words, you won't be able to restore from backup and you funds will be lost. Breez won’t be able to help.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: theme.appBarIconTheme,
            textTheme: theme.appBarTextTheme,
            backgroundColor: Theme.of(context).canvasColor,
            automaticallyImplyLeading: false,
            leading: backBtn.BackButton(),
            title: AutoSizeText(
              "Generate Backup Phrase",
              style: theme.appBarTextStyle,
              maxLines: 1,
            ),
            elevation: 0.0),
        body: Column(
          children: <Widget>[
            SizedBox(height: 105),
            _buildBackupPhraseImage(),
            SizedBox(height: 72),
            _buildInstructions(),
            SizedBox(height: 48),
            _buildCheckbox(),
          ],
        ),
        bottomNavigationBar: _buildNextBtn(_isUnderstood));
  }

  Image _buildBackupPhraseImage() {
    return Image(
      image: AssetImage("src/images/generate_backup_phrase.png"),
      height: 100,
      width: 100,
    );
  }

  Padding _buildInstructions() {
    return Padding(
      padding: EdgeInsets.only(left: 48, right: 48),
      child: Container(
        height: 96,
        child: AutoSizeText(
          _instructions,
          style: theme.backupPhraseInformationTextStyle,
          textAlign: TextAlign.center,
          minFontSize: MinFontSize(context).minFontSize,
          stepGranularity: 0.1,
        ),
      ),
    );
  }

  _buildCheckbox() {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              activeColor: theme.BreezColors.white[500],
              checkColor: theme.BreezColors.blue[500],
              value: _isUnderstood,
              onChanged: (value) {
                setState(() {
                  _isUnderstood = value;
                });
              }),
          Text(
            "I UNDERSTAND",
            style: theme.backupPhraseConfirmationTextStyle,
          )
        ],
      ),
    );
  }

  _buildNextBtn(bool isUnderstood) {
    return Padding(
      padding: EdgeInsets.only(top: 24, bottom: 40),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        isUnderstood
            ? SizedBox(
                height: 48.0,
                width: 168.0,
                child: RaisedButton(
                  onPressed: () {
                    String mnemonics = bip39.generateMnemonic(strength: 256);
                    Navigator.pushReplacement(context, FadeInRoute(builder: (BuildContext context) => GenerateBackupPhrasePage(mnemonics)));
                  },
                  child: Text(
                    "NEXT",
                    style: theme.buttonStyle,
                  ),
                  color: theme.BreezColors.white[500],
                  elevation: 0.0,
                  shape: const StadiumBorder(),
                ),
              )
            : Container()
      ]),
    );
  }
}
