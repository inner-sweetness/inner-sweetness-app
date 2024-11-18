import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hugeicons/hugeicons.dart';
import 'package:medito/constants/constants.dart';
import 'package:medito/providers/notification/reminder_provider.dart';
import 'package:medito/providers/providers.dart';
import 'package:medito/providers/stats_provider.dart';
import 'package:medito/providers/device_and_app_info/device_and_app_info_provider.dart';
import 'package:medito/repositories/auth/auth_repository.dart';
import 'package:medito/routes/routes.dart';
import 'package:medito/utils/permission_handler.dart';
import 'package:medito/utils/utils.dart';
import 'package:medito/views/home/widgets/bottom_sheet/debug/debug_bottom_sheet_widget.dart';
import 'package:medito/views/home/widgets/bottom_sheet/row_item_widget.dart';
import 'package:medito/views/settings/health_sync_tile.dart';
import 'package:medito/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/widgets/header/home_header_widget.dart';

final reminderTimeProvider = StateProvider<TimeOfDay?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);

  return _getReminderTimeFromPrefs(prefs);
});

TimeOfDay? _getReminderTimeFromPrefs(SharedPreferences prefs) {
  final savedHour = prefs.getInt(SharedPreferenceConstants.savedHours);
  final savedMinute = prefs.getInt(SharedPreferenceConstants.savedMinutes);

  return (savedHour != null && savedMinute != null)
      ? TimeOfDay(hour: savedHour, minute: savedMinute)
      : null;
}

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static final _isHealthSyncAvailable = Platform.isIOS;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final userId = authRepository.currentUser?.id ?? '';
    final deviceInfoAsyncValue = ref.watch(deviceAndAppInfoProvider);
    final statsAsyncValue = ref.watch(statsProvider);

    final List<SettingsItem> settingsItems = [
      SettingsItem(
        type: 'url',
        title: StringConstants.contactUsTitle,
        icon: const Icon(Icons.contact_support_outlined),
        // icon: HugeIcon(
        //     icon: HugeIcons.solidRoundedMessage01, color: ColorConstants.white),
        path: deviceInfoAsyncValue.when(
          data: (deviceInfo) {
            final platform = Uri.encodeComponent(deviceInfo.platform);
            final language = Uri.encodeComponent(deviceInfo.languageCode);
            final model = Uri.encodeComponent(deviceInfo.model);
            final appVersion = Uri.encodeComponent(deviceInfo.appVersion);
            final os = Uri.encodeComponent(deviceInfo.os);

            return 'https://tally.so/r/wLGBaO?userId=$userId&platform=$platform&language=$language&model=$model&appVersion=$appVersion&os=$os';
          },
          loading: () => 'https://tally.so/r/wLGBaO?userId=$userId',
          error: (_, __) => 'https://tally.so/r/wLGBaO?userId=$userId',
        ),
      ),
      SettingsItem(
        type: 'url',
        title: StringConstants.followUsTitle,
        icon: const Icon(Icons.open_in_new),
        path: 'https://medito.notion.site/FAQ-3edb3f0a4b984c069b9c401308d874bc?pvs=4',
      ),
      SettingsItem(
        type: 'url',
        title: StringConstants.shareTitle,
        icon: const Icon(Icons.share),
        path: 'https://medito.notion.site/FAQ-3edb3f0a4b984c069b9c401308d874bc?pvs=4',
      ),
      SettingsItem(
        type: 'url',
        title: StringConstants.logoutTitle,
        icon: const Icon(Icons.logout),
        path: 'https://medito.notion.site/FAQ-3edb3f0a4b984c069b9c401308d874bc?pvs=4',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: ColorConstants.ebony,
        toolbarHeight: 56.0,
        title: const Column(
          children: [
            HomeHeaderWidget(greeting: StringConstants.settings),
          ],
        ),
        elevation: 0.0,
      ),
      body: SafeArea(child: _buildMain(context, ref, settingsItems)),
    );
  }

  Widget _buildMain(
      BuildContext context, WidgetRef ref, List<SettingsItem> settingsItems) {
    return _buildSettingsList(context, ref, settingsItems);
  }

  Widget _buildSettingsList(
    BuildContext context,
    WidgetRef ref,
    List<SettingsItem> settingsItems,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: padding16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Hi User!',
                    style: TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Silver Plan',
                    style: TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0,
                      color: Colors.white.withOpacity(.4),
                    ),
                  ),
                ],
              ),
            ),
            if (_isHealthSyncAvailable) const HealthSyncTile(),
            ...settingsItems.map((item) => _buildMenuItemTile(context, ref, item)),
            _buildDebugTile(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItemTile(
    BuildContext context,
    WidgetRef ref,
    SettingsItem item,
  ) {
    return RowItemWidget(
      enableInteractiveSelection: false,
      icon: item.icon,
      title: item.title,
      hasUnderline: true,
      onTap: () => handleItemPress(context, ref, item),
    );
  }

  Widget _buildDebugTile(BuildContext context, WidgetRef ref) {
    return RowItemWidget(
      enableInteractiveSelection: false,
      icon: const Icon(Icons.play_arrow),
      title: StringConstants.debugInfo,
      hasUnderline: true,
      onTap: () => _showDebugBottomSheet(context, ref),
    );
  }

  void handleItemPress(
    BuildContext context,
    WidgetRef ref,
    SettingsItem item,
  ) async {
    await handleNavigation(
      item.type,
      [item.path.toString().getIdFromPath(), item.path],
      context,
      ref: ref,
    );
  }

  Future<void> _clearSavedTime(SharedPreferences prefs) async {
    await prefs.remove(SharedPreferenceConstants.savedHours);
    await prefs.remove(SharedPreferenceConstants.savedMinutes);
  }

  void _showClearReminderSnackBar(BuildContext context) {
    showSnackBar(context, StringConstants.reminderNotificationCleared);
  }

  Future<void> _selectTime(BuildContext context, WidgetRef ref) async {
    var accepted = await PermissionHandler.requestAlarmPermission(context);

    if (!accepted) return;

    final reminders = ref.read(reminderProvider);
    final prefs = ref.read(sharedPreferencesProvider);

    final initialTime = ref.read(reminderTimeProvider) ?? TimeOfDay.now();

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      helpText: StringConstants.pickTimeHelpText,
    );

    if (pickedTime != null) {
      await reminders.scheduleDailyNotification(pickedTime);
      await _savePickedTime(prefs, pickedTime);
      ref.read(reminderTimeProvider.notifier).state = pickedTime;
      _showSnackBar(context, pickedTime);
    }
  }

  Future<void> _savePickedTime(
    SharedPreferences prefs,
    TimeOfDay pickedTime,
  ) async {
    await prefs.setInt(SharedPreferenceConstants.savedHours, pickedTime.hour);
    await prefs.setInt(
      SharedPreferenceConstants.savedMinutes,
      pickedTime.minute,
    );
  }

  void _showSnackBar(BuildContext context, TimeOfDay pickedTime) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${StringConstants.reminderNotificationScheduled} ${pickedTime.format(context)}',
        ),
      ),
    );
  }

  void _showDebugBottomSheet(BuildContext context, WidgetRef ref) {
    ref.invalidate(meProvider);
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (context) => const DebugBottomSheetWidget(),
    );
  }
}

class SettingsItem {
  final String type;
  final String title;
  final Widget icon;
  final String path;

  const SettingsItem({
    required this.type,
    required this.title,
    required this.icon,
    required this.path,
  });
}
