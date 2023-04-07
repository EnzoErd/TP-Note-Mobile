import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:td2_2223/mytheme.dart';
import 'package:td2_2223/viewmodels/settingviewmodel.dart';

class EcranSettings extends StatelessWidget {
  const EcranSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingViewModel>(
      builder: (context, settingViewModel, child) {
        final theme = settingViewModel.isDark ? MyTheme.dark() : MyTheme.light();
        return Theme(
          data: theme,
          child: Center(
            child: SettingsList(
              darkTheme: SettingsThemeData(
                settingsListBackground: theme.scaffoldBackgroundColor,
                settingsSectionBackground: theme.scaffoldBackgroundColor,
              ),
              lightTheme: SettingsThemeData(
                settingsListBackground: theme.scaffoldBackgroundColor,
                settingsSectionBackground: theme.scaffoldBackgroundColor,
              ),
              sections: [
                SettingsSection(
                  title: Text('Theme', style: TextStyle(color: Colors.teal)),
                  tiles: [
                    SettingsTile.switchTile(
                      initialValue: settingViewModel.isDark,
                      onToggle: (bool value) {
                        settingViewModel.isDark = value;
                      },
                      title: const Text('Mode sombre'),
                      leading: const Icon(Icons.invert_colors),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
