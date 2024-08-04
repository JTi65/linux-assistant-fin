import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linux_assistant/layouts/mint_y.dart';
import 'package:linux_assistant/layouts/settings/appearance_settings.dart';
import 'package:linux_assistant/layouts/settings/environment_selection.dart';
import 'package:linux_assistant/layouts/settings/search_settings.dart';
import 'package:linux_assistant/services/main_search_loader.dart';

class SettingsStart extends StatefulWidget {
  const SettingsStart({super.key});

  @override
  State<SettingsStart> createState() => _SettingsStartState();
}

class _SettingsStartState extends State<SettingsStart> {
  String state = "start";

  @override
  Widget build(BuildContext context) {
    late Widget content;
    late String heading;
    switch (state) {
      case "start":
        content = startContent(context);
        heading = AppLocalizations.of(context)!.settings;
        break;
      case "search_settings":
        content = SearchSettings();
        heading = AppLocalizations.of(context)!.searchSettings;
        break;
      case "appearance_settings":
        content = AppearanceSettings();
        heading = AppLocalizations.of(context)!.appearance_settings;
        break;
      case "distribution_selection":
        content = const EnvironmentSelectionView();
        heading = AppLocalizations.of(context)!.distribution_selection;
        break;
    }
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                state != "start"
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            state = "start";
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 32,
                        ))
                    : Container(),
                SizedBox(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        heading,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                ),
                Container(),
              ],
            ),
            content,
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MintYButtonNavigate(
                  color: MintY.currentColor,
                  text: Text(
                    AppLocalizations.of(context)!.close,
                    style: MintY.heading4White,
                  ),
                  route: const MainSearchLoader(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget startContent(context) => MintYGrid(children: [
        MintYSelectableEntryWithIconHorizontal(
            title: AppLocalizations.of(context)!.distribution_selection,
            text: "",
            icon: Icon(
              Icons.screen_search_desktop_outlined,
              size: 64,
              color: MintY.currentColor,
            ),
            onPressed: () {
              setState(() {
                state = "distribution_selection";
              });
            }),
        MintYSelectableEntryWithIconHorizontal(
            title: AppLocalizations.of(context)!.searchSettings,
            text: "",
            icon: Icon(
              Icons.search,
              size: 64,
              color: MintY.currentColor,
            ),
            onPressed: () {
              setState(() {
                state = "search_settings";
              });
            }),
        MintYSelectableEntryWithIconHorizontal(
            title: AppLocalizations.of(context)!.appearance_settings,
            text: "",
            icon: Icon(
              Icons.brush,
              size: 64,
              color: MintY.currentColor,
            ),
            onPressed: () {
              setState(() {
                state = "appearance_settings";
              });
            }),
      ]);
}
