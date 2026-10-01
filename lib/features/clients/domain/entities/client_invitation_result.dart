/// Resultado de agregar un cliente manualmente.
class ClientInvitationResult {
  final String userId;
  final String membershipId;
  final String email;
  final String tempPassword;

  const ClientInvitationResult({
    required this.userId,
    required this.membershipId,
    required this.email,
    required this.tempPassword,
  });
}
