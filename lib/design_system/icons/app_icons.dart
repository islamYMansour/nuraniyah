import 'package:flutter/material.dart';

/// Noor's icon set, organised by purpose.
///
/// Every icon resolves to Flutter's bundled Material Icons font — already
/// available through `uses-material-design: true` in `pubspec.yaml` — so this
/// adds **no dependency and no asset weight**. The rounded variants are used
/// throughout: their soft terminals match Noor's generous corner radii, where
/// the default sharp set would read as a utility app.
///
/// Components must name icons from here rather than reaching for `Icons.*`
/// directly, so the set can be swapped for custom artwork later by editing
/// this file alone.
///
/// ## Direction
///
/// Material's arrows and chevrons are **not** direction-aware in Flutter —
/// `Icons.arrow_back` points left even in Arabic, where "back" is to the
/// right. Every directional icon here is rebuilt through [_mirrored] so it
/// flips automatically with the ambient [Directionality]. Use these, never
/// the raw `Icons` equivalents.
abstract final class AppIcons {
  /// Rebuilds an icon so [Icon] mirrors it under RTL.
  static IconData _mirrored(IconData icon) => IconData(
    icon.codePoint,
    fontFamily: icon.fontFamily,
    fontPackage: icon.fontPackage,
    matchTextDirection: true,
  );

  // ── Navigation ────────────────────────────────────────────────

  static const IconData home = Icons.home_rounded;
  static const IconData homeOutlined = Icons.home_outlined;
  static const IconData menu = Icons.menu_rounded;
  static const IconData more = Icons.more_horiz_rounded;
  static const IconData moreVertical = Icons.more_vert_rounded;
  static const IconData expand = Icons.keyboard_arrow_down_rounded;
  static const IconData collapse = Icons.keyboard_arrow_up_rounded;

  /// Flips under RTL.
  static final IconData back = _mirrored(Icons.arrow_back_rounded);

  /// Flips under RTL.
  static final IconData forward = _mirrored(Icons.arrow_forward_rounded);

  /// Flips under RTL. The affordance on a tappable list row.
  static final IconData chevronForward = _mirrored(Icons.chevron_right_rounded);

  /// Flips under RTL.
  static final IconData chevronBack = _mirrored(Icons.chevron_left_rounded);

  // ── Arrows ────────────────────────────────────────────────────

  static const IconData arrowUp = Icons.arrow_upward_rounded;
  static const IconData arrowDown = Icons.arrow_downward_rounded;
  static final IconData arrowStart = _mirrored(Icons.arrow_back_rounded);
  static final IconData arrowEnd = _mirrored(Icons.arrow_forward_rounded);

  // ── Close / dismiss ───────────────────────────────────────────

  static const IconData close = Icons.close_rounded;
  static const IconData closeCircle = Icons.cancel_rounded;
  static const IconData clear = Icons.backspace_rounded;

  // ── Actions ───────────────────────────────────────────────────

  static const IconData add = Icons.add_rounded;
  static const IconData addCircle = Icons.add_circle_rounded;
  static const IconData edit = Icons.edit_rounded;
  static const IconData delete = Icons.delete_rounded;
  static const IconData save = Icons.save_rounded;
  static const IconData copy = Icons.copy_rounded;
  static const IconData share = Icons.ios_share_rounded;
  static const IconData refresh = Icons.refresh_rounded;
  static const IconData download = Icons.download_rounded;
  static const IconData upload = Icons.upload_rounded;
  static const IconData retry = Icons.replay_rounded;

  // ── Search and filter ─────────────────────────────────────────

  static const IconData search = Icons.search_rounded;
  static const IconData filter = Icons.tune_rounded;
  static const IconData sort = Icons.sort_rounded;

  // ── Status ────────────────────────────────────────────────────

  static const IconData success = Icons.check_circle_rounded;
  static const IconData check = Icons.check_rounded;
  static const IconData error = Icons.error_rounded;
  static const IconData warning = Icons.warning_rounded;
  static const IconData info = Icons.info_rounded;
  static const IconData help = Icons.help_rounded;
  static const IconData locked = Icons.lock_rounded;
  static const IconData unlocked = Icons.lock_open_rounded;

  // ── Communication ─────────────────────────────────────────────

  static const IconData mail = Icons.mail_rounded;
  static const IconData phone = Icons.phone_rounded;
  static const IconData chat = Icons.chat_bubble_rounded;
  static const IconData notification = Icons.notifications_rounded;
  static final IconData send = _mirrored(Icons.send_rounded);

  // ── Media ─────────────────────────────────────────────────────
  // Noor teaches pronunciation, so audio playback and recording carry more
  // weight here than in a typical app.

  static const IconData play = Icons.play_arrow_rounded;
  static const IconData pause = Icons.pause_rounded;
  static const IconData stop = Icons.stop_rounded;
  static const IconData replay = Icons.replay_rounded;
  static const IconData volumeOn = Icons.volume_up_rounded;
  static const IconData volumeOff = Icons.volume_off_rounded;
  static const IconData microphone = Icons.mic_rounded;
  static const IconData microphoneOff = Icons.mic_off_rounded;
  static const IconData image = Icons.image_rounded;
  static const IconData camera = Icons.photo_camera_rounded;

  // ── Education ─────────────────────────────────────────────────
  // Noor's own domain: lessons, progress and reward.

  static const IconData book = Icons.menu_book_rounded;
  static const IconData lesson = Icons.auto_stories_rounded;
  static const IconData school = Icons.school_rounded;
  static const IconData star = Icons.star_rounded;
  static const IconData starOutlined = Icons.star_border_rounded;
  static const IconData trophy = Icons.emoji_events_rounded;
  static const IconData progress = Icons.insights_rounded;
  static const IconData streak = Icons.local_fire_department_rounded;
  static const IconData badge = Icons.workspace_premium_rounded;
  static const IconData practice = Icons.extension_rounded;

  // ── Files ─────────────────────────────────────────────────────

  static const IconData file = Icons.insert_drive_file_rounded;
  static const IconData folder = Icons.folder_rounded;
  static const IconData attachment = Icons.attach_file_rounded;

  // ── Calendar and time ─────────────────────────────────────────

  static const IconData calendar = Icons.calendar_today_rounded;
  static const IconData schedule = Icons.event_rounded;
  static const IconData time = Icons.access_time_rounded;
  static const IconData history = Icons.history_rounded;

  // ── User ──────────────────────────────────────────────────────

  static const IconData user = Icons.person_rounded;
  static const IconData userOutlined = Icons.person_outline_rounded;
  static const IconData users = Icons.group_rounded;
  static const IconData addUser = Icons.person_add_rounded;
  static const IconData signIn = Icons.login_rounded;
  static const IconData signOut = Icons.logout_rounded;

  // ── Settings ──────────────────────────────────────────────────

  static const IconData settings = Icons.settings_rounded;
  static const IconData language = Icons.language_rounded;
  static const IconData theme = Icons.brightness_6_rounded;
  static const IconData visible = Icons.visibility_rounded;
  static const IconData hidden = Icons.visibility_off_rounded;

  // ── Empty states ──────────────────────────────────────────────

  static const IconData empty = Icons.inbox_rounded;
  static const IconData noResults = Icons.search_off_rounded;
  static const IconData offline = Icons.cloud_off_rounded;
}
