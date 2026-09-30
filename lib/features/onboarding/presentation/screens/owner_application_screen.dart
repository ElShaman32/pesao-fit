import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_strings.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/input_formatters.dart';
import '../../../../shared/widgets/pesao_button.dart';
import '../../../../shared/widgets/pesao_input.dart';
import '../providers/owner_application_controller.dart';

/// Lista de estados de Venezuela para el dropdown.
const _venezuelanStates = [
  'Distrito Capital',
  'Anzoátegui',
  'Apure',
  'Aragua',
  'Barinas',
  'Bolívar',
  'Carabobo',
  'Cojedes',
  'Delta Amacuro',
  'Falcón',
  'Guárico',
  'La Guaira',
  'Lara',
  'Mérida',
  'Miranda',
  'Monagas',
  'Nueva Esparta',
  'Portuguesa',
  'Sucre',
  'Táchira',
  'Trujillo',
  'Yaracuy',
  'Zulia',
];

/// Pantalla de solicitud KYC para dueños de gimnasio (ADR-036).
///
/// Recoge datos personales y del gimnasio, y envía la solicitud a
/// gym_applications para revisión manual del superadmin.
class OwnerApplicationScreen extends ConsumerStatefulWidget {
  const OwnerApplicationScreen({super.key});

  @override
  ConsumerState<OwnerApplicationScreen> createState() =>
      _OwnerApplicationScreenState();
}

class _OwnerApplicationScreenState
    extends ConsumerState<OwnerApplicationScreen> {
  final _ownerPhoneController = TextEditingController();
  final _ownerDocumentController = TextEditingController();
  final _gymNameController = TextEditingController();
  final _gymRifController = TextEditingController();
  final _gymAddressController = TextEditingController();
  final _gymCityController = TextEditingController();
  final _gymPhoneController = TextEditingController();
  final _gymInstagramController = TextEditingController();
  final _gymDescriptionController = TextEditingController();
  String _documentType = 'V';

  @override
  void dispose() {
    _ownerPhoneController.dispose();
    _ownerDocumentController.dispose();
    _gymNameController.dispose();
    _gymRifController.dispose();
    _gymAddressController.dispose();
    _gymCityController.dispose();
    _gymPhoneController.dispose();
    _gymInstagramController.dispose();
    _gymDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppStrings.of(context);
    final state = ref.watch(ownerApplicationControllerProvider);
    final controller = ref.read(ownerApplicationControllerProvider.notifier);

    // Al enviar con éxito, navegar a la pantalla de espera.
    ref.listen(ownerApplicationControllerProvider, (previous, next) {
      final justSubmitted =
          next.isSubmitted && !(previous?.isSubmitted ?? false);
      if (justSubmitted) {
        context.go(RouteNames.applicationPending);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text(
          l10n.ownerAppTitle,
          style: AppTypography.title.copyWith(color: AppColors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Subtítulo
            Text(
              l10n.ownerAppSubtitle,
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimens.xl),

            // === SECCIÓN: Datos personales ===
            _SectionTitle(text: l10n.ownerAppPersonalSection),
            const SizedBox(height: AppDimens.m),

            PesaoInput(
              controller: _ownerPhoneController,
              label: l10n.ownerAppPhoneLabel,
              hint: l10n.ownerAppPhoneHint,
              prefixIcon: const Icon(Icons.phone_outlined),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              onChanged: controller.setOwnerPhone,
              enabled: !state.isSubmitting,
              inputFormatters: [VenezuelanPhoneFormatter()], // ← AGREGAR
            ),
            const SizedBox(height: AppDimens.m),

            // Dropdown de tipo de documento + input
            Row(
              children: [
                // Dropdown V/J/E
                Container(
                  width: 80,
                  height: AppDimens.inputHeight,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceHigh,
                    borderRadius: AppDimens.inputBorderRadius,
                    border: Border.all(color: AppColors.outline),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _documentType,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down, size: 20),
                      focusColor: AppColors.textSecondary,
                      dropdownColor: AppColors.surfaceHigh,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      onChanged: state.isSubmitting
                          ? null
                          : (value) {
                              setState(() {
                                _documentType = value!;
                                _ownerDocumentController.clear();
                                controller.setOwnerDocument('');
                              });
                            },
                      items: const [
                        DropdownMenuItem(value: 'V', child: Text('V')),
                        DropdownMenuItem(value: 'J', child: Text('J')),
                        DropdownMenuItem(value: 'E', child: Text('E')),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppDimens.s),

                // Input de documento
                Expanded(
                  child: PesaoInput(
                    controller: _ownerDocumentController,
                    label: l10n.ownerAppDocumentLabel,
                    hint: _documentType == 'J' ? '12345678-9' : '1.234.567',
                    prefixIcon: const Icon(Icons.badge),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged: controller.setOwnerDocument,
                    enabled: !state.isSubmitting,
                    inputFormatters: [
                      VenezuelanDocumentFormatter(_documentType),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.xl),

            // === SECCIÓN: Datos del gimnasio ===
            _SectionTitle(text: l10n.ownerAppGymSection),
            const SizedBox(height: AppDimens.m),

            PesaoInput(
              controller: _gymNameController,
              label: l10n.ownerAppGymNameLabel,
              hint: l10n.ownerAppGymNameHint,
              prefixIcon: const Icon(Icons.fitness_center_outlined),
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              onChanged: controller.setGymName,
              enabled: !state.isSubmitting,
            ),
            const SizedBox(height: AppDimens.m),

            PesaoInput(
              controller: _gymRifController,
              label: l10n.ownerAppGymRifLabel,
              hint: l10n.ownerAppGymRifHint,
              prefixIcon: const Icon(Icons.receipt_long_outlined),
              textInputAction: TextInputAction.next,
              onChanged: controller.setGymRif,
              enabled: !state.isSubmitting,
            ),
            const SizedBox(height: AppDimens.m),

            PesaoInput(
              controller: _gymAddressController,
              label: l10n.ownerAppGymAddressLabel,
              hint: l10n.ownerAppGymAddressHint,
              prefixIcon: const Icon(Icons.location_on_outlined),
              textInputAction: TextInputAction.next,
              onChanged: controller.setGymAddress,
              enabled: !state.isSubmitting,
            ),
            const SizedBox(height: AppDimens.m),

            // Dropdown de estado
            _StateDropdown(
              label: l10n.ownerAppGymStateLabel,
              value: state.gymState.isEmpty ? null : state.gymState,
              onChanged: state.isSubmitting ? null : controller.setGymState,
            ),
            const SizedBox(height: AppDimens.m),

            PesaoInput(
              controller: _gymCityController,
              label: l10n.ownerAppGymCityLabel,
              hint: l10n.ownerAppGymCityHint,
              prefixIcon: const Icon(Icons.location_city_outlined),
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              onChanged: controller.setGymCity,
              enabled: !state.isSubmitting,
            ),
            const SizedBox(height: AppDimens.m),

            PesaoInput(
              controller: _gymPhoneController,
              label: l10n.ownerAppGymPhoneLabel,
              hint: l10n.ownerAppGymPhoneHint,
              prefixIcon: const Icon(Icons.phone_outlined),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              onChanged: controller.setGymPhone,
              enabled: !state.isSubmitting,
              inputFormatters: [VenezuelanLandlineFormatter()],
            ),
            const SizedBox(height: AppDimens.m),

            PesaoInput(
              controller: _gymInstagramController,
              label: l10n.ownerAppGymInstagramLabel,
              hint: l10n.ownerAppGymInstagramHint,
              prefixIcon: const Icon(Icons.alternate_email_outlined),
              textInputAction: TextInputAction.next,
              onChanged: controller.setGymInstagram,
              enabled: !state.isSubmitting,
            ),
            const SizedBox(height: AppDimens.m),

            PesaoInput(
              controller: _gymDescriptionController,
              label: l10n.ownerAppGymDescriptionLabel,
              hint: l10n.ownerAppGymDescriptionHint,
              prefixIcon: const Icon(Icons.notes_outlined),
              onChanged: controller.setGymDescription,
              enabled: !state.isSubmitting,
            ),
            const SizedBox(height: AppDimens.xl),

            // === Foto y GPS (opcionales, placeholders) ===
            _OptionalActionTile(
              icon: Icons.photo_camera_outlined,
              label: l10n.ownerAppGymPhotoLabel,
              buttonLabel: l10n.ownerAppGymPhotoButton,
              onTap: () {
                // TODO: integración con Cloudinary en próxima iteración.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Foto del local: disponible muy pronto'),
                  ),
                );
              },
            ),
            const SizedBox(height: AppDimens.m),

            _OptionalActionTile(
              icon: Icons.my_location_outlined,
              label: 'Ubicación GPS (opcional)',
              buttonLabel: l10n.ownerAppGymLocationButton,
              onTap: () {
                // TODO: integración con geolocator en próxima iteración.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ubicación GPS: disponible muy pronto'),
                  ),
                );
              },
            ),
            const SizedBox(height: AppDimens.xl),

            // === Error box ===
            if (state.error != null) ...[
              _ErrorBox(message: state.error!),
              const SizedBox(height: AppDimens.m),
            ],

            // === Botón de envío ===
            PesaoButton(
              label: l10n.ownerAppSubmit,
              onPressed: state.isValid ? controller.submit : null,
              loading: state.isSubmitting,
            ),
            const SizedBox(height: AppDimens.xxl),
          ],
        ),
      ),
    );
  }
}

/// Título de sección con tipografía label y color primario.
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppTypography.label.copyWith(
        color: AppColors.primaryText,
        letterSpacing: 1.5,
      ),
    );
  }
}

