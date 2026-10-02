import 'package:equatable/equatable.dart';

/// Grupo muscular de un ejercicio.
enum MuscleGroup {
  chest,
  back,
  shoulders,
  biceps,
  triceps,
  legs,
  glutes,
  core,
  cardio,
  fullBody;

  /// Valor que se guarda en la base de datos.
  String get dbValue => switch (this) {
    MuscleGroup.chest => 'pecho',
    MuscleGroup.back => 'espalda',
    MuscleGroup.shoulders => 'hombros',
    MuscleGroup.biceps => 'biceps',
    MuscleGroup.triceps => 'triceps',
    MuscleGroup.legs => 'piernas',
    MuscleGroup.glutes => 'gluteos',
    MuscleGroup.core => 'core',
    MuscleGroup.cardio => 'cardio',
    MuscleGroup.fullBody => 'full_body',
  };

  static MuscleGroup fromDb(String? value) {
    return MuscleGroup.values.firstWhere(
      (g) => g.dbValue == value,
      orElse: () => MuscleGroup.fullBody,
    );
  }
}

/// Ejercicio de la biblioteca global o personalizado por el gym.
/// POCO + Equatable (ADR-037).
class Exercise extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String? videoUrl;
  final String? imageUrl;
  final MuscleGroup muscleGroup;
  final bool isGlobal;
  final String? sourceGymId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Exercise({
    required this.id,
    required this.name,
    this.description,
    this.videoUrl,
    this.imageUrl,
    this.muscleGroup = MuscleGroup.fullBody,
    this.isGlobal = false,
    this.sourceGymId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      videoUrl: json['video_url'] as String?,
      imageUrl: json['image_url'] as String?,
      muscleGroup: MuscleGroup.fromDb(json['muscle_group'] as String?),
      isGlobal: json['is_global'] as bool? ?? false,
      sourceGymId: json['source_gym_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Exercise copyWith({
    String? name,
    String? description,
    String? videoUrl,
    String? imageUrl,
    MuscleGroup? muscleGroup,
  }) {
    return Exercise(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      isGlobal: isGlobal,
      sourceGymId: sourceGymId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    videoUrl,
    imageUrl,
    muscleGroup,
    isGlobal,
    sourceGymId,
    createdAt,
    updatedAt,
  ];
}
