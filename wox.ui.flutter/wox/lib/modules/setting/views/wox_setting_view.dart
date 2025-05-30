import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wox/controllers/wox_setting_controller.dart';
import 'package:wox/modules/setting/views/wox_setting_ui_view.dart';
import 'package:wox/modules/setting/views/wox_setting_ai_view.dart';
import 'package:wox/modules/setting/views/wox_setting_data_view.dart';
import 'package:wox/modules/setting/views/wox_setting_theme_view.dart';

import 'wox_setting_plugin_view.dart';
import 'wox_setting_general_view.dart';
import 'wox_setting_network_view.dart';

class WoxSettingView extends GetView<WoxSettingController> {
  const WoxSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Focus(
          autofocus: true,
          onKeyEvent: (FocusNode node, KeyEvent event) {
            if (event is KeyDownEvent) {
              switch (event.logicalKey) {
                case LogicalKeyboardKey.escape:
                  controller.hideWindow();
                  return KeyEventResult.handled;
              }
            }
            return KeyEventResult.ignored;
          },
          child: Scaffold(
            body: FluentApp(
              debugShowCheckedModeBanner: false,
              home: NavigationView(
                transitionBuilder: (child, animation) {
                  return SuppressPageTransition(child: child);
                },
                pane: NavigationPane(
                  header: const SizedBox(height: 10),
                  selected: controller.activePaneIndex.value,
                  onChanged: (index) => controller.activePaneIndex.value = index,
                  displayMode: PaneDisplayMode.open,
                  size: const NavigationPaneSize(openWidth: 200),
                  items: [
                    PaneItem(
                      icon: const Icon(FluentIcons.settings),
                      title: Text(controller.tr('ui_general')),
                      body: const WoxSettingGeneralView(),
                    ),
                    PaneItem(
                      icon: const Icon(FluentIcons.color),
                      title: Text(controller.tr('ui_ui')),
                      body: const WoxSettingUIView(),
                    ),
                    PaneItem(
                      icon: const Icon(Icons.grain),
                      title: Text(controller.tr('ui_ai')),
                      body: const WoxSettingAIView(),
                    ),
                    PaneItem(
                      icon: const Icon(FluentIcons.globe),
                      title: Text(controller.tr('ui_network')),
                      body: const WoxSettingNetworkView(),
                    ),
                    PaneItem(
                      icon: const Icon(FluentIcons.database),
                      title: Text(controller.tr('ui_data')),
                      body: const WoxSettingDataView(),
                    ),
                    PaneItemExpander(
                        icon: const Icon(FluentIcons.app_icon_default_add),
                        title: Text(controller.tr('ui_plugins')),
                        body: const WoxSettingPluginView(),
                        initiallyExpanded: true,
                        items: [
                          PaneItem(
                            icon: const Icon(FluentIcons.office_store_logo),
                            title: Text(controller.tr('ui_store_plugins')),
                            body: const WoxSettingPluginView(),
                            onTap: () async {
                              await controller.switchToPluginList(true);
                            },
                          ),
                          PaneItem(
                            icon: const Icon(FluentIcons.installation),
                            title: Text(controller.tr('ui_installed_plugins')),
                            body: const WoxSettingPluginView(),
                            onTap: () async {
                              await controller.switchToPluginList(false);
                            },
                          ),
                        ]),
                    PaneItemExpander(
                      icon: const Icon(FluentIcons.color),
                      title: Text(controller.tr('ui_themes')),
                      body: const WoxSettingThemeView(),
                      initiallyExpanded: true,
                      items: [
                        PaneItem(
                          icon: const Icon(FluentIcons.mail),
                          title: Text(controller.tr('ui_store_themes')),
                          body: const WoxSettingThemeView(),
                          onTap: () async {
                            await controller.switchToThemeList(true);
                          },
                        ),
                        PaneItem(
                          icon: const Icon(FluentIcons.installation),
                          title: Text(controller.tr('ui_installed_themes')),
                          body: const WoxSettingThemeView(),
                          onTap: () async {
                            await controller.switchToThemeList(false);
                          },
                        ),
                      ],
                    ),
                  ],
                  footerItems: [
                    PaneItem(
                      icon: const Icon(FluentIcons.back),
                      title: Text(controller.tr('ui_back')),
                      body: Text(controller.tr('ui_back')),
                      onTap: () => controller.hideWindow(),
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