/// Dropdown de estados con estilo consistente al kit Pesao*.
class _StateDropdown extends StatelessWidget {
  const _StateDropdown({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String? value;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.label.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppDimens.xs),
        Container(
          height: AppDimens.inputHeight,
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
          decoration: BoxDecoration(
            color: AppColors.surfaceHigh,
            borderRadius: AppDimens.inputBorderRadius,
            border: Border.all(color: AppColors.outline),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              focusColor: AppColors.textSecondary,
              dropdownColor: AppColors.surfaceHigh,
              hint: Text(
                'Selecciona un estado',
                style: AppTypography.body.copyWith(
                  color: AppColors.textDisabled,
                ),
              ),
              style: AppTypography.body.copyWith(color: AppColors.textPrimary),
              onChanged: onChanged,
              items: _venezuelanStates.map((state) {
                return DropdownMenuItem<String>(
                  value: state,
                  child: Text(state),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

/// Tile para acciones opcionales (foto, GPS) aún no implementadas.
class _OptionalActionTile extends StatelessWidget {
  const _OptionalActionTile({
    required this.icon,
    required this.label,
    required this.buttonLabel,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String buttonLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.l),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimens.cardBorderRadius,
        border: Border.all(color: AppColors.outline),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: AppDimens.m),
          Expanded(
            child: Text(
              label,
              style: AppTypography.body.copyWith(color: AppColors.textPrimary),
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: Text(
              buttonLabel,
              style: AppTypography.label.copyWith(color: AppColors.primaryText),
            ),
          ),
        ],
      ),
    );
  }
}

/// Caja de error con ícono.
class _ErrorBox extends StatelessWidget {
  const _ErrorBox({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.m),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, color: AppColors.error, size: 20),
          const SizedBox(width: AppDimens.s),
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.errorText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
