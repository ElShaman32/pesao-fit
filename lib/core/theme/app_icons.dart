import 'package:flutter/material.dart';

/// Íconos del design system (design-system.md §6).
/// Material Icons, variante rounded cuando existe.
/// Pares filled/outlined para tabs (activo=filled, inactivo=outlined).
abstract final class AppIcons {
  // --- Navegación (tabs por rol) ---
  static const IconData home = Icons.home_rounded;
  static const IconData homeOutline = Icons.home_outlined;
  static const IconData routine = Icons.fitness_center_rounded;
  static const IconData nutrition = Icons.restaurant_rounded;
  static const IconData nutritionOutline = Icons.restaurant_outlined;
  static const IconData profile = Icons.person_rounded;
  static const IconData profileOutline = Icons.person_outline_rounded;
  static const IconData clients = Icons.groups_rounded;
  static const IconData clientsOutline = Icons.groups_outlined;
  static const IconData payments = Icons.receipt_long_rounded;
  static const IconData paymentsOutline = Icons.receipt_long_outlined;
  static const IconData gyms = Icons.apartment_rounded;
  static const IconData gymsOutline = Icons.apartment_outlined;
  static const IconData plans = Icons.menu_book_rounded;
  static const IconData plansOutline = Icons.menu_book_outlined;

  // --- Acciones ---
  static const IconData add = Icons.add_rounded;
  static const IconData back = Icons.arrow_back_rounded;
  static const IconData arrowForward = Icons.arrow_forward_rounded;
  static const IconData close = Icons.close_rounded;
  static const IconData more = Icons.more_vert_rounded;
  static const IconData edit = Icons.edit_rounded;
  static const IconData delete = Icons.delete_outline_rounded;
  static const IconData search = Icons.search_rounded;
  static const IconData chevronRight = Icons.chevron_right_rounded;
  static const IconData chevronLeft = Icons.chevron_left_rounded;

  // --- Estados / feedback ---
  static const IconData success = Icons.check_circle_rounded;
  static const IconData warning = Icons.warning_amber_rounded;
  static const IconData error = Icons.error_outline_rounded;
  static const IconData info = Icons.info_rounded;
  static const IconData sync = Icons.sync_rounded;
  static const IconData offline = Icons.wifi_off_rounded;
  static const IconData notifications = Icons.notifications_rounded;
  static const IconData notificationsOutline = Icons.notifications_none_rounded;

  // --- Fitness ---
  static const IconData timer = Icons.timer_rounded;
  static const IconData play = Icons.play_arrow_rounded;
  static const IconData pause = Icons.pause_rounded;
  static const IconData streak = Icons.local_fire_department_rounded;
  static const IconData kcal = Icons.bolt_rounded;
  static const IconData weight = Icons.monitor_weight_rounded;
  static const IconData calendar = Icons.calendar_today_rounded;
  static const IconData chart = Icons.insights_rounded;
  static const IconData water = Icons.water_drop_outlined;

  // --- Macros ---
  static const IconData protein = Icons.egg_rounded;
  static const IconData carbs = Icons.set_meal_rounded;
  static const IconData fats = Icons.water_drop_rounded;

  // --- Auth / seguridad ---
  static const IconData mail = Icons.mail_rounded;
  static const IconData lock = Icons.lock_rounded;
  static const IconData eye = Icons.visibility_rounded;
  static const IconData eyeOff = Icons.visibility_off_rounded;
  static const IconData biometric = Icons.fingerprint_rounded;
  static const IconData logout = Icons.logout_rounded;

  // --- Multimedia / pagos ---
  static const IconData camera = Icons.photo_camera_rounded;
  static const IconData image = Icons.image_rounded;
  static const IconData upload = Icons.file_upload_rounded;
  static const IconData download = Icons.file_download_rounded;
  static const IconData clipboard = Icons.content_copy_rounded;
  static const IconData money = Icons.payments_rounded;
  static const IconData qr = Icons.qr_code_rounded;

  // --- Otros ---
  static const IconData settings = Icons.settings_rounded;
  static const IconData star = Icons.star_rounded;
  static const IconData heart = Icons.favorite_rounded;
  static const IconData verified = Icons.verified_rounded;
}
