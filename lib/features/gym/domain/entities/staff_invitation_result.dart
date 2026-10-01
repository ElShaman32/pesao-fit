/// Resultado de invitar a un miembro del staff.
/// Incluye las credenciales temporales que el dueño debe compartir.
class StaffInvitationResult {
  final String userId;
  final String membershipId;
  final String email;
  final String tempPassword;

  const StaffInvitationResult({
    required this.userId,
    required this.membershipId,
    required this.email,
    required this.tempPassword,
  });
}
