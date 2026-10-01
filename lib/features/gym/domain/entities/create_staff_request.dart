/// Solicitud para crear un miembro del staff.
class CreateStaffRequest {
  final String gymId;
  final String fullName;
  final String email;
  final String role; // 'trainer' o 'nutritionist'
  final String tempPassword;

  const CreateStaffRequest({
    required this.gymId,
    required this.fullName,
    required this.email,
    required this.role,
    required this.tempPassword,
  });
}
