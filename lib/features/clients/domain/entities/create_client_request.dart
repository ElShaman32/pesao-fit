/// Solicitud para agregar un cliente manualmente.
class CreateClientRequest {
  final String gymId;
  final String fullName;
  final String email;
  final String tempPassword;

  const CreateClientRequest({
    required this.gymId,
    required this.fullName,
    required this.email,
    required this.tempPassword,
  });
}
