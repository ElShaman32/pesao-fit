import 'package:flutter/material.dart';

/// Configuración del FAB contextual por shell.
/// Cada pantalla secundaria puede cambiar el FAB al entrar y restaurarlo al salir.
class FabConfig {
  final IconData icon;
  final String semanticLabel;
  final VoidCallback? onPressed;

  const FabConfig({
    required this.icon,
    required this.semanticLabel,
    this.onPressed,
  });
}

/// Controlador del FAB del owner.
/// Las pantallas secundarias lo llaman para cambiar la acción del FAB.
class OwnerFabController extends ChangeNotifier {
  FabConfig _current;
  final FabConfig _default;

  OwnerFabController({required FabConfig defaultConfig})
    : _default = defaultConfig,
      _current = defaultConfig;

  FabConfig get current => _current;

  /// Cambia el FAB a una configuración temporal.
  void setFab(FabConfig config) {
    _current = config;
    notifyListeners();
  }

  /// Restaura el FAB a la configuración por defecto del rol.
  void restore() {
    _current = _default;
    notifyListeners();
  }
}
