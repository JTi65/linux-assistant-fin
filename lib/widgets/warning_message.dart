import 'package:flutter/material.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WarningMessage extends StatelessWidget {
  late String text;
  late VoidCallback? fixAction;
  WarningMessage({Key? key, this.text = "", this.fixAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.warning,
                size: 32,
                color: Colors.orange,
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          fixAction != null
              ? const SizedBox(
                  height: 8,
                )
              : Container(),
          fixAction != null
              ? MintYButton(
                  text: Text(
                    AppLocalizations.of(context)!.fix,
                    style: MintY.heading4White,
                  ),
                  color: MintY.currentColor,
                  onPressed: () {
                    fixAction?.call();
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
